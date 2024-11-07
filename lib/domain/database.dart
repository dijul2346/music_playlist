import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_playlist/domain/library_model.dart';
import 'package:music_playlist/domain/user_model.dart';
import 'package:music_playlist/presentation/panel/music_home.dart';

Future<bool> checkLogin(UserModel user) async {
  bool flag = false;
  try {
    final userAuth = FirebaseAuth.instance;
    UserCredential userCredential = await userAuth.signInWithEmailAndPassword(
        email: user.userEmail, password: user.userPassword);
    if (userCredential.user != null) {
      flag = true;
      globalUserId = userCredential.user!.uid;
    }
  } catch (_) {
    return Future.value(flag);
  }
  return Future.value(flag);
}

Future<void> registerUser(UserModel user) async {
  final userAuth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user.userEmail, password: user.userPassword);

  if (userAuth != null) {
    await addUser(userAuth.user!.uid, user);
  }
}

Future<void> addUser(String userId, UserModel user) async {
  final firestore = await FirebaseFirestore.instance;
  print(user.userName);
  await firestore.collection('user').doc(userId).set({
    'name': user.userName,
    'email': user.userEmail,
    'mobile': user.userMobile,
    'address': user.userAddress
  });
}

Future<void> loadDatabase() async {
  final firebaseFirestore = FirebaseFirestore.instance
      .collection('music')
      .where('userId', isEqualTo: globalUserId)
      .get()
      .then((querySnapshot) {
    MusicList.clear();
    for (var doc in querySnapshot.docs) {
      MusicModel t = MusicModel(
          musicId: doc['musicId'],
          musicName: doc['musicName'],
          musicArtist: doc['musicArtist']);
      MusicList.add(t);
    }
  });
} 

Future<void> addTask(MusicModel t) async {
  await FirebaseFirestore.instance.collection('music').add({
    'musicId': t.musicId,
    'musicName': t.musicName,
    'musicArtist': t.musicArtist
  }).then((_) async {
    await loadDatabase();
  });
}
