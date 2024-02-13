import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesthrm/page/language/bloc/language_bloc.dart';
import 'package:onesthrm/page/menu/bloc/menu_bloc.dart';
import 'package:onesthrm/page/menu_drawer/view/menu_drawer.dart';
import '../../../res/const.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../../home/bloc/home_bloc.dart';
import '../../profile/view/profile_page.dart';
import '../content/type_content_item.dart';

class AttendanceMethodScreen extends StatefulWidget {
  const AttendanceMethodScreen({super.key});

  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<AttendanceMethodScreen> createState() => _AttendanceMethodScreenState();
}

class _AttendanceMethodScreenState extends State<AttendanceMethodScreen> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.read<HomeBloc>().state.settings;
    final homeData = context.watch<HomeBloc>().state.dashboardModel;
    final user = context.read<AuthenticationBloc>().state.data;

    return Scaffold(
        key: AttendanceMethodScreen._scaffoldKey,
        endDrawer: const MenuDrawer(),
        extendBody: true,
        body: BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              return Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [colorPrimary, colorPrimaryGradient])),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
                  child: GridView.builder(
                    padding: const EdgeInsets.only(bottom: 55.0).r,
                    itemCount: homeData?.data?.menus?.length ?? 0,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1.7.r),
                    itemBuilder: (BuildContext context, int index) {
                      ///List length
                      int length = homeData?.data?.menus?.length ?? 0;

                      ///Animation instance
                      final animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Interval((1 / length) * index, 1.0, curve: Curves.fastOutSlowIn)));
                      animationController.forward();

                      final menu = homeData?.data?.menus?[index];
                      return menu != null
                          ? TypeContentItem(
                          menu: menu,
                          animation: animation,
                          animationController: animationController,
                          onPressed: () {
                            context.read<MenuBloc>().add(RouteSlug(
                                context: context,
                                slugName: menu.slug));
                          })
                          : const SizedBox.shrink();
                    },
                  ));
            }));
  }
}
