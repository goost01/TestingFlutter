
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testingapp/views/login_view.dart';
import 'package:testingapp/views/register_view.dart';
import 'package:testingapp/views/verifyEmail_view.dart';

import 'firebase_options.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/login/':(context) => const LoginView(),
        '/register/':(context) => const RegisterView(),
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
                print("Email Verified");
              }else{
                return const VerifyEmailView();
              }
              
            }else{
              return const LoginView();
            }
            
            return const Text("done");
              
            
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

