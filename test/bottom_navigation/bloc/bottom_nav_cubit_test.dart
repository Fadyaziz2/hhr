import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onesthrm/page/bottom_navigation/bloc/bottom_nav_cubit.dart';

void main() {
  group('BottomNavCubit', () {
    BottomNavCubit buildCubit()=> BottomNavCubit();

    group('constructor', () {
      test('works properly', () {
        expect(buildCubit, returnsNormally);
      });
      test('has correct initial state', () {
        expect(buildCubit().state, equals(const BottomNavState()));
      });
    });

    group('setTab', () {
      blocTest<BottomNavCubit, BottomNavState>('sets tab to given value',
          build: buildCubit,
          act: (cubit) => cubit.setTab(BottomNavTab.leave),
          expect: () => [const BottomNavState(tab: BottomNavTab.leave)]);
    });
  });
}
