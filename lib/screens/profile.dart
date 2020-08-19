import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:youtubeclone/helper/accounts.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Account _account = Account();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    GoogleSignInAccount user = _account.currentUser();
    return Scaffold(
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: ClipOval(
                child: Image.network(user.photoUrl),
              ),
              radius: size.width * 0.2,
            ),
            SizedBox(height: 20,),
            Text(user.displayName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
            SizedBox(height: 10,),
            Text(user.email, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey[400]),),
            SizedBox(height: 20,),
            FlatButton.icon(
                onPressed: () async{
                  await _account.signOut();
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.power_settings_new),
                label: Text('Sign Out')
            )
          ],
        ),
      ),
    );
  }
}
