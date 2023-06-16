import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onesthrm/page/home/bloc/home_bloc.dart';
import 'package:onesthrm/res/enum.dart';

class MockMetaClubApiClientRepository extends Mock implements MetaClubApiClient {

   String mockToken = '';

  @override
  String get token => mockToken;
}

main() {

  group('HomeBloc', () {

    late MetaClubApiClient metaClubApiClient;
    late HomeBloc homeBloc;
    DashboardModel? dashboardModel;
    Settings? settings;

    setUp(() async {
      metaClubApiClient = MockMetaClubApiClientRepository();
      when(() => metaClubApiClient.getSettings()).thenAnswer((_) async => settings);
      when(() => metaClubApiClient.getDashboardData()).thenAnswer((_) async => dashboardModel);
      homeBloc = HomeBloc(metaClubApiClient: metaClubApiClient);
    });

    test('Initial state is correct', () {
      final homeBloc = HomeBloc(metaClubApiClient: metaClubApiClient);
      expect(homeBloc.state, const HomeState());
    });

    test('Settings data initially null', (){
      expect(homeBloc.state.settings, isNull);
    });

    test('Home dashboardModel initially null', (){
      expect(homeBloc.state.dashboardModel, isNull);
    });

    group('Fetch settings', () {

      blocTest<HomeBloc,HomeState>(
          'settings api call once',
          build: ()=> homeBloc,
          act: (bloc)=> bloc.add(LoadSettings()),
          verify: (_){
            verify(()=> metaClubApiClient.getSettings()).called(1);
          }
      );

      blocTest<HomeBloc,HomeState>(
        'Emit status [loading, success] when settings api call',
          setUp: (){
            when(()=> metaClubApiClient.getSettings());
          },
        build: ()=> homeBloc,
        act: (bloc)=> bloc.add(LoadSettings()),
        expect: ()=> <HomeState>[const HomeState(status: NetworkStatus.loading),
          const HomeState(status: NetworkStatus.success)]
      );

      // blocTest<HomeBloc,HomeState>(
      //     'Emit status [success] when settings api call',
      //     setUp: (){
      //       metaClubApiClient = MockMetaClubApiClientRepository();
      //       when(()=> metaClubApiClient.getSettings()).thenAnswer((_) async => settings);
      //     },
      //     build: ()=> homeBloc,
      //     act: (bloc)=> bloc.add(LoadSettings()),
      //     expect: ()=> <HomeState>[const HomeState(status: NetworkStatus.success)]
      // );

    });

  });

}
