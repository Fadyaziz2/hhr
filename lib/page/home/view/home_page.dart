import 'package:flutter/material.dart';
import 'package:onesthrm/page/home/home.dart';
import 'package:core/core.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: backgroundColor, body: HomeContent());
  }
}
