import 'package:bloc_login_validation/core/util/color_pallet.dart';
import 'package:bloc_login_validation/presentation/bloc/auth_bloc.dart';
import 'package:bloc_login_validation/presentation/pages/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            //ratherthan watch read is one time execute method
            onPressed: () {
              context.read<AuthBloc>().add(LogoutButtonPressedEvent());
            },
            icon: Icon(Icons.logout, size: 28, color: secondorywhite),
          ),
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is FailedAuth) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.response)));
          }
          if (state is InitialAuth) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Loginpage()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingAuthIndicator) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is SuccsussAuth) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back,",
                      style: TextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.bold,
                        color: secondorywhite,
                      ),
                    ),
                    Text(
                      state.user.username,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: primaryYellow,
                      ),
                    ),
                    SizedBox(height: 14),
                    Center(
                      child: Text(
                        "What are you up today?",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: secondorywhite,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: Lottie.asset(
                        fit: BoxFit.contain,
                        width: 350,
                        height: 350,

                        "assets/Live chatbot.json",
                        animate: true,
                        repeat: true,
                        frameRate: FrameRate(24),
                      ),
                    ),
                    // Text("Details:", style: TextStyle(fontSize: 18)),
                    // SizedBox(height: 10),
                    // Text("Email: ${state.user.email}"),
                    // Text("Address: ${state.user.address}"),
                    // Text("Description: ${state.user.discription}"),
                  ],
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
