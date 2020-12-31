import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:inject/inject.dart';

@provide
@singleton
class Logger {
  void info(String tag, String msg) {
    String time = DateTime.now().toString();
    print('$time: \t $tag \t $msg');
  }

  void warn(String tag, String msg) {
    String time = DateTime.now().toString();
    print('$time: \t $tag \t $msg');
  }

  void error(String tag, String msg) {
    String time = DateTime.now().toString();
    print('$time: \t $tag \t $msg');
    //TODO : uncomment this later
//    FirebaseCrashlytics.instance
//        .recordError('$time: \t $tag \t $msg', StackTrace.current??'');
  }
}
