import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_profile/ui/screen/activity_screen/activity_screen.dart';
import 'package:inject/inject.dart';

@provide
class ProfileModule {
  final ActivityScreen profileScreen;

  ProfileModule(this.profileScreen) {
    YesModule.RoutesMap.addAll({
      ProfileRoutes.PROFILE_SCREEN: (context) => profileScreen,
    });
  }
}