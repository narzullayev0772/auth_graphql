import 'package:auth_graphql/src/core/locator.dart';
import 'package:auth_graphql/src/features/auth/data/params/__generated__/token.req.gql.dart';
import 'package:auth_graphql/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = locator<AuthRepository>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ferry GraphQL Example',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Trigger the query
                repository.getAnonymousToken().listen((response) {
                  if (response.hasErrors) {
                    debugPrint('Errors: ${response.graphqlErrors}');
                  } else if (response.data != null) {
                    debugPrint('Token: ${response.data!.anonymousToken?.token}');
                    debugPrint('Refresh Token: ${response.data!.anonymousToken?.refreshToken}');
                  }
                });
              },
              child: const Text('Get Anonymous Token'),
            ),
            const SizedBox(height: 40),
            const Text(
              'Or use Ferry Flutter Widget:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


