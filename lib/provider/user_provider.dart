import 'package:flutter_provider_st/models/user.dart';
import 'package:flutter_provider_st/provider/profile_change_notifier.dart';

class UserProvider extends ProfileChangeNotifier {
  User get user => profile.user;

  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => profile.token.isNotEmpty;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User user) {
    if (user.login != profile.user.login) {
      profile.lastLogin = profile.user.login;
      profile.user = user;
      notifyListeners();
    }
  }
}
