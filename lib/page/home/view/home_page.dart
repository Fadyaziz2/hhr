import 'package:club_application/res/const.dart';
import 'package:flutter/material.dart';
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
          children: [
            const SizedBox(height: 16.0,),
            Text(
              'xShaheen',
              textAlign: TextAlign.center,
              style: TextStyle(color: mainColor, fontWeight: FontWeight.bold,fontSize: 24.0),
            ),
            const SizedBox(height: 16.0,),
            const Expanded(child: HomeContent())
          ],
        ),
      ),
    );
  }
}
