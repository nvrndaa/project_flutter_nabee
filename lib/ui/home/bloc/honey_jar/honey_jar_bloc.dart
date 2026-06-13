import 'package:bloc/bloc.dart';
import 'package:flutter_nabee/data/datasources/honey_jar_remote_datasource.dart';
import 'package:flutter_nabee/data/model/request/honey_jar_request_model.dart';
import 'package:flutter_nabee/data/model/response/honey_jar_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'honey_jar_event.dart';
part 'honey_jar_state.dart';
part 'honey_jar_bloc.freezed.dart';

class HoneyJarBloc extends Bloc<HoneyJarEvent, HoneyJarState> {
  final HoneyJarRemoteDatasource honeyJarRemoteDatasource;
  HoneyJarBloc(this.honeyJarRemoteDatasource) : super(_Initial()) {
    on<_FetchHoneyJars>((event, emit) async {
      emit(_Loading());
      final response = await honeyJarRemoteDatasource.fetchHoneyJars();
      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Success(data)),
      );
    });

    on<_CreateHoneyJar>((event, emit) async {
      emit(_Loading());
      final response =
          await honeyJarRemoteDatasource.createHoneyJar(event.request);
      response.fold(
        (error) => emit(_Error(error)),
        (data) {
          add(const _FetchHoneyJars());
        },
      );
    });

    on<_UpdateHoneyJar>((event, emit) async {
      emit(_Loading());
      final response = await honeyJarRemoteDatasource
          .updateHoneyJar(event.id, event.request);
      response.fold(
        (error) => emit(_Error(error)),
        (data) {
          add(const _FetchHoneyJars());
        },
      );
    });

    on<_DeleteHoneyJar>((event, emit) async {
      emit(_Loading());
      final response = await honeyJarRemoteDatasource.deleteHoneyJar(event.id);
      response.fold(
        (error) => emit(_Error(error)),
        (data) {
          add(const _FetchHoneyJars());
        },
      );
    });
  }
}
