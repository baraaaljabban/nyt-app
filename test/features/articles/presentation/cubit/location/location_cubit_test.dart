// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:location/location.dart';
// import 'package:mockito/mockito.dart';
// import 'package:nyt/core/bloc/app_bloc_observer.dart';
// import 'package:nyt/features/articles/presentation/cubit/location/location_cubit.dart';

// class MockLocation extends Mock implements Location {
//   @override
//   Stream<LocationData> onLocationChanged = Stream<LocationData>.empty();
// }

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   group('LocationCubit Tests', () {
//     late LocationCubit locationCubit;
//     late MockLocation mockLocation;

//     setUp(() {
//       Bloc.observer = AppBlocObserver();
//       mockLocation = MockLocation();
//       locationCubit = LocationCubit(location: mockLocation);
//     });

//     tearDown(() {
//       locationCubit.close();
//     });

//     test('startLocation emits LocationChanges', () async {
//       // Set up the necessary mocks/stubs
//       when(mockLocation.serviceEnabled()).thenAnswer((_) => Future.value(true));
//       when(mockLocation.hasPermission()).thenAnswer((_) => Future.value(PermissionStatus.granted));
//       when(mockLocation.getLocation()).thenAnswer((_) => Future.value(LocationData.fromMap({
//             'latitude': 123.456,
//             'longitude': 789.012,
//           })));
//       when(mockLocation.onLocationChanged).thenAnswer((_) => Stream.value(LocationData.fromMap({
//             'latitude': 123.456,
//             'longitude': 789.012,
//           })));

//       // Call the method under test
//       locationCubit.startLocation();

//       // Expect the emitted state
//       expect(
//         locationCubit,
//         emitsInOrder([
//           LocationInitial(),
//           LocationChanges(lat: '123.456', long: '789.012'),
//           LocationChanges(lat: '123.456', long: '789.012'),
//         ]),
//       );
//     });

//     test('startLocation should not emit LocationChanges when service is not enabled', () async {
//       when(mockLocation.serviceEnabled()).thenAnswer((_) async => false);

//       expectLater(
//         locationCubit.stream,
//         emitsDone,
//       );

//       locationCubit.startLocation();
//     });

//     test('startLocation should not emit LocationChanges when permission is not granted', () async {
//       when(mockLocation.serviceEnabled()).thenAnswer((_) async => true);
//       when(mockLocation.hasPermission()).thenAnswer((_) async => PermissionStatus.denied);

//       expectLater(
//         locationCubit.stream,
//         emitsDone,
//       );

//       locationCubit.startLocation();
//     });

//     // Add more test cases to cover different scenarios and behaviors of the startLocation method
//   });
// }
