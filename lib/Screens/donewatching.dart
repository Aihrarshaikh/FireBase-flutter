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
  void initState() {
    super.initState();
    initialize();
  }
  var len = 0;
  void initialize() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid).collection('watched').doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      len = snap['done watching'].length;
    });
  }

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
                        itemCount: len,
                        itemBuilder: (context,index){
                          DocumentSnapshot data = snapshot.data!.docs[0];
                          final item = data['done watching'][index]['name'] ;
                          return Dismissible(
                            key: Key(item),
                            onDismissed: (direction) {
                              setState(() {
                               FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection("watched").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                    "done watching" : FieldValue.arrayRemove([{
                                      "name" : data['done watching'][index]['name']
                                    }])
                               });
                               initialize();
                              });
                              // Then show a snackbar.
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
