import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/age_estimate_bloc.dart';

class AgeEstimateScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  AgeEstimateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Estimatorr'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter a name to get the estimated age',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Enter Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  context
                      .read<AgeEstimateBloc>()
                      .add(GetAgeEvent(_nameController.text));
                }
              },
              child: const Text('Get Age Estimate'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _nameController.clear();
                context.read<AgeEstimateBloc>().add(ResetEvent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: const Text('Restart'),
            ),
            const SizedBox(height: 10),
            BlocBuilder<AgeEstimateBloc, AgeEstimateState>(
              builder: (context, state) {
                if (state is AgeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AgeLoaded) {
                  return Text(
                    'Estimated Age for ${_nameController.text} is: ${state.age}',
                    style: TextStyle(color: Colors.green[800], fontSize: 16),
                    textAlign: TextAlign.center,
                  );
                } else if (state is AgeError) {
                  return Text(
                    'Invalid username, failed to load age estimate\nPlease enter valid username',
                    style: TextStyle(color: Colors.red[800]),
                    textAlign: TextAlign.center,
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
