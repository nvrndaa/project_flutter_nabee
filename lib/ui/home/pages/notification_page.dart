import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nabee/ui/home/bloc/notification/notification_bloc.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationBloc>().add(FetchNotifications());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
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

            BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back),
                          ),
                          const Text(
                            "Notification",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Today",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 20),

                      if (state is NotificationLoading)
                        const Padding(
                          padding: EdgeInsets.all(30),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFE28A24),
                            ),
                          ),
                        )
                      else if (state is NotificationSuccess && state.logs.isEmpty)
                        _notificationItem(
                          icon: Icons.notifications_none_outlined,
                          title: "No notifications yet",
                          subtitle: "Start saving to get reminders",
                        )
                      else if (state is NotificationSuccess)
                        ...state.logs.map(
                          (log) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _notificationItem(
                              icon: Icons.notifications_active_outlined,
                              title: "Reminder #${log.reminderNumber}",
                              subtitle: "Don't forget to save today!",
                            ),
                          ),
                        )
                      else
                        Column(
                          children: [
                            _notificationItem(
                              icon: Icons.notifications_none_outlined,
                              title: "Set your notification",
                              subtitle: "Allow notifications on your device",
                            ),
                            const SizedBox(height: 16),
                            _notificationItem(
                              icon: Icons.check_circle_outline,
                              title: "Welcome to Nabee!",
                              subtitle: "Your sign in process is success",
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: Icon(
            icon,
            size: 22,
            color: const Color(0xFF5A2D22),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5A2D22),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
