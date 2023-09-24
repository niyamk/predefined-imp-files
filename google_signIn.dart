import 'dart:developer';

import 'package:surat_weavers_new/library.dart';

GoogleSignIn googleSignIn = GoogleSignIn();

String? name;
String? email;
bool? isNewUser;
String? imageUrl;

Future<String> otpVerificationStatus() async {
  String otpVerificationDone = 'nope';
  if(kFirebase.currentUser != null) {
    log('kfirebase is not null');
    final otp1 = await FirebaseFirestore.instance
        .collection('otpVerification')
        .doc(kFirebase.currentUser!.uid.toString())
        .get()
        .then((value) {
      if (value.exists) {
        otpVerificationDone = value.data()!['otpVerification'];
      }
    });
  }
  return otpVerificationDone;

}

Future signInWithGoogle() async {
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

  final AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken);

  UserCredential authresult =
      await FirebaseAuth.instance.signInWithCredential(authCredential);
  User? user = authresult.user;

  name = user!.displayName;
  email = user.email;
  isNewUser = authresult.additionalUserInfo!.isNewUser;
  imageUrl = user.photoURL;

  final User? currentUser = FirebaseAuth.instance.currentUser;
  assert(user.uid == currentUser!.uid);

  print('signInWithGoogle succeeded: $user');
  return '$user';
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  name = '';
  email = '';

  print("User Signed Out");
}
