import 'package:bloc/bloc.dart';
import 'package:flutter_nabee/data/datasources/auth_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRemoteDatasource _authRemoteDatasource;
  LogoutBloc(this._authRemoteDatasource) : super(_Initial()) {
    on<_Logout>((event, emit) async {
      emit(_Loading());
      final response = await _authRemoteDatasource.logout();
      if (isClosed) return;
      response.fold((error) => emit(_Error(error)), (data) => emit(_Success()));
    });
  }
}
