import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Método para registrar usuário com email e senha
  Future<String?> signInWithEmail(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Retorna null se a autenticação for bem-sucedida
    } on FirebaseAuthException catch (e, s) {
      switch (e.code) {
        case 'invalid-email':
          return 'E-mail inválido';
        case 'user-disabled':
          return 'Esse usuário foi desabilitado';
        case 'user-not-found':
          return 'Usuário não encontrado';
        case 'invalid-credential':
          log('MENSAGEM DE ERRO: $e $s');
          return 'E-mail ou senha não conferem!';
        default:
          log('MENSAGEM DE ERRO: $e $s');
          return 'Erro não identificado';
      }
    }
  }
  // Método para logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Método para verificar o estado de autenticação
  Stream<User?> get user {
    return _auth.authStateChanges();
  }
}
