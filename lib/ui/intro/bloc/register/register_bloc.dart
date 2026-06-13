import 'package:bloc/bloc.dart';
import 'package:flutter_nabee/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_nabee/data/model/request/register_request_model.dart';
import 'package:flutter_nabee/data/model/response/login_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource authRemoteDatasource;
  RegisterBloc(this.authRemoteDatasource) : super(_Initial()) {
    on<_Register>((event, emit) async {
      emit(_Loading());
      final dataRequest = RegisterRequestModel(
        name: event.name,
        email: event.email,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
      );
      final response = await authRemoteDatasource.register(dataRequest);
      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Success(data)),
      );
    });
  }
}
