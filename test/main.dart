import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onesthrm/page/app/app.dart';
import 'package:user_repository/user_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() {

  initHydratedStorage();

  group('HRM App', () {

    late MetaClubApiClient apiClient;
    late AuthenticationRepository authenticationRepository;
    late UserRepository userRepository;

    setUp((){
       apiClient = MetaClubApiClient(token: '');
       authenticationRepository = AuthenticationRepository(apiClient: apiClient);
       userRepository = UserRepository(token: '');
    });

    testWidgets('Render HRM App', (widgetTester) async {
      await widgetTester.pumpWidget(App(authenticationRepository: authenticationRepository, userRepository: userRepository));
      expect(find.byType(AppView), findsOneWidget);
    });
  });
}


class MockStorage extends Mock implements Storage{}

late Storage hydratedStorage;

void initHydratedStorage(){
  TestWidgetsFlutterBinding.ensureInitialized();
  hydratedStorage = MockStorage();
  when(() => hydratedStorage.write(any(),any<dynamic>())).thenAnswer((_) async {});
  HydratedBloc.storage = hydratedStorage;
}