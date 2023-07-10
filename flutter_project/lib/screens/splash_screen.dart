import 'dart:async';
import 'package:flutter/material.dart';
import '../const_values.dart';
import '../general.dart';
import 'adminMain_screen.dart';
import 'login_screen.dart';
import 'main_screen.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  //checkUserLogin()
  // {
  //     General.getPrefString(ConsValues.ID, "").then(
  //           (value) {
  //         if (value == "") {
  //           Timer(
  //             const Duration(seconds: 3),
  //                 () => Navigator.of(context).pushReplacement(
  //               MaterialPageRoute(
  //                 builder: (BuildContext context) => const loginScreen(),
  //               ),
  //             ),
  //           );
  //         } else{
  //           General.getPrefString(ConsValues.USERTYPE,"").then((value) {
  //             if(value == "2"){
  //               Timer(
  //                 const Duration(seconds: 3),
  //                     () => Navigator.of(context).pushReplacement(
  //                   MaterialPageRoute(
  //                     builder: (BuildContext context) => const mainAdminScreen(),
  //                   ),
  //                 ),
  //               );
  //             } else{
  //               Timer(
  //                 const Duration(seconds: 3),
  //                     () => Navigator.of(context).pushReplacement(
  //                   MaterialPageRoute(
  //                     builder: (BuildContext context) => const MainScreen(),
  //                   ),
  //                 ),
  //               );
  //             }
  //           });
  //
  //         }
  //       },
  //     );
  //   }


  @override
    void initState(){
      super.initState();
      //checkUserLogin();
      Timer(
        const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const loginScreen(),
            ),
            ),
      );

    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Image.asset('assets/images/logo.png'),
        ),
      );
    }

}
