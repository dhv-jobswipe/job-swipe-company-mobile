import 'package:pbl5/models/user/user.dart';

class AppData {
  User? user;

  void updateUser(User? newUser) {
    user = newUser;
  }

  void clear() {
    user = null;
  }
}
