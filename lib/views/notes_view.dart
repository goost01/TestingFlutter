
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:testingapp/constants/routes.dart';
import 'package:testingapp/enums/menu_action.dart';
import 'package:testingapp/services/auth/auth_service.dart';


class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main"),
        actions: [
          PopupMenuButton<MenuActions>(
            onSelected: (value) async {
              switch (value) {
                
                case MenuActions.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  devtools.log(shouldLogout.toString());
                  if (shouldLogout){
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute, 
                      (_) => false);
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuActions>(
                value: MenuActions.logout,
                child: Text("Logout"),
                ),
              ];
            },
          )
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context){
  return showDialog<bool>(
    context: context, 
    builder: (context) {
      return AlertDialog(
        title: const Text("Sign Out"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop(false);    
          }, child: const Text("Cancel")),
          TextButton(onPressed: () {
            Navigator.of(context).pop(true);  
          }, child: const Text("log Out")),
        ],
      );
    },
  ).then((value) => value ?? false);
}