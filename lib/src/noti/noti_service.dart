import 'dart:async';
import 'dart:io';
import 'package:bluecc_srv/utils.dart';
import 'package:logging/logging.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/src/typed_buffer.dart';

typedef MessageProcessor = Function(Uint8Buffer message, String receiveTopic);

class Noti {
  final _log = Logger('Noti');
  static final Noti _instance = Noti._internal();

  factory Noti() {
    return _instance;
  }

  Noti._internal();

  final client = MqttServerClient('localhost', slugId());
  var pongCount = 0; // Pong counter
  MessageProcessor? _processor;

  Future<void> establish({MessageProcessor? processor}) async {
    _processor=processor;

    client.logging(on: false);

    /// Set the correct MQTT protocol for mosquito
    client.setProtocolV311();

    /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
    client.keepAlivePeriod = 20;

    /// Add the unsolicited disconnection callback
    client.onDisconnected = onDisconnected;

    /// Add the successful connection callback
    client.onConnected = onConnected;

    /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
    /// You can add these before connection or change them dynamically after connection if
    /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
    /// can fail either because you have tried to subscribe to an invalid topic or the broker
    /// rejects the subscribe request.
    client.onSubscribed = onSubscribed;

    /// Set a ping received callback if needed, called whenever a ping response(pong) is received
    /// from the broker.
    client.pongCallback = pong;

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password and clean session,
    /// an example of a specific one below.
    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    _log.info('client connecting ...');
    client.connectionMessage = connMess;

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
    /// never send malformed messages.
    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      _log.info('client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      _log.info('socket exception - $e');
      client.disconnect();
    }

    /// Check we are connected
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      _log.info('mqtt client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      _log.info(
          'ERROR mqtt client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }

    /// Ok, lets try a subscription
    _log.info('Subscribing to the test/lol topic');
    const topic = 'plain/lol'; // Not a wildcard topic
    client.subscribe(topic, MqttQos.atMostOnce);

    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      var message = recMess.payload.message;
      var receiveTopic = c[0].topic;
      processMessage(message, receiveTopic);
    });

    /// If needed you can listen for published messages that have completed the publishing
    /// handshake which is Qos dependant. Any message received on this stream has completed its
    /// publishing handshake with the broker.
    client.published!.listen((MqttPublishMessage message) {
      _log.info(
          'Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
    });
  }

  void processMessage(Uint8Buffer message, String receiveTopic) {
    if(_processor!=null){
      _processor!(message, receiveTopic);
    }else {
      final pt = MqttPublishPayload.bytesToStringAsString(message);
      _log.info(
          'Change notification:: topic is <$receiveTopic>, payload is <-- $pt -->');
    }
  }

  void subscribe(String topic) {
    _log.info('Subscribing to the $topic topic');
    client.subscribe(topic, MqttQos.exactlyOnce);
  }

  void unsubscribe(String topic) {
    _log.info('Unsubscribing $topic');
    client.unsubscribe(topic);
  }

  Future<void> close() async {
    /// Wait for the unsubscribe message from the broker if you wish.
    await MqttUtilities.asyncSleep(1);
    _log.info('Disconnecting');
    client.disconnect();
    _log.info('Exiting normally');
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    _log.info('Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    _log.info('OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      _log.info('OnDisconnected callback is solicited, this is correct');
    } else {
      _log.info(
          'OnDisconnected callback is unsolicited or none, this is incorrect - exiting');
      exit(-1);
    }

    _log.info(' Pong count is $pongCount');
  }

  /// The successful connect callback
  void onConnected() {
    _log.info('OnConnected client callback - Client connection was successful');
  }

  /// Pong callback
  void pong() {
    _log.info('live check => Ping response client callback invoked');
    pongCount++;
  }

  void publish(String pubTopic, String msg) {
    final builder = MqttClientPayloadBuilder();
    // builder.addString('Hello from dart mqtt_client');
    builder.addString(msg);

    /// Publish it
    _log.info('Publishing our topic');
    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);
  }

  Future<void> wait(int seconds) async {
    _log.info('Sleeping....');
    await MqttUtilities.asyncSleep(seconds);
  }
}
