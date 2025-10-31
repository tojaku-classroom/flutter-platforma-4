import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Naslovnica'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Dobro došli na naslovnicu',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/page1'),
              child: const Text('Stranica 1'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/page2'),
              child: const Text('Stranica 2'),
            ),
          ],
        ),
      ),
    );
  }
}
