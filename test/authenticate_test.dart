import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/domain/services/authenticate_service.dart';

void main() {
  group('Authentication Test', () {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final service = AuthenticateService(_firebaseAuth);
    test('Check Sign In Correct', () async {
      String ans = await service.signIn(email: "ranjanpadmakiran@gmail.com", password: "ranjan2001");
      expect(ans, "Signed In");
    });

    test("Check Sign in Wrong", () async {
      String ans = await service.signIn(email: "ranjanpadmakiran@gmail.com", password: "ranjan201");
      print(ans);
    });
  });
}
