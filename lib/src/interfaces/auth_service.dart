abstract interface class AuthService {
  Future createUser(
      {required String name, String? photoURL, required String email, required String password});
  Future signInWithEmail({required String email, required String password});
  Future signOut();
  Future recovery({required String email});
}
