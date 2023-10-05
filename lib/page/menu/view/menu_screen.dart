import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/menu/bloc/menu_bloc.dart';
import 'package:onesthrm/page/menu_drawer/view/menu_drawer.dart';
import '../../../res/const.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../../home/bloc/home_bloc.dart';
import '../../profile/view/profile_page.dart';
import '../content/menu_content_item.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final settings = context.read<HomeBloc>().state.settings;
    final homeData = context.watch<HomeBloc>().state.dashboardModel;
    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (context) => MenuBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'),
          setting: settings!)
        ..add(RouteSlug(context: context)),
      child: Scaffold(
          key: _scaffoldKey,
          endDrawer: const MenuDrawer(),
          extendBody: true,
          body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [colorPrimary, colorPrimaryGradient])),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          ProfileScreen.route(user?.user?.id, settings));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 20),
                        child: Row(
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                height: 50,
                                width: 50,
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
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user?.user?.name ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "VIEW PROFILE",
                                    style: TextStyle(
                                        fontSize: 14, color: colorPrimary),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  if (_scaffoldKey
                                      .currentState!.isEndDrawerOpen) {
                                    _scaffoldKey.currentState?.openEndDrawer();
                                  } else {
                                    _scaffoldKey.currentState?.openEndDrawer();
                                  }
                                },
                                icon: const Icon(
                                  Icons.menu,
                                  color: colorPrimary,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: homeData?.data?.menus?.length ?? 0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 2),
                      itemBuilder: (BuildContext context, int index) {
                        final menu = homeData?.data?.menus?[index];

                        return menu != null
                            ? MenuContentItem(
                                menu: menu,
                                onPressed: () {
                                  context.read<MenuBloc>().add(RouteSlug(
                                      context: context, slugName: menu.slug));
                                })
                            : const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ))),
    );
  }
}
