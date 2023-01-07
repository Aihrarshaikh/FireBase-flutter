import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class watchlist extends StatefulWidget {
  const watchlist({Key? key}) : super(key: key);
  @override
  State<watchlist> createState() => _watchlistState();
}

class _watchlistState extends State<watchlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection('movies').snapshots(),
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
                          print("length");
                          print(data['movies'].length);
                          return Center(child: Column(
                            children: [
                              Text(data['movies'][0]['moviename']),
                              Text(data['movies'][1]['moviename']),
                              Text(data['movies'][2]['moviename']),
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
