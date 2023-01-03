import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final user = FirebaseAuth.instance.currentUser!;

class homescreen extends StatefulWidget {
  homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }
  String username = "a";
  void initialize() async{
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('Users').doc().get();
    username = snap.id;
  }

  // @override
  // void initState() {
  //   super.initState();
  //
  //   myId = snap['name'];
    // should be myId = snap.get('name');
 //  void initState() {
 //    super.initState();
 //    getdata();
 //  }
 // void getdata() async{
 //   DocumentSnapshot snap = await FirebaseFirestore.instance.collection('Users').doc(await FirebaseAuth.instance.currentUser!.uid).get() as DocumentSnapshot<Object?>;
 //   username = snap as String;
 //    // setState(() {
 //    //   username = value.data('name').toString();
 //    // });
 //  }
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
              Text(user.email!)
            ]),
      ),
    );
  }
}