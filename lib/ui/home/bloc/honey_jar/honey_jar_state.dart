part of 'honey_jar_bloc.dart';

@freezed
class HoneyJarState with _$HoneyJarState {
  const factory HoneyJarState.initial() = _Initial;
  const factory HoneyJarState.loading() = _Loading;
  const factory HoneyJarState.success(List<HoneyJarResponseModel> data) = _Success;
  const factory HoneyJarState.error(String message) = _Error;
}
