import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/age_estimate_bloc.dart';

class AgeEstimateScreen extends StatefulWidget {
  const AgeEstimateScreen({super.key});

  @override
  State<AgeEstimateScreen> createState() => _AgeEstimateScreenState();
}

class _AgeEstimateScreenState extends State<AgeEstimateScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isNameNotEmpty = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _nameController.removeListener(_updateButtonState);
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Estimator'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            double padding = constraints.maxWidth * 0.05;
            double fontSize = constraints.maxWidth * 0.05;
            double buttonHeight = constraints.maxHeight * 0.08;

            return Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Enter a name to get the estimated age',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: fontSize),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: padding),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: padding),
                  SizedBox(
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_isNameNotEmpty) {
                          String? validationResponse = context
                              .read<AgeEstimateBloc>()
                              .validateName(_nameController.text);

                          if (validationResponse != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(validationResponse),
                              ),
                            );
                          } else {
                            context
                                .read<AgeEstimateBloc>()
                                .add(GetAgeEvent(_nameController.text));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a name.'),
                            ),
                          );
                        }
                      },
                      child: const Text('Get Age Estimate'),
                    ),
                  ),
                  SizedBox(height: padding * 0.5),
                  SizedBox(
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: _isNameNotEmpty
                          ? () {
                        _nameController.clear();
                        context.read<AgeEstimateBloc>().add(ResetEvent());
                      }
                          : null,
                      child: const Text('Restart'),
                    ),
                  ),
                  SizedBox(height: padding * 0.5),
                  BlocBuilder<AgeEstimateBloc, AgeEstimateState>(
                    builder: (context, state) {
                      if (state is AgeLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is AgeLoaded) {
                        return Text(
                          'Estimated Age for ${state.name} is: ${state.age}',
                          style: TextStyle(color: Colors.green[800], fontSize: fontSize * 0.8),
                          textAlign: TextAlign.center,
                        );
                      } else if (state is AgeError) {
                        return Text(
                          'Invalid username, failed to load age estimate\nPlease enter valid username',
                          style: TextStyle(color: Colors.red[800], fontSize: fontSize * 0.8),
                          textAlign: TextAlign.center,
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _updateButtonState() {
    setState(() {
      _isNameNotEmpty = _nameController.text.isNotEmpty;
    });
  }
}
