import 'package:flutter/material.dart';
import 'package:todo/ui/theme.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.label,
    required this.ontap,
  }) : super(key: key);

  final String label;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          color: primaryClr,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: ontap,
    );
  }
}
