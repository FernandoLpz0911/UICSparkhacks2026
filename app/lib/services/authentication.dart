/// Authentication work here

import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    User? get currentUser => firebaseAuth.currentUser;   

    Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

    Future<void> signInWithEmailAndPassword(String email, String password) async {
        try {
            await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        } on FirebaseAuthException catch (e) {
            throw e.message ?? 'An error occurred during sign in.';
        }
    }

    Future<void> createAccountWithEmailAndPassword(String email, String password) async {
        try {
            await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        } on FirebaseAuthException catch (e) {
            throw e.message ?? 'An error occurred during account creation.';
        }
    }

    Future<void>    signOut() async {
        await firebaseAuth.signOut();
    }
    
}