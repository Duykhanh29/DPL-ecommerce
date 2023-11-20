import 'dart:async';

import 'package:flutter/cupertino.dart';

class AppLifeCycleObsever extends WidgetsBindingObserver {
  static final AppLifeCycleObsever _observer = AppLifeCycleObsever._internal();

  AppLifeCycleObsever._internal();

  factory AppLifeCycleObsever() => _observer;

  final _streamController = StreamController<AppLifecycleState>.broadcast();

  Stream<AppLifecycleState> get status async* {
    yield* _streamController.stream;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    _streamController.add(state);
  }
}
