import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kid_good_good/kid/kid.dart';
import 'package:timezone/timezone.dart' as tz;

import 'main.dart';

final notificationProvider =
    FutureProvider.family<FlutterLocalNotificationsPlugin, BuildContext>(
        (ref, context) async {
  final selectNotification = (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }

    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => SummaryPage(
            title: 'Summary', kid: ref.watch(selectedKidProvider)),
      ),
    );
  };

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  // final IOSInitializationSettings initializationSettingsIOS =
  // IOSInitializationSettings(
  //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  // final MacOSInitializationSettings initializationSettingsMacOS =
  // MacOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    // iOS: initializationSettingsIOS,
    // macOS: initializationSettingsMacOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);

  debugPrint('Loaded FlutterLocalNotificationsPlugin');

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('Kid Good Good', 'Tap to add points for kids',
          channelDescription: 'helper application for tracking kids behaviors',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(0, 'Kid Good Good',
      'Tap to add points for kids', platformChannelSpecifics,
      payload: '');

  return flutterLocalNotificationsPlugin;
});

class NotificationBuilder extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final FlutterLocalNotificationsPlugin item = watch(notificationProvider(context));
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> _scheduleDailyTenAMNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'daily scheduled notification title',
        'daily scheduled notification body',
        _nextInstanceOfTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails('daily notification channel id',
              'daily notification channel name',
              channelDescription: 'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
