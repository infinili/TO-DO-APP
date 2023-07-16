import 'package:firebase_remote_config/firebase_remote_config.dart';

class ConfigRepository {
  final FirebaseRemoteConfig _remoteConfig;

  ConfigRepository(this._remoteConfig);

  bool get usePurpleColor => _remoteConfig.getBool(_ConfigFields.usePurple);

  Future<void> init() async {
    _remoteConfig.setDefaults({
      _ConfigFields.usePurple: false,
    });
    await _remoteConfig.fetchAndActivate();
  }
}

abstract class _ConfigFields {
  static const usePurple = 'use_purple';
}
