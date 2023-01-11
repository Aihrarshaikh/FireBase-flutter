import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Screens/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
                          return Slidable(
                            key: Key(item),
                            startActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              dismissible: DismissiblePane(onDismissed: () {
                                setState(() {
                                  len-=1;
                                });
     FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection("series").doc(FirebaseAuth.instance.currentUser!.uid).update({
              "Series" : FieldValue.arrayRemove([{
                "series name" : data['Series'][index]['series name']
              }])
            });
     initialize();
                              Navigator.pop(context);}),
                              // All actions are defined in the children parameter.
                              children: const [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: doNothing,
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                                SlidableAction(
                                  onPressed: doNothing,
                                  backgroundColor: Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.share,
                                  label: 'Share',
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  flex: 2,
                                  backgroundColor: Color(0xFF7BC043),
                                  foregroundColor: Colors.white,
                                  icon: Icons.cancel,
                                  label: 'Back', onPressed:doNothing,
                                ),
                                SlidableAction(
                                  onPressed: doNothing,
                                  backgroundColor: Color(0xFF0392CF),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete_forever_outlined,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            // The child of the Slidable is what the user sees when the
                            // component is not dragged.
                            child: ListTile(title: Text(data['Series'][index]['series name'])),
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
void doNothing(BuildContext context) {}