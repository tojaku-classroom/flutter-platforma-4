import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Uspješno odjavljeni!')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Odjava nije uspjela')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Naslovnica'),
            actions: [
              if (user == null) ...[
                TextButton(
                  child: const Text('Prijava'),
                  onPressed: () => context.go('/login'),
                ),
                TextButton(
                  child: const Text('Registracija'),
                  onPressed: () => context.go('/register'),
                ),
              ] else ...[
                TextButton(
                  child: const Text('Upravljanje idejama'),
                  onPressed: () => context.go('/manage_ideas'),
                ),
                TextButton(
                  child: const Text('Odjava'),
                  onPressed: () => _logOut(context),
                ),
              ],
            ],
          ),
          body: Center(
            child: () {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (user == null) {
                return const Text('Niste prijavljeni.');
              }
              final display = user.email?.isNotEmpty == true
                  ? user.email
                  : user.uid;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Prijavljeni ste kao $display'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => _logOut(context),
                    child: const Text('Odjava'),
                  ),
                ],
              );
            }(),
          ),
        );
      },
    );
  }
}
