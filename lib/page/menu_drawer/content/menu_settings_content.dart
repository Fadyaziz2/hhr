import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onesthrm/page/language/view/language_screen.dart';
import 'package:onesthrm/res/nav_utail.dart';

class MenuSettingsContent extends StatelessWidget {
  const MenuSettingsContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Setting',
          style: TextStyle(color: Colors.grey),
        ),
        const Divider(),
        const ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 8,
          leading: Icon(
            Icons.face_retouching_natural,
            color: Colors.black,
          ),
          title: Text('Face Register'),
        ),
        ListTile(
          onTap: () {
            NavUtil.navigateScreen(context, const LanguageScreen());
          },
          dense: true,
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 8,
          leading:
              SvgPicture.asset('assets/menu_drawer_icons/language-change.svg'),
          title: const Text("language_change").tr(),
        ),
      ],
    );
  }
}
