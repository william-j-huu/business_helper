import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passController = TextEditingController();
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
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passController.text.trim()
        );
        Navigator.pushReplacementNamed(context, "/navigation_screen");
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
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading ? CircularProgressIndicator() : Text("Login"),
                )
            ),
            TextButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, "/signup_screen");
                },
                child: Text("New User? Create Account")
            )
          ],
        ),
      ),
    );
  }
}
