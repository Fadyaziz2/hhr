import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onesthrm/page/attendance/attendance_service.dart';
import 'package:onesthrm/page/home/bloc/home_bloc.dart';
import '../../domain/usecases.dart';
import '../../main_test.dart';

class MockMetaClubApiClientRepository extends Mock
    implements MetaClubApiClient {}

class MockAttendanceService extends Mock implements AttendanceService {}

class MockSettings extends Mock implements Settings {}

main() {
  group('HomeBloc', () {
    late MockHomeDatLoadUseCase mockHomeDatLoadUseCase;
    late MockSettingsDataLoadUseCase mockSettingsDataLoadUseCase;
    late MockLogoutUseCase mockLogoutUseCase;
    late MockEventBus mockEventBus;
    late MetaClubApiClient metaClubApiClient;
    late HomeBloc homeBloc;
    late Settings settings;

    setUp(() async {
      initHiveDatabase();
      mockHomeDatLoadUseCase = MockHomeDatLoadUseCase();
      mockSettingsDataLoadUseCase = MockSettingsDataLoadUseCase();
      mockLogoutUseCase = MockLogoutUseCase();
      mockEventBus = MockEventBus();
      metaClubApiClient = MockMetaClubApiClientRepository();
      attendanceService = MockAttendanceService();
      settings = MockSettings();
      when(() => settings.data?.attendanceMethod).thenReturn('N');
      when(() => settings.data?.currencyCode).thenReturn('\$');
      when(() => settings.data?.isAdmin).thenReturn(false);
      when(() => metaClubApiClient.getSettings()).thenAnswer((_) async => Right(settings));
      homeBloc = HomeBloc(logoutUseCase: mockLogoutUseCase, homeDatLoadUseCase: mockHomeDatLoadUseCase, settingsDataLoadUseCase: mockSettingsDataLoadUseCase, eventBus: mockEventBus);
    });

    test('Initial state is correct', () {
      final homeBloc = HomeBloc(logoutUseCase: mockLogoutUseCase, homeDatLoadUseCase: mockHomeDatLoadUseCase, settingsDataLoadUseCase: mockSettingsDataLoadUseCase, eventBus: mockEventBus);
      expect(homeBloc.state, const HomeState());
    });

    test('Settings data initially null', () {
      expect(homeBloc.state.settings, isNull);
    });

    test('Home dashboardModel initially null', () {
      expect(homeBloc.state.dashboardModel, isNull);
    });
    //
    // group('Fetch settings', () {
    //
    //   blocTest<HomeBloc,HomeState>(
    //       'settings api call once',
    //       build: ()=> homeBloc,
    //       act: (bloc)=> bloc.add(LoadSettings()),
    //       verify: (_){
    //         verify(()=> metaClubApiClient.getSettings()).called(1);
    //       }
    //   );
    //
    //   // blocTest<HomeBloc,HomeState>(
    //   //   'Emit status [loading, failure] when settings api call',
    //   //   build: ()=> homeBloc,
    //   //   act: (bloc)=> bloc.add(LoadSettings()),
    //   //   expect: ()=> <HomeState>[const HomeState(status: NetworkStatus.loading),
    //   //     const HomeState(status: NetworkStatus.failure)]
    //   // );
    //
    //   blocTest<HomeBloc,HomeState>(
    //       'Emit status [loading,success] when settings api call',
    //       build: ()=> homeBloc,
    //       act: (bloc)=> bloc.add(LoadSettings()),
    //       expect: ()=> <HomeState>[const HomeState(status: NetworkStatus.loading), HomeState(status: NetworkStatus.success,settings: settings)]
    //   );
    // });
  });
}
