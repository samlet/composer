import 'package:mqtt_client/mqtt_client.dart';
import 'package:typed_data/src/typed_buffer.dart';

String asString(Uint8Buffer message){
  return MqttPublishPayload.bytesToStringAsString(message);
}

