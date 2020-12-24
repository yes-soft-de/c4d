import 'app.component.dart' as _i1;
import 'dart:async' as _i5;
import '../../main.dart' as _i6;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();



  static _i5.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i6.MyApp _createMyApp() => _i6.MyApp(
  );
  @override
  _i6.MyApp get app => _createMyApp();
}
