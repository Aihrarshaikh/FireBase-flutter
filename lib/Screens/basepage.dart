import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Screens/LoginScreen.dart';
import 'package:firebase/Screens/seriesList.dart';
import 'package:firebase/Screens/watchlist.dart';
import 'package:firebase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'donewatching.dart';
import 'homepage.dart';

final user = FirebaseAuth.instance.currentUser!;
class profilepage extends StatefulWidget {
  profilepage({super.key});
  @override
  State<profilepage> createState() => _profilepageState();
}
class _profilepageState extends State<profilepage> {
  @override
  void initState() {
    super.initState();
    initialize();
  }
  var username = "";
  var emailu = "";
  void initialize() async{
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState((){
      username = snap['name'];
      emailu = snap['Email'];
    });
    // print(snap['name']);
    // print(snap['Email']);
  }
  int select = 0;
  @override
  Widget build(BuildContext context) {
    Future<void> _signOut() async {
      await FirebaseAuth.instance.signOut().then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()),(route) => false));

    }
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          items:<BottomNavigationBarItem> [
            BottomNavigationBarItem(icon: Icon(Icons.person,
              color: Colors.white,),
              label: "profile",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt,color: Colors.white,),
                label: "Add"),
          ],
          currentIndex: select,
          onTap: (select) async {
            DocumentSnapshot snapp = await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection('movies').doc(FirebaseAuth.instance.currentUser!.uid).get();
            print(snapp['movies'][0]['moviename']);
            print("1");
            if(select==0){
              select ==1;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  profilepage()),
              );
            }else{
              select = 0;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => homepage()),
              );
            }
          },
        ),
    body : Container(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
                  SizedBox(
                    width: 100,
                  ),
                  IconButton(onPressed: _signOut, icon: Icon(Icons.exit_to_app))
        ]
              ),
              Padding(
                padding: EdgeInsets.only(left: 100, top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                    child: Text(username.toString()),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            Divider(
              color: Colors.black,
            ),
              ElevatedButton(
                  onPressed: (){
                    print(FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection('movies').get());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  watchlist()),
                    );
                  }, child: Text("Go to movie watch list"),
              ),
              ElevatedButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  serieslist()),
                );
              }, child: Text("Go to series watch list")),
              ElevatedButton(onPressed: (){ Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  donewatching()),
              );}
                  , child: Text("Go to your watched list")),
            ]
        ),
      ),
    ));
  }
}
