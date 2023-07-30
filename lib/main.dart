import 'package:flutter/material.dart';
import 'package:flutter_application_2/constante/routes.dart';
import 'package:flutter_application_2/services/auth/auth_service.dart';
import 'package:flutter_application_2/views/Login_View.dart';
import 'package:flutter_application_2/views/notes/new_note_view.dart';
import 'package:flutter_application_2/views/notes/notes_view.dart';
import 'package:flutter_application_2/views/register_view.dart';
import 'package:flutter_application_2/views/verify_email_view.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter',
            theme:ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoutes: (context) => const LoginView(),
        registerRoutes: (context) => const Registerview(),
        notesRoutes: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        newNoteRoute:(context) => const NewNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
