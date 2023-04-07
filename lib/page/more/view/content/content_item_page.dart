import 'package:flutter/material.dart';
import 'package:meta_club_api/src/models/more.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../res/const.dart';

class ContentItemPage extends StatelessWidget {

  final More more;

  const ContentItemPage({Key? key, required this.more}) : super(key: key);

  static Route route(More more){
    return MaterialPageRoute(builder: (_) => ContentItemPage(more: more,));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${more.title}'),
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(child: Html(data: more.content)),
    );
  }
}
