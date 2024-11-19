import 'package:auth_firebase/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'login.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    title: "Autenticação",
    //home: Login(),
    home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          if(snapshot.hasData){
            return Home();
          }
          return Login();
        }
    )
  ));
}
