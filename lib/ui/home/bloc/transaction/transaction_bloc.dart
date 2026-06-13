import 'package:bloc/bloc.dart';
import 'package:flutter_nabee/data/datasources/transaction_remote_datasource.dart';
import 'package:flutter_nabee/data/model/request/transaction_request_model.dart';
import 'package:flutter_nabee/data/model/response/transaction_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';
part 'transaction_bloc.freezed.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRemoteDatasource transactionRemoteDatasource;
  TransactionBloc(this.transactionRemoteDatasource) : super(_Initial()) {
    on<_FetchTransactions>((event, emit) async {
      emit(_Loading());
      final response = await transactionRemoteDatasource.fetchTransactions();
      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Success(data)),
      );
    });

    on<_CreateTransaction>((event, emit) async {
      emit(_Loading());
      final response =
          await transactionRemoteDatasource.createTransaction(event.request);
      response.fold(
        (error) => emit(_Error(error)),
        (data) {
          add(const _FetchTransactions());
        },
      );
    });
  }
}
