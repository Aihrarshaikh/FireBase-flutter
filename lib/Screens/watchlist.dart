import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loading.dart';
class watchlist extends StatefulWidget {
  const watchlist({Key? key}) : super(key: key);
  @override
  State<watchlist> createState() => _watchlistState();
}

class _watchlistState extends State<watchlist> {
  @override
  void initState(){
    super.initState();
    initialize();
  }
  var len = 0;
  void initialize() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid).collection('movies').doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      len = snap['movies'].length;
    });
  }
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
                        itemCount: len,
                        itemBuilder: (context,index){
                          DocumentSnapshot data = snapshot.data!.docs[0];
                          final item = data['movies'][index]['moviename'] ;
                          return Dismissible(
                            key: Key(item),
                            onDismissed: (direction) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  loading()),
                              );
                              setState(() {
                                FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection("movies").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                  "movies" : FieldValue.arrayRemove([{
                                    "moviename" : data['movies'][index]['moviename']
                                  }])
                                }).then((value) {initialize();
                                Navigator.pop(context);
                                });
                              }
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('$item dismissed')));
                            },
                            child: ListTile(
                              title: Text(item),
                            ),
                          );
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
