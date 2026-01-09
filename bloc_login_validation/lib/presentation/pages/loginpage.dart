import 'package:bloc_login_validation/core/util/color_pallet.dart';
import 'package:bloc_login_validation/presentation/bloc/auth_bloc.dart';
import 'package:bloc_login_validation/presentation/pages/main_wrapper.dart';
import 'package:bloc_login_validation/presentation/pages/registerpage.dart';
import 'package:bloc_login_validation/presentation/widget/reusable_button.dart';
import 'package:bloc_login_validation/presentation/widget/text_form_feild.dart'
    show ReusableTextFormFeild;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
              MaterialPageRoute(builder: (context) => MainWrapper()),
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
              // mainAxisSize: MainAxisSize.max,
              // textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(
                //   "assets/Ellipse 3.png",
                //   alignment: Alignment(0.1, -0.1),
                // ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Login Verification",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: secondorywhite,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                SvgPicture.asset(
                  "assets/login-lock-refresh-svgrepo-com.svg",
                  height: 128,
                  width: 128,
                ),
                SizedBox(height: 24),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.85,
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
                      SizedBox(height: 20),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.85,
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
                      SizedBox(height: 20),
                      //sing in button
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.85,
                        ),
                        child: InkWell(
                          onTap: () {
                            //call the event when press the button
                            context.read<AuthBloc>().add(
                              LoginButtonPressedEvent(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                          },
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is LoadingAuthIndicator) {
                                return ReusableButton(
                                  lable: "Login",
                                  isLoad: true,
                                );
                              }
                              return ReusableButton(
                                lable: "Login",
                                isLoad: false,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      //go to register page
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: secondorywhite,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Registerpage(),
                                ),
                              );
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: primaryYellow,
                              ),
                            ),
                          ),
                        ],
                      ),
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
