import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}