import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seven_manager/src/core/services/firebase/cloud_firestore.dart';
import 'package:seven_manager/src/model/churchs_model.dart';
import 'package:seven_manager/src/model/persons_model.dart';

class AuthServiceFirebaseImpl {
  AuthServiceFirebaseImpl({
    required FirebaseAuth auth,
  }) : _auth = auth;

  final FirebaseAuth _auth;

  final CloudFirestore _cloudFirestore = CloudFirestore('churchs');

  Future<String?> createUser({
    required String namePerson,
    required String birth,
    required String cpf,
    required String malePerson,
    required String whastAppPerson,
    required String numberPerson,
    required String cityPerson,
    required String zipCodePerson,
    required String statePerson,
    required String streetPerson,
    required bool isPostalServicePerson,
    String? imageAvatar,
    required String emailPerson,
    required String password,
    String? urlImageLogo,
    required String districtChuchs,
    required String cityChuchs,
    required String zipCodeChuchs,
    required String streetChuchs,
    required String stateChuchs,
  }) async {
    try {
      // Cria o usuário no Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailPerson, password: password);
      String userId = userCredential.user!.uid;

      // Função auxiliar para criar a igreja se necessário
      Future<String?> createChurch() async {
        // Verifica se a igreja já existe
        QuerySnapshot querySnapshot = await _cloudFirestore.getByField(
            fieldName: districtChuchs, value: districtChuchs);

        if (querySnapshot.docs.isNotEmpty) {
          return querySnapshot.docs.first.id;
        }

        // Cria a igreja
        final newChurch = ChurchsModel(
          districtChuchs: districtChuchs,
          urlImageLogo: urlImageLogo,
          cityChuchs: cityChuchs,
          zipCodeChuchs: zipCodeChuchs,
          streetChuchs: streetChuchs,
          stateChuchs: stateChuchs,
        );
        DocumentReference docRef =
            await _cloudFirestore.create(data: newChurch.toMap());
        return docRef.id;
      }

      // Tenta criar a igreja e obtém o ID
      String? churchId;
      try {
        churchId = await createChurch();
      } on FirebaseException catch (e) {
        // Erro ao criar a igreja
        await userCredential.user!.delete();
        return 'Erro ao criar a igreja: ${e.message}';
      }

      if (churchId == null) {
        // Igreja não criada, mas usuário criado sem problemas, retorna null
        return userId;
      }

      // Cria o usuário na coleção "persons"
      final newPerson = PersonsModel(
        idChurch: churchId,
        malePerson: malePerson,
        namePerson: namePerson,
        imageAvatar: imageAvatar,
        birth: birth,
        cpf: cpf,
        emailPerson: emailPerson,
        whastAppPerson: whastAppPerson,
        zipCodePerson: zipCodePerson,
        numberPerson: numberPerson,
        cityPerson: cityPerson,
        statePerson: statePerson,
        isPostalServicePerson: isPostalServicePerson,
        streetPerson: streetPerson,
      );
      try {
        await _cloudFirestore.createDocumentWithSpecificId(
            'persons', userId, newPerson.toMap());
      } on FirebaseException catch (e) {
        // Erro ao criar a pessoa
        await userCredential.user!.delete();
        return 'Erro ao criar a pessoa: ${e.message}';
      }

      return null;
    } on FirebaseAuthException catch (e) {
      Map<String, dynamic> errorMenssages = {
        'invalid-email': 'E-mail inválido',
        'user-disabled': 'Esse usuário foi desabilitado',
        'user-not-found': 'Usuário não encontrado',
        'email-already-in-use': 'Já existe uma conta com este e-mail'
      };

      final errorMenssage = errorMenssages[e.code];

      // Erro ao criar o usuário (provavelmente erro de autenticação)
      return 'Erro ao criar usuário: ${errorMenssage ?? 'Erro não identificado'}';
    } catch (e) {
      // Outros erros
      return 'Erro desconhecido: $e';
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
          return 'O e-mail digitado é inválido';
        case 'user-not-found':
          return 'Usuário não cadastrado';
        default:
          return 'Erro não identificado';
      }
    }
  }
}
