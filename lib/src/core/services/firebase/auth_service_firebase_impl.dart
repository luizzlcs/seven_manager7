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

  CloudFirestore _cloudFirestore = CloudFirestore('churchs');
  // final FirebaseFirestore;
  
  String idChurchs = '';
  String emailUser = '';
  String idUser = '';


  Future<void> createChurchs({
    required String districtChuchs,
    required String cityChuchs,
    required String zipCodeChuchs,
    required String streetChuchs,
    required String stateChuchs,
  }) async {
    await FirebaseFirestore.instance
        .runTransaction((Transaction transaction) async {
      final firestoreService = CloudFirestore('churchs');
      // final churchName = districtChuchs;

      // Verifica se a igreja já existe
      QuerySnapshot querySnapshot = await firestoreService.getByField(
          fieldName: districtChuchs, value: districtChuchs);

      // Verifica se a igreja já existe
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        log('Documento encontrado: ${documentSnapshot.data()}');
      } else {
        log('Nenhum documento encontrado.');
        log('Criando novo documento...');

        // Cria o documento da igreja
        final newChurchs = ChurchsModel(
          districtChuchs: districtChuchs,
          cityChuchs: cityChuchs,
          zipCodeChuchs: zipCodeChuchs,
          streetChuchs: streetChuchs,
          stateChuchs: stateChuchs,
        );

        DocumentReference docRef =
            await _cloudFirestore.create(data: newChurchs.toMap());

        idChurchs = docRef.id;

        log('Novo documento criado com sucesso ID: $docRef.');
      }
    });
  }

  Future<void> createPersons({
    required String namePerson,
    required String emailPerson,
    required String dateOfBirthPerson,
    required String cpf,
    required String malePerson,
    required String whastAppPerson,
    required String numberPerson,
    required String cityPerson,
    required String zipCodePerson,
    required String statePerson,
    required String streetPerson,
    required bool isPostalServicePerson,
    String? photoURL,
  }) async {
    final newPerson = PersonsModel(
      idChurch: idChurchs,
      malePerson: malePerson,
      namePerson: namePerson,
      dateOfBirthPerson: dateOfBirthPerson,
      cpf: cpf,
      emailPerson: emailUser,
      whastAppPerson: whastAppPerson,
      zipCodePerson: zipCodePerson,
      numberPerson: numberPerson,
      cityPerson: cityPerson,
      statePerson: statePerson,
      isPostalServicePerson: isPostalServicePerson,
      streetPerson: streetPerson,
    );

    // Cria o documento do usuário na coleção "pessoas"

    await _cloudFirestore.createDocumentWithSpecificId(
        'persons', idUser, newPerson.toMap());
    // await _cloudFirestore.create(data: newPerson.toMap());
  }

  Future<String?> createUser({
    required String namePerson,
    // required String dateOfBirthPerson,
    // required String cpf,
    // required String malePerson,
    // required String whastAppPerson,
    // required String numberPerson,
    // required String cityPerson,
    // required String zipCodePerson,
    // required String statePerson,
    // required String streetPerson,
    // required bool isPostalServicePerson,
    // String? photoURL,
    required String emailPerson,
    required String password,
    // required String districtChuchs,
    // required String cityChuchs,
    // required String zipCodeChuchs,
    // required String streetChuchs,
    // required String stateChuchs,
  }) async {
    // Cria o usuário no Firebase Authentication
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: emailPerson, password: password);
    // Obtém
    //  o UID do usuário recém-criado
     idUser = userCredential.user!.uid;
     emailUser = emailPerson;

    // Transação para garantir a consistência dos dados
    // await FirebaseFirestore.instance
    //     .runTransaction((Transaction transaction) async {
    //   final firestoreService = CloudFirestore('churchs');
    //   // final churchName = districtChuchs;

    //   // Verifica se a igreja já existe
    //   QuerySnapshot querySnapshot = await firestoreService.getByField(
    //       fieldName: districtChuchs, value: districtChuchs);

    //   String idNewChurch = '';

    //   // Verifica se a igreja já existe
    //   if (querySnapshot.docs.isNotEmpty) {
    //     DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
    //     log('Documento encontrado: ${documentSnapshot.data()}');
    //   } else {
    //     log('Nenhum documento encontrado.');
    //     log('Criando novo documento...');

    //     // Cria o documento da igreja
    //     final newChurchs = ChurchsModel(
    //       districtChuchs: districtChuchs,
    //       cityChuchs: cityChuchs,
    //       zipCodeChuchs: zipCodeChuchs,
    //       streetChuchs: streetChuchs,
    //       stateChuchs: stateChuchs,
    //     );

    //     DocumentReference docRef =
    //         await _cloudFirestore.create(data: newChurchs.toMap());

    //     idNewChurch = docRef.id;

    //     log('Novo documento criado com sucesso ID: $docRef.');
    //   }

    //   // _cloudFirestore = CloudFirestore('persons');

    //   final newPerson = PersonsModel(
    //     idChurch: uid,
    //     malePerson: malePerson,
    //     namePerson: namePerson,
    //     dateOfBirthPerson: dateOfBirthPerson,
    //     cpf: cpf,
    //     emailPerson: emailPerson,
    //     whastAppPerson: whastAppPerson,
    //     zipCodePerson: zipCodePerson,
    //     numberPerson: numberPerson,
    //     cityPerson: cityPerson,
    //     statePerson: statePerson,
    //     isPostalServicePerson: isPostalServicePerson,
    //     streetPerson: streetPerson,
    //   );

    //   // Cria o documento do usuário na coleção "pessoas"

    //   await _cloudFirestore.createDocumentWithSpecificId(
    //       'persons', uid, newPerson.toMap());
      // await _cloudFirestore.create(data: newPerson.toMap());
    // });
    return null;
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
