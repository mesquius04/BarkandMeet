class UserData {
  static List<User> users = [];

  static void addUser(String username, String email, String password) {
    users.add(User(username, email, password));
  }

  static bool validateUser(String username, String password) {
    for (var user in users) {
      if (user.username == username && user.password == password) {
        return true;
      }
    }
    return false;
  }
}

class User {
  final String username;
  final String email;
  final String password;

  User(this.username, this.email, this.password);
}
