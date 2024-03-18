import 'package:seller_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersDatabase {
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserInfor({required String id}) async => await usersCollection.doc(id).get();

  Future<void> createUser({required Map<String, dynamic> user}) async {
    final doc =   await usersCollection.doc(user["id"]).set(user).whenComplete(()  {
       usersCollection.doc(user["id"]).get();
    });

    return doc;
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> checkUserInDatabaseUseCase({required String password, required String email}) async {
    final result = await usersCollection.where("email", isEqualTo: email).where("password", isEqualTo: password).get();
    if (result.docs.isNotEmpty) {
      return result.docs.first;
    } else {
      return null;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> signUserInDatabaseUseCase({required String password, required String email}) async {
    final result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    if (result.user != null) {
      final doc = await usersCollection.doc(result.user!.uid).get();
      return doc;
    } else {
      return null;
    }
  }

  Future<UserCredential> signUpWithEmailAndPasswordUseCase({required String password, required String email}) =>
      firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
}
