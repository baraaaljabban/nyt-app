part of 'location_cubit.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationChanges extends LocationState {
  final String lat;
  final String long;
  LocationChanges({
    required this.lat,
    required this.long,
  });
}
