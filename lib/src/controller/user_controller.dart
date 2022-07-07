import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:kado/src/models/kado_user_model.dart';

import '../../main.dart';
import '../database/db_service.dart';

class UserController extends GetxController {
  final KadoUserModel _userModel;

  UserController(this._userModel);

  KadoUserModel get userModel => _userModel;
  RxBool reminder = RxBool(false);
  @override
  void onReady() {
    super.onReady();
    reminder.bindStream(DBService.getUserReminder());
    reminder.listen((option) {
      if (!option) {
        flutterLocalNotificationsPlugin.cancel(0);
        return;
      }
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('Reminder', 'reminder',
              channelDescription: 'reminder for kado');
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'Reminder',
        'Remember to do your flash cards',
        RepeatInterval.hourly,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
      );
    });
  }
}
