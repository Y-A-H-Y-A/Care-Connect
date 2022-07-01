import 'package:care_connect/pages/chatroom_page.dart';
import 'package:care_connect/pages/doctor_pages/doctor_main_page.dart';
import 'package:care_connect/pages/main_page.dart';
import 'package:care_connect/pages/login_page.dart';
import 'package:care_connect/pages/messages_page.dart';
import 'package:care_connect/pages/patient_pages/patient_main_page.dart';
import 'package:care_connect/pages/remainder_page.dart';
import 'package:care_connect/pages/search_page.dart';
import 'package:care_connect/pages/signup_page.dart';
import 'package:care_connect/providers/todos_provider.dart';
import 'package:care_connect/services/auth_service.dart';
import 'package:care_connect/services/auth_warpper.dart';
import 'package:care_connect/services/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:provider/provider.dart';
//*This is a Git push test 2
//*Another comment */

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AthenticationService>(
          create: (_) => AthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AthenticationService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: ChangeNotifierProvider(
        create: (BuildContext context) => TodosProvider(),
        child: MaterialApp(
          theme: ThemeData(
              indicatorColor: Colors.white,
              primaryColor: const Color(0xFF39729A),
              primarySwatch: Colors.blueGrey),
          debugShowCheckedModeBanner: false,
          initialRoute: AuthenticationWapper.pageRout,
          routes: {
            Login.pageRout: (context) => const Login(),
            SignUp.pageRout: (context) => const SignUp(),
            AuthenticationWapper.pageRout: (context) =>
                const AuthenticationWapper(),
            SplashPage.pageRout: (context) => const SplashPage(),
            MainPage.pageRout: (context) => const MainPage(),
            SearchPage.pageRout: (context) => const SearchPage(),
            DoctorMainPage.pageRout: (context) => const DoctorMainPage(),
            PatientMainPage.pageRout: (context) => const PatientMainPage(),
            ChatRoom.pageRout: (context) => const ChatRoom(),
            // ReminderPage.pageRout: (context) => const ReminderPage(),
          },
        ),
      ),
    );
  }
}
