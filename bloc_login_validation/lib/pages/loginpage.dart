import 'package:bloc_login_validation/pages/color_pallet.dart';
import 'package:bloc_login_validation/widget/reusable_button.dart';
import 'package:bloc_login_validation/widget/text_form_feild.dart'
    show ReusableTextFormFeild;
import 'package:flutter/material.dart';
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
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
                        validchecker: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter email";
                          }

                          return null;
                        },
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
                        validchecker: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.5,
                      ),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // singIn(_nameController.text, _passwordController.text);
                          }
                        },
                        child: ReusableButton(
                          lable: "Sing Up",
                          isLoad: _isLoading,
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
    );
  }
}
