// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/password_screen.dart';
import 'package:flutter_project/screens/profile_screen.dart';
import 'package:flutter_project/screens/splash_screen.dart';

import '../const_values.dart';
// ignore: unused_import
import '../custButton.dart';
import '../general.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextButton(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) {
                return const ProfileScreen();
              },
              ),
              );
            }, child: const Text("Profile",style: TextStyle(
                fontSize: 25)),),
            const SizedBox(width: 10,),
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const PasswordScreen();
                  },
                ),
              );
            }, child: const Text(" Update PassWord",style: TextStyle(
                fontSize: 25)),),
            const SizedBox(width: 10,),
            TextButton(onPressed: (){
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    icon: const Icon(Icons.logout_sharp),
                    content: const Text("Are You Sure You Want To LogOut"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),

                      ),
                      TextButton(
                        onPressed: () async {
                          await General.remove(ConsValues.ID);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const splashScreen();
                              },
                            ),
                          );
                        },
                        child: const Text("OK"),

                      ),

                    ],
                  );
                },
              );
            },
              child: const Text("LogOut",style: TextStyle(
                fontSize: 25)),),
            const SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}
