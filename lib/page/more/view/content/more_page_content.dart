import 'package:club_application/page/more/view/content/content_item_page.dart';
import 'package:club_application/res/const.dart';
import 'package:club_application/res/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../more.dart';

class MoreContent extends StatelessWidget {
  const MoreContent({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoreBloc, MoreState>(
      builder: (context, state) {
        if (state.status == NetworkStatus.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: mainColor,
            ),
          );
        }
        if (state.status == NetworkStatus.success) {
          if (state.mores != null) {
            return state.mores!.mores.isNotEmpty
                ? ListView.separated(
              itemCount: state.mores!.mores.length,
              itemBuilder: (BuildContext context, int index) {
                final data = state.mores!.mores[index];
                return ListTile(
                  onTap: (){
                    Navigator.of(context).push(ContentItemPage.route(data));
                  },
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.title ?? '',
                      style:
                      const TextStyle(height: 1.4,fontSize: 18.0),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  endIndent: 12,
                  indent: 12,
                );
              },
            )
                : const Center(
              child: Text(
                'No Content Available',
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.6),
              ),
            );
          }
        }
        if (state.status == NetworkStatus.failure) {
          return const Center(
            child: Text('Error to load'),
          );
        }
        return const SizedBox();
      },
    );
  }
}

