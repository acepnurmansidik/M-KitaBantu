import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitabantu/cubit/auth_cubit.dart';
import 'package:kitabantu/cubit/page_cubit.dart';
import 'package:kitabantu/cubit/users_cubit.dart';
import 'package:kitabantu/pages/get_startred_page.dart';
import 'package:kitabantu/pages/main_page.dart';
import 'package:kitabantu/pages/signin_page.dart';
import 'package:kitabantu/pages/signup_page.dart';
import 'package:kitabantu/pages/splash_page.dart';
import 'package:kitabantu/pages/success_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kitabantu/services/notification_service.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle the message here.
  print("Handling a background message: ${message.messageId}");
  print(message.notification);
  // print(message.data);
}

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService().initNotification();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
          BlocProvider(
            create: (context) => UsersCubit(),
          ),
          BlocProvider(
            create: (context) => AuthCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
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
