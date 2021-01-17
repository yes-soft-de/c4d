import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:inject/inject.dart';

import 'ui/screen/profile_screen/profile_screen..dart';

@provide
class ProfileModule {
  final ProfileScreen profileScreen;

  ProfileModule(this.profileScreen) {
    YesModule.RoutesMap.addAll({
      ProfileRoutes.PROFILE_SCREEN: (context) => profileScreen
    });
  }
}