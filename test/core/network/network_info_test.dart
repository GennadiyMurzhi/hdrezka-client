import 'package:hdrezka_client/core/network/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<InternetConnectionChecker>(as: #InternetConnectionCheckerMock)
])

void main (){
  NetworkInfoImpl? networkInfoImpl;
  InternetConnectionCheckerMock? mockDInternetConnectionChecker;

  setUp(() {
    mockDInternetConnectionChecker = InternetConnectionCheckerMock();
    networkInfoImpl = NetworkInfoImpl(mockDInternetConnectionChecker!);
  });

  group('isConnected',() {
    test('should forward the call to InternetConnectionChecker.hasConnection',
    () async {
      //arrange
      final testHasConnectionFuture = Future.value(true);

      when(mockDInternetConnectionChecker!.hasConnection)
      .thenAnswer((realInvocation) => testHasConnectionFuture);
      //act
      final result =  networkInfoImpl!.isConnected;
      //assert
      verify(mockDInternetConnectionChecker!.hasConnection);
      expect(result, testHasConnectionFuture);
    });
  });
}