//This imports the package required for Firebase Authentication
import 'package:firebase_auth/firebase_auth.dart';

//Creates custom class make the autheitcation calling in main more organized 
class AuthService{
    //Creates an an instance of FirebaseAuth to use its methods for authentication purposes
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    //Thsi is used to get the current user ID(email or anything and imediatley return the value
    User? get currentUser => firebaseAuth.currentUser;   

    //This is used to get the state of the user if they got validated or not
    Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

    //This is used to sign in and get the users email and password and throws an error if it is not valid.
    Future<void> signInWithEmailAndPassword(String email, String password) async {
        try {
            await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        } on FirebaseAuthException catch (e) {
            throw e.message ?? 'An error occurred during sign in.';
        }
    }

    //This is used to create an account and throws an error if something is wrong.
    Future<void> createAccountWithEmailAndPassword(String email, String password) async {
        try {
            await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        } on FirebaseAuthException catch (e) {
            throw e.message ?? 'An error occurred during account creation.';
        }
    }

    //This signs the user out of the app after they sign out and cthrows an error if something is wrong
    Future<void>    signOut() async {
        await firebaseAuth.signOut();
    }

}