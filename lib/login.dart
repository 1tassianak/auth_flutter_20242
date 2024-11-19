import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void _login() async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _senhaController.text,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home(),
          )
      );
    } on FirebaseAuthException catch (e){

    }
  }

  void _registrar() async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _senhaController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Conta criada com sucesso!")),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          )
      );
    }on FirebaseAuthException catch (e){
      String errorMsg;

      switch (e.code){
        case 'email-already-in-use':
          errorMsg = "Este e-mail já está em uso";
          break;
        case 'invalid-email':
          errorMsg = "O e-mail é inválido";
          break;
        case 'operation-not-allowed':
          errorMsg = "O registro com e-mail e senha foi desativado";
          break;
        case 'weak-password':
          errorMsg = "A senha é muito fraca";
          break;
        default:
          errorMsg = "Occoreu um erro ao criar a conta. Tente novamente.";
          break;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "E-mail",
              ),
            ),
            TextField(
              obscureText: true,
              controller: _senhaController,
              decoration: InputDecoration(
                hintText: "Senha",
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _login,
                  child: Text("Login"),
                ),
                ElevatedButton(
                  onPressed: _registrar,
                  child: Text("Registrar"),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
