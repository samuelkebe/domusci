import 'package:flutter/material.dart';

class HidenBalanceWidget extends StatelessWidget {
  const HidenBalanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
    );
  }
}

