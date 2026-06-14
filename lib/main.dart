import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nabee/core/services/local_notification_service.dart';
import 'package:flutter_nabee/data/datasources/article_remote_datasource.dart';
import 'package:flutter_nabee/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_nabee/data/datasources/notification_remote_datasource.dart';
import 'package:flutter_nabee/data/datasources/transaction_remote_datasource.dart';
import 'package:flutter_nabee/ui/home/bloc/article/article_bloc.dart';
import 'package:flutter_nabee/ui/home/bloc/notification/notification_bloc.dart';
import 'package:flutter_nabee/ui/home/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_nabee/ui/home/pages/popup_page.dart';
import 'package:flutter_nabee/ui/intro/bloc/login/login_bloc.dart';
import 'package:flutter_nabee/ui/intro/bloc/logout/logout_bloc.dart';
import 'package:flutter_nabee/ui/intro/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService().init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(AuthRemoteDatasource())),
        BlocProvider(create: (context) => LogoutBloc(AuthRemoteDatasource())),
        BlocProvider(
            create: (context) =>
                ArticleBloc(ArticleRemoteDatasource())),
        BlocProvider(
            create: (context) =>
                TransactionBloc(TransactionRemoteDatasource())),
        BlocProvider(
            create: (context) =>
                NotificationBloc(NotificationLogRemoteDatasource())),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CaterpillarPopupPage(),
      ),
    );
  }
}