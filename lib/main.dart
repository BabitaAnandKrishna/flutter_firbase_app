import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DisplayCollection(),
    );
  }
}

class DisplayCollection extends StatefulWidget {
  @override
  _DisplayCollectionState createState() => _DisplayCollectionState();
}

class _DisplayCollectionState extends State<DisplayCollection> {
  //final ref = FireStore.instance.collection("States&Capitals");
  final Ref = Firestore.instance.collection("States&capitals");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("States And Capitals"),
        ),
        body: Column(
          children: [
            StreamBuilder(
              stream: Ref.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Container(
                      height: 500,
                      child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 100 ,
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot
                                        .data.documents[index].data['States'],
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700
                                    ),),
                                    Text(snapshot
                                        .data.documents[index].data['Capitals'],
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700
                                      ),),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ));
  }
}
