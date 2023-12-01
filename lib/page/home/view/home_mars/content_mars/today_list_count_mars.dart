import 'package:flutter/material.dart';
import 'package:onesthrm/res/const.dart';

class TodayListCountMars extends StatelessWidget {
  const TodayListCountMars(
      {super.key, this.image, this.title, this.count, this.onTap});

  final String? image;
  final String? title;
  final String? count;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.network(
            image ?? '',
            height: 40,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  count ?? "",
                  style: const TextStyle(
                      color: colorPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                Text(
                  title ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}