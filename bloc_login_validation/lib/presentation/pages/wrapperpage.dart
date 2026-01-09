import 'package:bloc_login_validation/core/util/color_pallet.dart';
import 'package:bloc_login_validation/presentation/pages/loginpage.dart';
import 'package:bloc_login_validation/presentation/pages/main_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapperpage extends StatelessWidget {
  const Wrapperpage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: secondorywhite),
          );
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return MainWrapper();
          } if(snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                children: [
                  Center(
                    child: Text(
                      "this is error page ${snapshot.error}",
                      style: TextStyle(color: secondorywhite, fontSize: 24),
                    ),
                  ),
                ],
              ),
            );
          }
        }
        return Loginpage();
      },
    );
  }
}
