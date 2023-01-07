import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class donewatching extends StatefulWidget {
  const donewatching({Key? key}) : super(key: key);
  @override
  State<donewatching> createState() => _donewatchingState();
}

class _donewatchingState extends State<donewatching> {
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection('watched').snapshots(),
                builder: ( BuildContext context , snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox(
                    height: 800,
                    child: ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context,index){
                          DocumentSnapshot data = snapshot.data!.docs[0];

                          return Center(child: Column(
                            children: [
                              Text(data['done watching'][0]['name']),
                              Text(data['done watching'][1]['name']),
                              Text(data['done watching'][2]['name']),
                            ],
                          ));
                        }),
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
