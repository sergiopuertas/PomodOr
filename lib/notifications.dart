import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  if (!task.getIfFinished() && task.getDate().difference(DateTime.now()).inDays <= 1) {
    var scheduledNotificationDateTime = task.getDate().subtract(Duration(days: 1));
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
      task.hashCode, // ID de la notificación, asegúrate de que sea único para cada tarea
      'Tarea próxima a expirar', // Título de la notificación
      'La tarea "${task.getName()}" expira mañana.', // Cuerpo de la notificación
      scheduledNotificationDateTime, // Fecha y hora para la notificación
      platformChannelSpecifics,
      androidAllowWhileIdle: true, // Para mostrar la notificación incluso cuando el dispositivo está en modo de bajo consumo
    );
  }
}
Future<void> cancelTaskNotification(Task task) async {
  await flutterLocalNotificationsPlugin.cancel(task.hashCode);
}

