import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitabantu/cubit/page_cubit.dart';
import 'package:kitabantu/pages/get_startred_page.dart';
import 'package:kitabantu/pages/main_page.dart';
import 'package:kitabantu/pages/signin_page.dart';
import 'package:kitabantu/pages/signup_page.dart';
import 'package:kitabantu/pages/splash_page.dart';
import 'package:kitabantu/pages/success_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler() async {
  // Handle a background message
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Request permission
  FirebaseMessaging.instance.requestPermission();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.getInitialMessage();
  // FirebaseMessaging.onMessage.listen((message) {
  //   print("onMessage");
  //   print(message.notification);
  //   print(message.notification);
  // });

  // FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //   print("onMessageOpenedApp");
  //   print(message);
  // });

  // FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
  //   // TODO: If necessary send token to application server.
  //   print(fcmToken);
  //   // Note: This callback is fired at each app startup and whenever a new
  //   // token is generated.
  // }).onError((err) {
  //   // Error getting token.
  // });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PageCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const SplashScreenPage(),
            '/get-started': (context) => const GetStartedPage(),
            '/main': (context) => const MainPage(),
            '/success': (context) => const SuccessPage(),
            '/sign-in': (context) => const SigninPage(),
            '/sign-up': (context) => const SignupPage(),
          },
        ));
  }
}
