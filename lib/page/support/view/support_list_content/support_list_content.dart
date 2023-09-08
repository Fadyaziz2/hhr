import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onesthrm/page/support/support_bloc/support_bloc.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/nav_utail.dart';

import '../../content/support_ticket_item.dart';
import '../create_support/create_support_page.dart';

class SupportListContent extends StatelessWidget {

  const SupportListContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportBloc,SupportState>(builder: (context, state){
      if(state.status == NetworkStatus.loading){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if(state.status == NetworkStatus.success){
       return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                context.read<SupportBloc>().add(SelectDatePicker(context));
              },
              child: Container(
                color: Colors.grey[100],
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          // context.read<SupportBloc>().add(SelectDatePicker());

                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.angleLeft,
                          size: 30,
                          color: appColor,
                        )),
                    const Spacer(),
                     Center(
                        child: Text(
                          state.currentMonth ?? "Select Month",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black),
                        )),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          // provider.selectDate(context);

                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.angleRight,
                          size: 30,
                          color: appColor,
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 20,
                children: List<Widget>.generate(
                  supportTicketsButton.length, (int index) {
                    int selectedIndex = 0;

                    switch(state.filter){
                      case Filter.open:
                        selectedIndex = 0;
                        break;
                      case Filter.close:
                        selectedIndex = 1;
                        break;
                      case Filter.all:
                        selectedIndex = 2;
                        break;
                    }

                    return ChoiceChip(
                      elevation: 3,
                      label: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(supportTicketsButton[index]),
                      ),
                      // selected: provider.value == index,
                      selected: selectedIndex == index,
                      backgroundColor: Colors.white,
                      selectedColor: const Color(0xFF5DB226),
                      labelStyle: TextStyle(
                        color: selectedIndex == index
                            ? Colors.white
                            : const Color(0xFF5DB226),
                      ),
                      onSelected: (bool selected) {
                       if(index == 0){
                         context.read<SupportBloc>().add(OnFilterUpdate(filter: Filter.open,date: state.currentMonth));
                       }else if(index == 1){
                         context.read<SupportBloc>().add(OnFilterUpdate(filter: Filter.close,date: state.currentMonth));
                       }else{
                         context.read<SupportBloc>().add(OnFilterUpdate(filter: Filter.all,date: state.currentMonth));
                       }
                        // provider.onSelected(selected, index, 1);
                      },
                    );
                  },
                ).toList(),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: state.supportListModel?.data?.data?.length ??
                  0,
              itemBuilder: (BuildContext context, int index) {
                var item = state.supportListModel?.data?.data?[index];
                return item != null ? SupportTicketItem(supportModel: item) : const SizedBox.shrink();
              },
            ),
          ],
        );
      }
      if (state.status == NetworkStatus.failure){
        return const Center(child: Text('Failed to load support list'));
      }
      return const SizedBox();
    });

  }

}
