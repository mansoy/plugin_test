import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class TxDeviceId {
  static const MethodChannel _channel = const MethodChannel('tx_device_id');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return Future.value(version);
  }

  ///
  ///Android广告ID
  ///
  static Future<String> get oaid async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return _channel.invokeMethod<String>('getOAID');
    }
    return Future.value('');
  }

  ///
  ///iOS广告ID
  ///
  static Future<String> get idfa async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return _channel.invokeMethod<String>('getIDFA');
    }
    return Future.value('');
  }
}
