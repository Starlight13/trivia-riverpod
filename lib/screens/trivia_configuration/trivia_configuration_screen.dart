import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_riverpod/navigation/routes.dart';

class TriviaConfigurationScreen extends ConsumerWidget {
  const TriviaConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trivia Configuration')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(),
                    ],
                  ),
                ),
              ),
              FloatingActionButton(
                onPressed: () => TriviaRoute().go(context),
                child: const Text('Start Trivia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
