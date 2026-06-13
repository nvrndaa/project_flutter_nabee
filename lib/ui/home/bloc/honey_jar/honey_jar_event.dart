part of 'honey_jar_bloc.dart';

@freezed
class HoneyJarEvent with _$HoneyJarEvent {
  const factory HoneyJarEvent.started() = _Started;
  const factory HoneyJarEvent.fetchHoneyJars() = _FetchHoneyJars;
  const factory HoneyJarEvent.createHoneyJar(CreateHoneyJarRequestModel request) = _CreateHoneyJar;
  const factory HoneyJarEvent.updateHoneyJar(int id, UpdateHoneyJarRequestModel request) = _UpdateHoneyJar;
  const factory HoneyJarEvent.deleteHoneyJar(int id) = _DeleteHoneyJar;
}
