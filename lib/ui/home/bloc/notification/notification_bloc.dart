import 'package:bloc/bloc.dart';
import 'package:flutter_nabee/data/datasources/notification_remote_datasource.dart';
import 'package:flutter_nabee/data/model/response/notification_log_response_model.dart';

// Events
abstract class NotificationEvent {}
class FetchNotifications extends NotificationEvent {}

// States
abstract class NotificationState {}
class NotificationInitial extends NotificationState {}
class NotificationLoading extends NotificationState {}
class NotificationSuccess extends NotificationState {
  final List<NotificationLogResponseModel> logs;
  NotificationSuccess(this.logs);
}
class NotificationError extends NotificationState {
  final String message;
  NotificationError(this.message);
}

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationLogRemoteDatasource datasource;
  NotificationBloc(this.datasource) : super(NotificationInitial()) {
    on<FetchNotifications>((event, emit) async {
      emit(NotificationLoading());
      final result = await datasource.fetchNotificationLogs();
      result.fold(
        (error) => emit(NotificationError(error)),
        (data) => emit(NotificationSuccess(data)),
      );
    });
  }
}
