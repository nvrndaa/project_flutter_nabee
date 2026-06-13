part of 'transaction_bloc.dart';

@freezed
class TransactionEvent with _$TransactionEvent {
  const factory TransactionEvent.started() = _Started;
  const factory TransactionEvent.fetchTransactions() = _FetchTransactions;
  const factory TransactionEvent.createTransaction(CreateTransactionRequestModel request) = _CreateTransaction;
}
