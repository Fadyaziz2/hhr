import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/menu_drawer/content/privacy_policy_content.dart';
import 'package:onesthrm/res/nav_utail.dart';

class SupportContent extends StatelessWidget {
  const SupportContent({
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
          'Support',
          style: TextStyle(color: Colors.grey),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            NavUtil.navigateScreen(
                context,
                const PolicyContentScreen(
                  appBarName: "support_policy",
                  apiSlug: "support-24-7",
                ));
          },
          dense: true,
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 8,
          leading:
              SvgPicture.asset("assets/menu_drawer_icons/support-policy.svg"),
          title: const Text('support_policy').tr(),
        ),
        ListTile(
          onTap: () {
            NavUtil.navigateScreen(
                context,
                const PolicyContentScreen(
                  appBarName: "privacy_policy",
                  apiSlug: "privacy-policy",
                ));
          },
          dense: true,
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 8,
          leading:
              SvgPicture.asset("assets/menu_drawer_icons/privacy-policy.svg"),
          title: const Text('privacy_policy').tr(),
        ),
        ListTile(
          onTap: () {
            NavUtil.navigateScreen(
                context,
                const PolicyContentScreen(
                  appBarName: "terms_conditions",
                  apiSlug: "terms-of-use",
                ));
          },
          dense: true,
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 8,
          leading:
              SvgPicture.asset("assets/menu_drawer_icons/terms-condition.svg"),
          title: const Text('terms_conditions').tr(),
        ),
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          return ListTile(
            onTap: () => showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                content: const Text('Are you sure, you want to Logout?'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('No')),
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(AuthenticationLogoutRequest());
                        Navigator.of(context).pop();
                      },
                      child: const Text('Yes')),
                ],
              ),
            ),
            dense: true,
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 8,
            leading: SvgPicture.asset("assets/menu_drawer_icons/logout.svg"),
            title: const Text('Logout').tr(),
          );
        })
      ],
    );
  }
}
