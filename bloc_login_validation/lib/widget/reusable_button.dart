import 'package:bloc_login_validation/pages/color_pallet.dart';
import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String lable;
  final bool isLoad;
  const ReusableButton({super.key, required this.lable, required this.isLoad});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: primaryYellow,
        boxShadow: [
          BoxShadow(
            color: secondoryBlack.withOpacity(0.2),
            offset: const Offset(1, 4),
            blurRadius: 5,
          ),
        ],
      ),
      child: Center(
        child:
            isLoad
                ? CircularProgressIndicator(
                  color: secondoryBlack,
                  strokeWidth: 8,
                )
                : Text(
                  lable,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
      ),
    );
  }
}
