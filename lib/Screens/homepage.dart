import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

List<String> movielist = [];
String movei ="";
class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed:(){
                 showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       return AlertDialog(
                         scrollable: true,
                         title: Text('ADD'),
                         content: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Form(
                             child: Column(
                               children: <Widget>[
                                 TextFormField(
                                   decoration: InputDecoration(
                                     labelText: 'movie',
                                   ),
                                   onChanged: (str){
                                     setState(() {
                                       movei = str;
                                     });
                                   },
                                 ),
                               ],
                             ),
                           ),
                         ),
                         actions: [
                           ElevatedButton(
                               child: Text("Submit"),
                               onPressed: () {
                                 print(movei);
                                 FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                   'movies' : FieldValue.arrayUnion([{
                                   "moviename" : movei
                                   }])
                                 }).then((value) => {
                                   Navigator.pop(context)
                                 });
                               })

                         ],
                       );
                     });}, child: Text("ADD MOVIE"),
              ),
              ElevatedButton(onPressed:(){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: Text('ADD series'),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'SEries',

                                  ),
                                  onChanged: (str){
                                    setState(() {
                                      movei = str;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                              child: Text("add"),
                              onPressed: () {
                                print(movei);
                                FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                  'Series' : FieldValue.arrayUnion([{
                                    "series name" : movei
                                  }])
                                }).then((value) => {
                                  Navigator.pop(context)
                                });
                              })
                        ],
                      );
                    });}, child: Text("ADD SERIES"),
              ),
              ElevatedButton(onPressed:(){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: Text('add'),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'watchd',
                                  ),
                                  onChanged: (str){
                                    setState(() {
                                      movei = str;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                              child: Text("Submit"),
                              onPressed: () {
                                print(movei);
                                FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                  'done watching' : FieldValue.arrayUnion([{
                                    "name" : movei
                                  }])
                                }).then((value) => {
                                  Navigator.pop(context)
                                });
                              })
                        ],
                      );
                    });}, child: Text("ADD WATCHED"),
              )]
        ),
      ),
    );
  }
}
