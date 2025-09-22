import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  final _passFinalController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  String? _error;


  Future<void> _submit() async{
    if(_formKey.currentState?.validate() ?? false){
      setState(() {
        _isLoading = true;
        _error = null;
      });

      try{
        // Todo: connect to firebase authentication and save data onto database

        // Authentication
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passFinalController.text.trim()
        );

        // Database
        final user = credential.user;
        if(user != null && _nameController.text.trim().isNotEmpty){
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
            {
              'name' : _nameController.text.trim(),
              'email' : _emailController.text.trim(),
              'createdAt' : FieldValue.serverTimestamp(),
            }
          );
        }

        // todo: navigate to the homescreen after having signed up

      }
      catch(e){
        setState(() {
          _error= "Signup Failed";
        });
      }
      finally{
        _isLoading = false;
      }

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller : _nameController,
              decoration: const InputDecoration(labelText: "Name"),
              obscureText: false,
              validator: (value) => value == null ? 'Enter a valid name' : null
            ),
            SizedBox(height: 16),
            TextFormField(
                controller : _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                obscureText: false,
                validator: (value) => value == null || !value.contains("@") ? 'Enter a valid email' : null
            ),
            SizedBox(height: 16),
            TextFormField(
                controller : _passController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: false,
                validator: (value) => value == null || value.length < 8 ? 'Enter a valid password' : null
            ),
            SizedBox(height: 16),
            TextFormField(
                controller : _passFinalController,
                decoration: const InputDecoration(labelText: "Confirm Password"),
                obscureText: false,
                validator: (value) => value == null || !(value == _passController.text) ? 'Passwords do not match' : null
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading ? CircularProgressIndicator() : Text("Sign Up"),
              )
            ),
            TextButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, "/login_screen");
                }, 
                child: Text("Account created? Go back to login"))
          ],
        ),
      ),
    );
  }
}
