
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testingapp/constants/routes.dart';
import 'package:testingapp/views/login_view.dart';
import 'package:testingapp/views/notes_view.dart';
import 'package:testingapp/views/register_view.dart';
import 'package:testingapp/views/verifyEmail_view.dart';
import 'firebase_options.dart';
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
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder:(context, snapshot) {
          
          switch (snapshot.connectionState){
            
            case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null){
              if (user.emailVerified){
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

