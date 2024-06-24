import 'package:age_estimater/presentation/age_estimate_screen.dart';
import 'package:age_estimater/presentation/bloc/age_estimate_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/data_sources/http_manager.dart';
import 'domain/repository/age_estimate_repository.dart';

void main() {
  final dio = Dio();
  final httpManager = HttpManager(dio: dio);
  final ageRepository = AgeEstimateRepository(httpManager);

  runApp(MyApp(
    ageRepository: ageRepository,
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
        create: (context) => AgeEstimateBloc(ageRepository),
        child: AgeEstimateScreen(),
      ),
    );
  }
}
