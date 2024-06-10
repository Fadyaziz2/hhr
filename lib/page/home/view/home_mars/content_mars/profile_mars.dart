import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../res/nav_utail.dart';
import '../../../../authentication/bloc/authentication_bloc.dart';
import '../../../../profile/view/profile_page.dart';
import 'mars_today_summary_list.dart';

class ProfileMars extends StatelessWidget {
  const ProfileMars({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return Container(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
              child:  InkWell(
                onTap: () {
                  NavUtil.navigateScreen(context, const ProfileScreen());
                },
                child: ClipOval(
                  child: CachedNetworkImage(
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                      imageUrl: "${user?.user?.avatar}",
                      placeholder: (context, url) => Center(child: Image.asset("assets/home_bg/placeholder_image.png")),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error)),
                ),
              )
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.135),
          ///Today Summary List ==========================
          const TodaySummaryListMars(),
          SizedBox(height: 18.h),
        ],
      ),
    );
  }
}
