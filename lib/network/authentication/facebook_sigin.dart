import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FaceBookSiginAuthentication {
  Future<LoginResult> loginWithFacebook() =>
      FacebookAuth.i.login(permissions: ['public_profile', 'email']);
}
