import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/home/bloc/home_state.dart';
import '../../../../res/const.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../../../profile/view/profile_page.dart';
import '../../bloc/home_bloc.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;

    return BlocBuilder<HomeBloc,HomeState>(
      builder: (context,state){

        final settings = context.read<HomeBloc>().state.settings;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 95.0,
                child: InkWell(
                  onTap: null,
                  child: Container(
                    margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      boxShadow: [
                        BoxShadow(
                          color: mainColor.withOpacity(0.2),
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Center(
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/en/5/5a/Shaheen_College_Logo_Dhaka.png',
                            scale: 3,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${user?.user?.name}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16)),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(ProfileScreen.route(
                                      context
                                          .read<AuthenticationBloc>()
                                          .state
                                          .data
                                          ?.user
                                          ?.id,settings));
                                },
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    "VIEW PROFILE",
                                    style:
                                    TextStyle(fontSize: 14, color: mainColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: const Text(
                                    'Are you sure, you want to logout'),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('No')),
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<AuthenticationBloc>()
                                            .add(AuthenticationLogoutRequest());
                                      },
                                      child: const Text('Yes')),
                                ],
                              ),
                            ),
                            icon: const Icon(Icons.logout)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

