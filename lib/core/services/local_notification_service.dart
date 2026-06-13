import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class LocalNotificationService {
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  late final FlutterLocalNotificationsPlugin _plugin;

  Future<void> init() async {
    tz_data.initializeTimeZones();
    _plugin = FlutterLocalNotificationsPlugin();
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(settings: initSettings);
  }

  Future<void> scheduleDailyReminder({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final now = DateTime.now();
    final scheduledDate =
        DateTime(now.year, now.month, now.day, hour, minute);
    final tzDate = tz.TZDateTime.from(scheduledDate, tz.local);
    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tzDate,
      notificationDetails: _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleJarReminders({
    required int jarId,
    required String jarName,
    required int timesPerDay,
  }) async {
    final interval = 24 ~/ timesPerDay;
    for (int i = 0; i < timesPerDay; i++) {
      await scheduleDailyReminder(
        id: jarId * 100 + i,
        title: 'Time to save!',
        body: "Don't forget to save honey for '$jarName'",
        hour: i * interval,
        minute: 0,
      );
    }
  }

  Future<void> cancelJarReminders(int jarId) async {
    for (int i = 0; i < 7; i++) {
      await _plugin.cancel(id: jarId * 100 + i);
    }
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'saving_reminder_channel',
        'Saving Reminder',
        channelDescription: 'Reminders to save honey money',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }
}
