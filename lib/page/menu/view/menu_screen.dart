import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/language/bloc/language_bloc.dart';
import 'package:onesthrm/page/menu/bloc/menu_bloc.dart';
import 'package:onesthrm/page/menu_drawer/view/menu_drawer.dart';
import '../../../res/const.dart';
import '../../app/global_state.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../../home/bloc/home_bloc.dart';
import '../../profile/view/profile_page.dart';
import '../content/menu_content_item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
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
    final baseUrl = globalState.get(companyUrl);
    final settings = context.read<HomeBloc>().state.settings;
    final homeData = context.watch<HomeBloc>().state.dashboardModel;
    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
        create: (context) => MenuBloc(
            metaClubApiClient: MetaClubApiClient(
                token: '${user?.user?.token}', companyUrl: baseUrl),
            setting: settings!,
            loginData: user!,
            color: colorPrimary)
          ..add(RouteSlug(context: context)),
        child: Scaffold(
            key: MenuScreen._scaffoldKey,
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              ProfileScreen.route(user?.user?.id, settings));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0.w, vertical: 20.h),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                    height: 50.h,
                                    width: 50.w,
                                    fit: BoxFit.cover,
                                    imageUrl: "${user?.user?.avatar}",
                                    placeholder: (context, url) => Center(
                                      child: Image.asset(
                                          "assets/images/placeholder_image.png"),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                SizedBox(
                                  width: 16.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user?.user?.name ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.r),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "view_profile".tr(),
                                        style: TextStyle(
                                            fontSize: 14.r,
                                            color: colorPrimary),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      if (MenuScreen._scaffoldKey.currentState!
                                          .isEndDrawerOpen) {
                                        MenuScreen._scaffoldKey.currentState
                                            ?.openEndDrawer();
                                      } else {
                                        MenuScreen._scaffoldKey.currentState
                                            ?.openEndDrawer();
                                      }
                                    },
                                    icon: Icon(
                                      Icons.menu,
                                      color: colorPrimary,
                                      size: 25.r,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.only(bottom: 55.0),
                          itemCount: homeData?.data?.menus?.length ?? 0,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 2),
                          itemBuilder: (BuildContext context, int index) {
                            ///List length
                            int length = homeData?.data?.menus?.length ?? 0;

                            ///Animation instance
                            final animation = Tween(begin: 0.0, end: 1.0)
                                .animate(CurvedAnimation(
                                    parent: animationController,
                                    curve: Interval((1 / length) * index, 1.0,
                                        curve: Curves.fastOutSlowIn)));
                            animationController.forward();
                            final menu = homeData?.data?.menus?[index];
                            return menu != null
                                ? MenuContentItem(
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
                        ),
                      ),
                      const SizedBox(
                        height: 36.0,
                      )
                    ],
                  ));
            })));
  }
}
