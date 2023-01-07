import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class serieslist extends StatefulWidget {
  const serieslist({Key? key}) : super(key: key);
  @override
  State<serieslist> createState() => _serieslistState();
}

class _serieslistState extends State<serieslist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection('series').snapshots(),
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
                              Text(data['Series'][0]['series name']),
                              Text(data['Series'][1]['series name']),
                              Text(data['Series'][2]['series name']),
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
