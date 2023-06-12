import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../res/const.dart';

class MenuContentItem extends StatelessWidget {

  final Function() onPressed;
  final String? image;
  final String? name;
  final String? imageType;

  const MenuContentItem({Key? key,required this.onPressed,this.image,this.name,this.imageType}) : super(key: key);

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
              imageType?.contains('svg') == true
                  ? SvgPicture.network(
                image ?? "",
                height: 25,
                width: 25,
                color: colorPrimary,
              )
                  : Image.network(
                image ?? '',
                height: 25,
                width: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Home',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



