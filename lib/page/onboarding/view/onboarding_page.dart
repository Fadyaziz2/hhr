import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/onboarding/bloc/onboarding_bloc.dart';
import 'package:onesthrm/res/const.dart';
import '../../../res/nav_utail.dart';
import '../../../res/widgets/custom_button.dart';
import '../../login/view/login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  static Route route(){
    return MaterialPageRoute(builder: (_) => const OnboardingPage());
  }

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
            title: "next".tr(),
            padding: 16,
            clickButton: () {
              NavUtil.pushAndRemoveUntil(context, const LoginPage());
            },
          ),
        ),
      ),
      body: BlocBuilder<OnboardingBloc,OnboardingState>(
        builder: (context,state){
          if(state.companyListModel?.companyList?.length == 1 && !mounted){
            NavUtil.pushAndRemoveUntil(context, const LoginPage());
          }
          return Stack(
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/company_list.jpg',
                    fit: BoxFit.cover,
                    height: 260.h,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.companyListModel?.companyList?.length ?? 0,
                      itemBuilder:
                          (BuildContext context, int index) {
                            Company? company =  state.companyListModel?.companyList?[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(12.0),
                              border: Border.all(
                                  color: colorPrimary)),
                          child: RadioListTile<Company?>(
                              title: Text(
                                company?.companyName ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium,
                              ),
                              subtitle: Text(
                                company?.subdomain ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall,
                              ),
                              value: company,
                              groupValue: state.selectedCompany,
                              onChanged: (Company? value) {
                                    context.read<OnboardingBloc>().add(OnSelectedCompanyEvent(selectedCompany: value!));
                              }),
                        );
                      },
                    ),
                  ),

                ],
              ),
            ],
          );
        },
      )
    );
  }
}
