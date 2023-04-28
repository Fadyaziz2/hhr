import 'package:flutter/material.dart';
import '../../../res/const.dart';
import 'content/home_content.dart';
class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            SizedBox(height: 16.0,),
            Expanded(child: HomeContent())
          ],
        ),
      ),
    );
  }
}
