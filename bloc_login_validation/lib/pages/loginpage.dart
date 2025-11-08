import 'package:bloc_login_validation/bloc/auth_bloc.dart';
import 'package:bloc_login_validation/pages/color_pallet.dart';
import 'package:bloc_login_validation/pages/homepage.dart';
import 'package:bloc_login_validation/widget/reusable_button.dart';
import 'package:bloc_login_validation/widget/text_form_feild.dart'
    show ReusableTextFormFeild;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

//login page
class _LoginpageState extends State<Loginpage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is FailedAuth) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.response)));
          }
          if (state is SuccsussAuth) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Homepage()),
              (route) => false,
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(20),

          child: SingleChildScrollView(
            primary: true,
            clipBehavior: Clip.hardEdge,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/Ellipse 1.svg"),
                Image.asset(
                  "assets/Ellipse 3.png",
                  alignment: Alignment(0.1, -0.1),
                ),
                Text(
                  "Login Verification",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: secondorywhite,
                  ),
                ),
                SizedBox(height: 14),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    verticalDirection: VerticalDirection.down,

                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.5,
                        ),
                        child: ReusableTextFormFeild(
                          isTagFiled: false,
                          controller: _emailController,
                          hint: "email",
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.name,
                          isShow: false,
                          maxLine: 1,
                          // validchecker: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return "Please enter email";
                          //   }

                          //   return null;
                          // },
                        ),
                      ),
                      SizedBox(height: 16),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.5,
                        ),
                        child: ReusableTextFormFeild(
                          isTagFiled: false,
                          controller: _passwordController,
                          hint: "password",
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.name,
                          isShow: false,
                          maxLine: 1,
                          // validchecker: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return "Please enter password";
                          //   }

                          //   return null;
                          // },
                        ),
                      ),
                      SizedBox(height: 16),
                      //sing in button
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.5,
                        ),
                        child: InkWell(
                          onTap: () {
                            //call the event when press the button
                            context.read<AuthBloc>().add(
                              RegisterButtonPressedEvent(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                          },
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is LoadingAuthIndicator) {
                                return ReusableButton(
                                  lable: "Sing Up",
                                  isLoad: true,
                                );
                              }
                              return ReusableButton(
                                lable: "Sing Up",
                                isLoad: false,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
