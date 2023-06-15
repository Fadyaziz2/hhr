import 'package:flutter_test/flutter_test.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onesthrm/page/home/bloc/home_bloc.dart';

class MockMetaClubApiClientRepository extends Mock implements MetaClubApiClient {
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
  });
}
