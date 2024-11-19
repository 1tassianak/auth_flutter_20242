import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Home"),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        // Após o logout, navegue de volta para a tela de login
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                        // Mensagem de feedback ao usuário
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Logout realizado com sucesso.')),
                        );
                      } catch (e) {
                        // Tratar erros inesperados no logout
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro ao fazer logout: $e')),
                        );
                      }
                    },
                    child: Text("Logout")
                ),
              ],
          ),
      ),
    );
  }
}
