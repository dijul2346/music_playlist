import 'package:music_playlist/domain/library_model.dart';

class UserModel {
  late String userId;
  late String userName;
  late String userEmail;
  late String userPassword;
  late String userMobile;
  late String userAddress;
  UserModel(
      {required this.userId,
      required this.userName,
      required this.userEmail,
      required this.userPassword,
      required this.userMobile,
      required this.userAddress});
}

String globalUserId = '';
String globalusername = '';
List<MusicModel> globalMusicList = [];