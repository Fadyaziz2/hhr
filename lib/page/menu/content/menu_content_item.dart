import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/const.dart';

class MenuContentItem extends StatelessWidget {
  final Function() onPressed;
  final Menu menu;
  final AnimationController animationController;
  final Animation animation;

  const MenuContentItem(
      {Key? key,
      required this.onPressed,
      required this.menu,
      required this.animationController,
      required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (_, __) {
          return FadeTransition(
            opacity: kAlwaysCompleteAnimation,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 50.0 * (1.0 - animation.value), 0.0),
              child: Card(
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
                              )
                            : Image.network(
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
                          ).tr(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
