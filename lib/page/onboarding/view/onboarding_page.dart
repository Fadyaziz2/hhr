import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/onboarding/bloc/onboarding_bloc.dart';
import 'package:onesthrm/res/const.dart';

import '../../../res/widgets/custom_button.dart';
import '../../authentication/bloc/authentication_bloc.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (_) => OnboardingBloc(metaClubApiClient: MetaClubApiClient(token: "${user?.user?.token}"))..add(CompanyListEvent()),
      child: Scaffold(
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
              },
            ),
          ),
        ),
        body: BlocBuilder<OnboardingBloc,OnboardingState>(
          builder: (context,state){
            return Stack(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/home_bacground_anabo.png',
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.companyListModel?.companyList?.length ?? 0,
                        itemBuilder:
                            (BuildContext context, int index) {
                              CompanyList? data =  state.companyListModel?.companyList?[index];
                          // final data =
                          // provider.searchList[index];
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
                            child: RadioListTile<CompanyList?>(
                                title: Text(
                                  data?.companyName ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                                subtitle: Text(
                                  data?.subdomain ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall,
                                ),
                                value: data,
                                groupValue: state.companyList,
                                onChanged:
                                    (CompanyList? value) {
                                 // state?.companyList = value;
                                      context.read<OnboardingBloc>().add(OnSelectedCompanyEvent(selectedCompany: value!));
                                  // provider
                                  //     .onSelectedCompanyValue(
                                  //     value!);
                                }),
                          );
                        },
                      ),
                    ),

                  ],
                ),
                Positioned(
                    top: 216,
                    right: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        onChanged: (value) {
                          // provider.onChangeSearch(value);
                        },
                        decoration: InputDecoration(
                            hintText: 'Choose A Company',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 4.0),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: colorPrimary),
                                borderRadius: BorderRadius.circular(25.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: colorPrimary),
                                borderRadius: BorderRadius.circular(25.0)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            )),
                      ),
                    ))
              ],
            );
          },
        )
      ),
    );
  }
}
