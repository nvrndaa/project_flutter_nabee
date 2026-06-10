import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool pushNotification = true;
  bool reminders = true;
  bool appUpdates = true;
  bool sounds = true;
  bool vibration = true;
  bool silentMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // --- TAMBAHAN: Honeycomb Background biar serasi dengan halaman lain ---
            Positioned(
              top: 0,
              right: -15,
              child: Opacity(
                opacity: 0.4,
                child: Image.asset(
                  'assets/images/sarang_lebah_atas.png',
                  width: 140,
                ),
              ),
            ),

            // Main Content
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              "Notifications",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4E1F0F),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 48), // Penyeimbang back button
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ICON + TITLE INFO
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF7E1B8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_none,
                            color: Color(0xFFE28A24),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Notifications & Alerts",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4E1F0F),
                              ),
                            ),
                            Text(
                              "Manage how you stay updated.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      "Push notifications",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4E1F0F),
                      ),
                    ),
                    const SizedBox(height: 10),

                    _notificationTile(
                      title: "Push notifications",
                      subtitle: "Enable or disable all push notifications",
                      value: pushNotification,
                      onChanged: (value) {
                        setState(() {
                          pushNotification = value;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Notify me about",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4E1F0F),
                      ),
                    ),
                    const SizedBox(height: 10),

                    _notificationTile(
                      title: "Reminders",
                      subtitle: "Daily saving schedule",
                      value: reminders,
                      onChanged: (value) {
                        setState(() {
                          reminders = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),

                    _notificationTile(
                      title: "App updates & announcements",
                      subtitle: "News, updates and important info",
                      value: appUpdates,
                      onChanged: (value) {
                        setState(() {
                          appUpdates = value;
                        });
                      },
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "Sounds / vibrations",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4E1F0F),
                      ),
                    ),
                    const SizedBox(height: 10),

                    _notificationTile(
                      title: "Sounds",
                      subtitle: "Play notification sounds",
                      value: sounds,
                      onChanged: (value) {
                        setState(() {
                          sounds = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),

                    _notificationTile(
                      title: "Vibration",
                      subtitle: "Vibrate for notifications",
                      value: vibration,
                      onChanged: (value) {
                        setState(() {
                          vibration = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),

                    _notificationTile(
                      title: "Silent mode",
                      subtitle: "Hide notifications silently",
                      value: silentMode,
                      onChanged: (value) {
                        setState(() {
                          silentMode = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F1DF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4E1F0F),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: const Color(0xFFE28A24),
            activeTrackColor:
                const Color(0xFFF7E1B8), // Biar warna track-nya soft saat aktif
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
