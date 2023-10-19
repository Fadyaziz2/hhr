import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/const.dart';

class MenuContentItem extends StatelessWidget {

  final Function() onPressed;
  final Menu menu;

  const MenuContentItem({Key? key,required this.onPressed,required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              menu.icon?.contains('svg') == true
                  ? SvgPicture.network(
                menu.icon ?? "",
                height: 25,
                width: 25,
                color: colorPrimary,
              ) : Image.network(
                menu.icon ?? '',
                height: 25,
                width: 25,
              ),
              const SizedBox(
                width: 10,
              ),
               Expanded(
                 child: Text(
                  menu.name ?? '',
                  maxLines: 2,
                  style: const TextStyle(fontSize: 12),
              ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}



