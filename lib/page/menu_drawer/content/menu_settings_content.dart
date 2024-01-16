import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onesthrm/page/language/view/language_screen.dart';
import 'package:onesthrm/res/nav_utail.dart';

import '../../language/bloc/language_bloc.dart';

class MenuSettingsContent extends StatelessWidget {
  const MenuSettingsContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (_, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
             Text(
              'setting',
              style: TextStyle(color: Colors.grey, fontSize: 14.r),
            ).tr(),
            const Divider(),
            ListTile(
              onTap: () {
                NavUtil.navigateScreen(context, const LanguageScreen());
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 8,
              leading: SvgPicture.asset(
                  'assets/menu_drawer_icons/language-change.svg'),
              title:  Text("language_change", style: TextStyle(fontSize: 12.r),).tr(),
            ),
          ],
        );
      },
    );
  }
}
