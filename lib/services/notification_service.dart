import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kitabantu/main.dart';
import 'package:kitabantu/pages/detail_page.dart';

class NotificationService {
  // FIREBASE ==================================================================
  // function to intialize notifications
  Future<void> initNotification() async {
    // create an instance of Firebase Mesaging
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    FirebaseMessaging.instance.getInitialMessage();

    initFirebasePushNotification();
    intiLocalNotification();
  }

  // function to initialize foreground and background settings
  Future initFirebasePushNotification() async {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        showNotification(
          id: message.notification.hashCode,
          title: message.notification!.title,
          body: message.notification!.body,
        );
      }
    });

    // attach event listener for when notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data.isNotEmpty) {
        navigatorKey.currentState!
            .push(MaterialPageRoute(builder: (context) => DetailPage()));
        // Navigator.pushNamed(context, '/details', arguments: message.data['id']);
      }
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      // print(fcmToken);
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    }).onError((err) {
      // Error getting token.
    });
  }

  // LOCAL NOTIFICATION ========================================================
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> intiLocalNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_notification');

    DarwinInitializationSettings initializationSettingsiOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsiOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
        navigatorKey.currentState!
            .push(MaterialPageRoute(builder: (context) => DetailPage()));
      },
    );
  }

  notificatioDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            icon: "ic_notification"),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return flutterLocalNotificationsPlugin.show(
        id, title, body, await notificatioDetails());
  }
}
