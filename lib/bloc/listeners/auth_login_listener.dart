abstract class AuthLoginListener{
  void success();
  void failed();
  void userNotFound();
  void wrongPassword();
  void invalidCredential();
}