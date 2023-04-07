import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../animation/bounce_animation/bounce_animation_builder.dart';

class VoteSuccessPage extends StatefulWidget {
  const VoteSuccessPage({Key? key}) : super(key: key);

  @override
  State<VoteSuccessPage> createState() => _VoteSuccessPageState();
}

class _VoteSuccessPageState extends State<VoteSuccessPage> {

  @override
  initState() {
    initFunction();
    super.initState();
  }

  initFunction() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Lottie.asset(
            'assets/lottie/celebration.json',
            width: double.infinity,
            height: double.infinity,
          ),
          Lottie.asset(
            'assets/lottie/celebration_three.json',
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Lottie.asset(
              'assets/lottie/vote.json',
              width: 250,
              height: 250,
            ),
          ),

        ],
      )
    );
  }
}
