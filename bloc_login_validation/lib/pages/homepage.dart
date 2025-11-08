import 'package:bloc_login_validation/bloc/auth_bloc.dart';
import 'package:bloc_login_validation/pages/color_pallet.dart';
import 'package:bloc_login_validation/pages/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    //this rebuild entire scafold widget after state was changed
    //to avoid that and build whatevere widgets is neassasory use BlocBuilder
    //this is just for showing onther alternative approche
    //and this watch state where continously watches the state changes
    final authState = context.watch<AuthBloc>().state as SuccsussAuth;
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
          return Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [Text("HomePage"), Text(authState.userId)],
              ),
            ),
          );
        },
      ),
    );
  }
}
