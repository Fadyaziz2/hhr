import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/global_state.dart';
import 'package:onesthrm/page/attendance_method/bloc/attendance_method_bloc.dart';
import 'package:onesthrm/page/language/bloc/language_bloc.dart';
import 'package:onesthrm/page/menu_drawer/view/menu_drawer.dart';
import 'package:onesthrm/res/enum.dart';
import '../../../res/const.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../../home/bloc/home_bloc.dart';
import '../content/type_content_item.dart';

class AttendanceMethodScreen extends StatefulWidget {
  const AttendanceMethodScreen({super.key});

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  static Route route(
      {required HomeBloc homeBloc,
      AttendanceType attendanceType = AttendanceType.normal}) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
            value: homeBloc, child: const AttendanceMethodScreen()));
  }

  @override
  State<AttendanceMethodScreen> createState() => _AttendanceMethodScreenState();
}

class _AttendanceMethodScreenState extends State<AttendanceMethodScreen>
    with TickerProviderStateMixin {
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
    final baseUrl = globalState.get(companyUrl);

    return BlocProvider(
        create: (context) => AttendanceMethodBloc(
            metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}', companyUrl: baseUrl), homeBloc: context.read<HomeBloc>(),),
      child: Scaffold(
          key: AttendanceMethodScreen._scaffoldKey,
          extendBody: true,
          appBar: AppBar(
            title: Text(
              'attendance_method'.tr(),
              style: TextStyle(fontSize: 18.r),
            ),
          ),
          body: BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
            return Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [colorPrimary, colorPrimaryGradient])),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
                child: GridView.builder(
                  itemCount: settings?.data?.methods.length ?? 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5.r,mainAxisSpacing: 8.0,crossAxisSpacing: 8.0),
                  itemBuilder: (BuildContext context, int index) {
                    ///List length
                    int length = homeData?.data?.menus?.length ?? 0;

                    ///Animation instance
                    final animation = Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: animationController,
                            curve: Interval((1 / length) * index, 1.0,
                                curve: Curves.fastOutSlowIn)));
                    animationController.forward();

                    final method = settings?.data?.methods[index];

                    return method != null
                        ? TypeContentItem(
                            method: method,
                            animation: animation,
                            animationController: animationController,
                            onPressed: () {
                              context.read<AttendanceMethodBloc>().add(AttendanceNavEvent(context: context, slugName: method.slug));
                            })
                        : const SizedBox.shrink();
                  },
                ));
          })),
    );
  }
}
