import 'package:bloc_login_validation/core/util/color_pallet.dart';
import 'package:bloc_login_validation/presentation/bloc/auth_bloc.dart';
import 'package:bloc_login_validation/presentation/pages/loginpage.dart';
import 'package:bloc_login_validation/presentation/pages/main_wrapper.dart';
import 'package:bloc_login_validation/presentation/widget/reusable_button.dart';
import 'package:bloc_login_validation/presentation/widget/text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressontroller = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            padding: EdgeInsets.only(top: 48),

            child: SingleChildScrollView(
              primary: true,
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   "assets/Ellipse 3.png",
                  //   alignment: Alignment(0.1, -0.1),
                  // ),
                  Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: secondorywhite,
                    ),
                  ),
                  SizedBox(height: 14),
                  SvgPicture.asset(
                    "assets/registry-svgrepo-com.svg",
                    height: 128,
                    width: 128,
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
                            maxWidth: MediaQuery.of(context).size.width * 0.85,
                          ),
                          child: ReusableTextFormFeild(
                            isTagFiled: false,
                            controller: _emailController,
                            hint: "email",
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.emailAddress,
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
                        SizedBox(height: 14),
                        //username
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.85,
                          ),
                          child: ReusableTextFormFeild(
                            isTagFiled: false,
                            controller: _nameController,
                            hint: "username",
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.name,
                            isShow: false,
                            maxLine: 1,
                            // validchecker: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return "Please enter username";
                            //   }

                            //   return null;
                            // },
                          ),
                        ),

                        SizedBox(height: 14),
                        //address
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.85,
                          ),
                          child: ReusableTextFormFeild(
                            isTagFiled: false,
                            controller: _addressontroller,
                            hint: "address",
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.streetAddress,
                            isShow: false,
                            maxLine: 1,
                            // validchecker: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return "Please enter address";
                            //   }

                            //   return null;
                            // },
                          ),
                        ),
                        SizedBox(height: 14),
                        //discription
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.85,
                          ),
                          child: ReusableTextFormFeild(
                            isTagFiled: false,
                            controller: _discriptionController,
                            hint: "about you",
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.multiline,
                            isShow: false,
                            maxLine: 3,
                            // validchecker: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return "Please enter your discription";
                            //   }

                            //   return null;
                            // },
                          ),
                        ),
                        SizedBox(height: 14),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.85,
                          ),
                          child: ReusableTextFormFeild(
                            isTagFiled: false,
                            controller: _passwordController,
                            hint: "password",
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
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
                        SizedBox(height: 24),
                        //sing in button
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.85,
                          ),
                          child: InkWell(
                            onTap: () {
                              //call the event when press the button
                              context.read<AuthBloc>().add(
                                RegisterButtonPressedEvent(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  username: _nameController.text.trim(),
                                  address: _addressontroller.text.trim(),
                                  description:
                                      _discriptionController.text.trim(),
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
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
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
                                    builder: (context) => Loginpage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
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
      ),
    );
  }
}
