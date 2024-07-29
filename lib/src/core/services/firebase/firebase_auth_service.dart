import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> createUser({
    required name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(name);
      return null;
    } on FirebaseAuthException catch (e, s) {
      switch (e.code) {
        case 'email-already-in-use':
          log('MENSAGEM DE ERRO:', error: e, stackTrace: s);
          return 'Este e-mail já está sendo utilizado';
        case 'user-disabled':
          log('MENSAGEM DE ERRO:', error: e, stackTrace: s);
          return 'Esse usuário foi desabilitado';
        case 'invalid-email':
          return 'O endereço de e-mail não é válido';
        case 'operation-not-allowed':
          log('MENSAGEM DE ERRO:', error: e, stackTrace: s);
          return 'Este aplicativo não foi configurado para autenticação por meio de e-mail e senha';
        case 'weak-password':
          log('MENSAGEM DE ERRO:', error: e, stackTrace: s);
          return 'A senha digitada é muito fraca';
        default:
          log('MENSAGEM DE ERRO:', error: e, stackTrace: s);
          return 'Erro não identificado';
      }
    }
  }

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

  Future<String?> recovery({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return 'O e-mail digiteado é inválido';
        case 'user-not-found':
          return 'Usuário não cadastrado';
        default:
          return 'Erro não identificado';
      }
    }
  }
}
