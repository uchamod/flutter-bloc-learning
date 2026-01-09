import 'package:bloc_login_validation/domain/entities/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _userCollection = FirebaseFirestore.instance
      .collection("user");
  Future<UserModel> getUserDetails() async {
    User? user = _auth.currentUser;
    DocumentSnapshot snapshot = await _userCollection.doc(user!.uid).get();

    return UserModel.fromJson((snapshot.data() as Map<String, dynamic>));
  }

  //signup user from emaol and password
  Future<UserCredential> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Error creating user: ${(e.code)}');
      throw Exception((e.code));
    } catch (err) {
      print("user_authentication_error: ${err.toString()}");
      throw Exception(err.toString());
    }
  }

  //singin user using email and password
  Future<void> singInUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print('Error signing in: ${(e.code)}');
      throw Exception(e.message ?? "Authentication failed");
    } catch (err) {
      print("error while SingIn: ${err.toString()}");
      throw Exception(err.toString());
    }
  }

  //save new user in database
  Future<UserModel> saveNewUser(
    String email,
    String password,
    String discription,
    String username,
    String address,
  ) async {
    try {
      //create new user
      UserCredential newUser = await registerUser(email, password);

      String userid = newUser.user!.uid;
      UserModel userModel = UserModel(
        userId: userid,
        username: username,
        userpassword: password,
        address: address,
        discription: discription,
        email: email,
      );

      await _userCollection.doc(userid).set(userModel.toJson());
      return userModel;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  //singout user
  Future<void> singOut() async {
    try {
      await _auth.signOut();
    } catch (err) {
      print("sing out error : ${err.toString()}");
      throw Exception(err);
    }
  }
}
