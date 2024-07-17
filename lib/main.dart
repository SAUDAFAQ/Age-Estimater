import 'package:age_estimater/presentation/screens/age_estimate/age_estimate_screen.dart';
import 'package:age_estimater/presentation/screens/age_estimate/bloc/age_estimate_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di/injection_container.dart';
import 'domain/repository/age_estimate_repository/age_estimate_repository.dart';

void main() {
  setupLocator();
  final AgeEstimateRepository ageEstimateRepository = sl<AgeEstimateRepository>();
  runApp(MyApp(
    ageRepository: ageEstimateRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AgeEstimateRepository ageRepository;

  const MyApp({required this.ageRepository, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Estimator',
      home: BlocProvider(
        create: (context) => AgeEstimateBloc(ageRepository: ageRepository),
        child: const AgeEstimateScreen(),
      ),
    );
  }
}
