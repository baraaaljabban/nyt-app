import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyt/features/articles/presentation/cubit/location/location_cubit.dart';

class LocationController extends StatefulWidget {
  const LocationController({super.key});

  @override
  State<LocationController> createState() => _LocationControllerState();
}

class _LocationControllerState extends State<LocationController> {
  @override
  void initState() {
    BlocProvider.of<LocationCubit>(context).startLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state is LocationChanges) {
          return SizedBox(
            height: 40,
            child: Text('Long ${state.long}, Lat:${state.lat}'),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
