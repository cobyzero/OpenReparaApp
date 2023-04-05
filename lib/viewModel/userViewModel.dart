import 'package:openrepara_app/models/userModel.dart';
import 'package:openrepara_app/services/loginService.dart';

class ListUserViewModel {
  List<UserViewModel>? list;

  Future<void> checkLogin(String username, String password) async {
    final apiResult = await LoginService.checkLogin(username, password);

    list = [UserViewModel(apiResult)];
  }
}

class UserViewModel {
  UserModel usersModel;

  UserViewModel(this.usersModel);
}
