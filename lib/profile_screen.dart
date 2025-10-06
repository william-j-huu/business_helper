import 'package:buisnesshelper/base_screen/base.dart';
import 'package:buisnesshelper/constants.dart';
import 'package:buisnesshelper/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  late String url;
  User? user;

  Future<void> ensureUserExist () async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set({
        'createdAt': FieldValue.serverTimestamp(),
        'name': '',
        'imageUrl' : ""
      });
    }
    else{
      url = doc.data()?["imageUrl"] as String;
    }
  }

  @override
  void initState(){
    super.initState();
    ensureUserExist();
    user = FirebaseAuth.instance.currentUser;
  }

  void showSettingsMenu() async{
    final action = await showModalBottomSheet(
        context: context,
        builder: (context) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                  onTap: () => Navigator.pop(context, "Logout"),
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text("Delete Account"),
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () => Navigator.pop(context, "Delete"),
                )
              ],
            )
        )
    );

    if (action == "Logout"){
      await FirebaseAuth.instance.signOut();
      if (mounted) Navigator.pushReplacementNamed(context, "/login_screen");
    }

    else if (action == "Delete"){
      try{
        final credentials = EmailAuthProvider.credential(
            email: user!.email!,
            password: await promptPassword()
        );
        await user?.reauthenticateWithCredential(credentials);
        await user?.delete();
        await FirebaseFirestore.instance.collection("users").doc(uid).delete();
        if (mounted) Navigator.pushReplacementNamed(context, "/login_screen");
      }
      catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Delete Account Failed"))
        );
      }
    }
  }

  Future<String> promptPassword() async{
    String password = "";
    await showDialog(
        context: context,
        builder: (context){
          final controller = TextEditingController();
          return AlertDialog(
            title: Text("Re-enter your password"),
            content: TextField(
              controller: controller,
              obscureText: true,
              decoration: InputDecoration(hintText: "Password"),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    password = controller.text;
                    Navigator.of(context).pop();
                  },
                  child: Text("Confirm")
              ),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")
              )
            ],
          );
        }
    );

    return password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Center(child: Text("Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: customGradient(primaryColor, secondaryColor)
          ),
        ),
        actions: [
          IconButton(onPressed: showSettingsMenu, icon: Icon(Icons.settings, size: 24, color: Colors.white,))
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("users").doc(uid).snapshots(),
        builder: (BuildContext build, snapshot){
          if (snapshot.hasError){
            return Text("Error");
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final name = data["name"] ?? "No name";

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                children: [
                  TitleCard(
                    leading: GestureDetector(
                      child: CircleAvatar(
                        radius: 50, backgroundImage: AssetImage("assets/userprofile.jpg"),
                      ),
                    ),
                    title: "${name}'s Business",
                    body: 'Local Cafe',
                    verify: true,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    margin: EdgeInsets.only(top: 25),
                    decoration: BoxDecoration(
                        gradient: customGradient(Colors.orange, Colors.green),
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Column(
                      children: [
                        Text("Business Performance", style: CardTitle,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                CardItem("48", "Annual Revenue"),
                                CardItem("150", "Customers"),
                              ],
                            ),
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("4.5", style: CardTitle,),
                                        Icon(Icons.star, size: 24, color: Colors.white,),
                                      ],
                                    ),
                                    Text("Rating", style: CardSubtitle)
                                  ],
                                ),
                                CardItem("5", "Employees"),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          );
        }
      )
    );
  }
}
