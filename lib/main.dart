

import 'package:flutter/material.dart';
import 'package:testingapp/constants/routes.dart';
import 'package:testingapp/services/auth/auth_service.dart';
import 'package:testingapp/views/login_view.dart';
import 'package:testingapp/views/notes_view.dart';
import 'package:testingapp/views/register_view.dart';
import 'package:testingapp/views/verify_email_view.dart';

import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        mainRoute: (context) => const NotesView(),
        verifyEmailRoute:(context) => const VerifyEmailView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().intialize(),
        builder:(context, snapshot) {
          
          switch (snapshot.connectionState){
            
            case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null){
              if (user.isEmailVerified){
                return const NotesView();
              } else{
                
                return const VerifyEmailView();
              }
            } else{
              return const LoginView();
            }

            default:
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Home"),
                ) ,
                body: const Center(child:  CircularProgressIndicator()),

              );
          }
           
        },
        
      );
  }
}

