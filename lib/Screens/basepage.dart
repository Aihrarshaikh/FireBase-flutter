import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    print(snap['name']);
    print(snap['Email']);
  }
  int select = 0;
  @override
  Widget build(BuildContext context) {
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
          onTap: (select){
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
              Text(username.toString()),
              Text(emailu.toString())
            ]),
      ),
    ));
  }
}