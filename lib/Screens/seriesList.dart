import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Screens/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class serieslist extends StatefulWidget {
  const serieslist({Key? key}) : super(key: key);
  @override
  State<serieslist> createState() => _serieslistState();
}
class _serieslistState extends State<serieslist> {
  @override
  void initState(){
    super.initState();
    initialize();
  }
  var len = 0;
  void initialize() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid).collection('series').doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      len = snap['Series'].length;
    });
  }
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
                        itemCount: len,
                        itemBuilder: (context,index){
                          DocumentSnapshot data = snapshot.data!.docs[0];
                          final item = data['Series'][index]['series name'] ;
                          return Dismissible(
                            key: Key(item),
                            onDismissed: (direction) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  loading()),
                              );
                              // if(item){
                              //   Duration(milliseconds: 200);
                              // }
                              setState(() {
                                  FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection("series").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                    "Series" : FieldValue.arrayRemove([{
                                      "series name" : data['Series'][index]['series name']
                                    }])
                                  }).then((value) {
                                    initialize();
                                  Navigator.pop(context);
                                  });
                              }
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('$item dismissed')));
                            },
                            // resizeDuration: Duration(milliseconds: 2000),
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
