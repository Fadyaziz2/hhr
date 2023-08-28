import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/phonebook/phonebook.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PhonebookUserList extends StatelessWidget {
  const PhonebookUserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    RefreshController refreshController = RefreshController(initialRefresh: false);

    return BlocListener<PhonebookBloc, PhonebookState>(
      listenWhen: (oldState, newState) => oldState != newState,
      listener: (context,state){
        if(state.refreshStatus == PullStatus.loaded){
          refreshController.refreshCompleted();
        }
      },
      child: BlocBuilder<PhonebookBloc, PhonebookState>(
        buildWhen: (oldState,newState) => oldState != newState,
          builder: (context, state) {
        return SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: const WaterDropHeader(),
            footer: CustomFooter(builder: (context, mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = const Text("pull up load");
              } else if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = const Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = const Text("release to load more");
              } else {
                body = const Text("No more Data");
              }
              return SizedBox(
                height: 55.0,
                child: Center(child: body),
              );
            }),
            controller: refreshController,
            onLoading: (){
              context.read<PhonebookBloc>().add(PhonebookLoadMore());
            },
            onRefresh: (){
              context.read<PhonebookBloc>().add(PhonebookLoadRefresh());
            },
            child: ListView.builder(
              itemCount: state.phonebook?.data?.users?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    /// nevigate to details page
                    // await allUserProvider.getPhonebookDetails(allUserProvider.responseAllUser?.data?.users?[index].id, allUserProvider.phonebookDetails, context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: ListTile(
                      title:
                          Text(state.phonebook?.data?.users?[index].name ?? ""),
                      subtitle: Text(
                          state.phonebook?.data?.users?[index].designation ??
                              ""),
                      leading: ClipOval(
                        child: CachedNetworkImage(
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                          imageUrl:
                              "${state.phonebook?.data?.users?[index].avatar}",
                          placeholder: (context, url) => Center(
                            child: Image.asset(
                                "assets/images/placeholder_image.png"),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          /// Dial
                          // FlutterPhoneDirectCaller.callNumber(allUserProvider.responseAllUser?.data?.users?[index].phone ?? "");
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.phone,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ));
      }),
    );
  }
}
