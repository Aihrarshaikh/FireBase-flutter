import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class watchlist extends StatefulWidget {
  const watchlist({Key? key}) : super(key: key);
  @override
  State<watchlist> createState() => _watchlistState();
}
List<dynamic> ss = [];
void getm() async {

  DocumentSnapshot snapp = await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection('movies').doc(FirebaseAuth.instance.currentUser!.uid).get();
  // print(snapp['movies'].size());
  for(int i = 0;  i< 3;i++){
    print(snapp['movies'][i]['moviename']);
    ss[i] = snapp['movies'][i]['moviename'];
  }
}
class _watchlistState extends State<watchlist> {
  @override
  initState() {
    getm();
    print("ss");
    print(ss.length);
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
                        // DocumentSnapshot data = snapshot.data!.docs[0];
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
