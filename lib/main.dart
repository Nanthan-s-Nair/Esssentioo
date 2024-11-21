import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:esssentioo/themez/theseselection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'amplifyconfiguration.dart';
import 'package:esssentioo/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAmplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.configure(amplifyconfig);
      setState(() => _isAmplifyConfigured = true);
      print('Successfully configured');
    } on Exception catch (e) {
      print('Error configuring Amplify: $e');
    }
  }

  Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    return result.isSignedIn;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Authenticator(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeProvider.themeData,
              builder: Authenticator.builder(),
              home: _isAmplifyConfigured
                  ? FutureBuilder(
                      future: isUserSignedIn(),
                      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData && snapshot.data == true) {
                          // Navigate to HomePage if user is already signed in
                          return const HomePage();
                        } else {
                          // Redirect to SignInPage
                          return const SignInPage();
                        }
                      },
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              final result = await Amplify.Auth.signInWithWebUI();
              if (result.isSignedIn) {
                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }
            } catch (e) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error signing in: $e')),
              );
            }
          },
          child: const Text('Submit'),
        ),
      ),
    );
  }
}
