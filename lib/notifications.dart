/*import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'toDoList/Task.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void initNotifications() async{
  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
Future<void> scheduleNotification(Task task) async {
  if (!task.getIfFinished && task.getDate.difference(DateTime.now()).inDays <= 1) {
    var scheduledNotificationDateTime = task.getDate.subtract(Duration(days: 1));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'task_channel', // id
      'Task Notifications', // title
      'Remember to complete your tasks', // description
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.schedule(
      task.hashCode,
      'Tarea próxima a expirar', // Título de la notificación
      'La tarea "${task.getName}" expira mañana.', // Cuerpo de la notificación
      scheduledNotificationDateTime, // Fecha y hora para la notificación
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );
  }
}

Future<void> showTimerNotification(DateTime currentTime) async {
  String formattedTime = '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}:${currentTime.second.toString().padLeft(2, '0')}';

  var androidDetails = AndroidNotificationDetails(
    'task_channel', // ID del canal
    'Session running', // Título del canal
    'Your session timer', // Descripción del canal
    importance: Importance.max,
    priority: Priority.high,
    /*ongoing: true,
    showWhen: false,*/
  );

  var iosDetails = IOSNotificationDetails();

  var generalNotificationDetails = NotificationDetails(
    android: androidDetails,
    iOS: iosDetails,
  );

  await flutterLocalNotificationsPlugin.show(
     DateTime.now().hour*3600 + DateTime.now().minute*60 + DateTime.now().second, // ID de la notificación
    'Timer', // Título
    formattedTime, // Cuerpo
    generalNotificationDetails,
  );
}
Future<void> cancelTaskNotification(Task task) async {
  await flutterLocalNotificationsPlugin.cancel(task.hashCode);
}
*/
