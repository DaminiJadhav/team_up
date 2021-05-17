import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:teamup/main.dart';
import 'package:teamup/screen/DashboardScreen.dart';
import 'package:teamup/utils/MyNotificationPlugin.dart';
import 'package:teamup/utils/SharedPreference.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {


    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
          onMessage: (Map<String, dynamic> message) async {
        // print("onMessage : $message['notification'][0]['title']");
            myNotificationPlugin
                .setListenerForLowerVersions(onNotificationInLowerVersions);
            myNotificationPlugin.setOnNotificationClick(onNotificationClick);
        await myNotificationPlugin.showNotification(
            'Hello', 'this is body Message');
      }, onLaunch: (Map<String, dynamic> message) async {
        myNotificationPlugin
            .setListenerForLowerVersions(onNotificationInLowerVersions);
        myNotificationPlugin.setOnNotificationClick(onNotificationClick);
        await myNotificationPlugin.showNotification(
            'Hello', 'this is body Message');
      }, onResume: (Map<String, dynamic> message) async {
        myNotificationPlugin
            .setListenerForLowerVersions(onNotificationInLowerVersions);
        myNotificationPlugin.setOnNotificationClick(onNotificationClick);
        await myNotificationPlugin.showNotification(
            'Hello', 'this is body Message');
      });

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
     // print("FirebaseMessaging token: $token");
      Preference.setFcmToken(token);
      _initialized = true;
    }
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('clicked');
  }

  onNotificationClick(String payload) {
    print('clicked');
  }
}
