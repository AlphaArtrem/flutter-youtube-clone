import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtubeclone/helper/accounts.dart';

class UserDataBase{
  final CollectionReference _userData = FirebaseFirestore.instanceFor().collection('users');

  Future<String> addLikeVideo(Map videoDetails) async{
    Account user = Account();
    try{
      await _userData.doc(user.currentUser().email + '/liked').update({DateTime.now().toIso8601String() : videoDetails});
      return 'Success';
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}
