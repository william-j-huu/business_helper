import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: Icon(Icons.arrow_back, color: Colors.white,)),
        title: Center(child: Text("Technical Services", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: customGradient(primaryColor, secondaryColor)
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("services").snapshots(),
          builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
            if (snapshot.hasError){
              return Text("Error");
            }

            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }

            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, int index){
                final data = docs[index].data() as Map<String, dynamic>;
                final url = data["url"] ?? 'None';

                return GestureDetector(
                  onTap: (){},
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                        ),
                      )
                  ),
                );
              }
            );
          }
      ),
    );
  }
}
