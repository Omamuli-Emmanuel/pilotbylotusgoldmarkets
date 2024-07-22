import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Define events
abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

class FetchTransactions extends TransactionsEvent {
  final String uniqueId;

  const FetchTransactions(this.uniqueId);

  @override
  List<Object> get props => [uniqueId];
}

class RefreshTransactions extends TransactionsEvent {
  final String uniqueId;

  const RefreshTransactions(this.uniqueId);

  @override
  List<Object> get props => [uniqueId];
}

// Define states
abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<dynamic> transactions;

  const TransactionLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);

  @override
  List<Object> get props => [message];
}

// Define BLoC
class TransactionsBloc extends Bloc<TransactionsEvent, TransactionState> {
  TransactionsBloc() : super(TransactionInitial()) {
    on<FetchTransactions>(_onFetchTransactions);
    on<RefreshTransactions>(_onRefreshTransactions);
  }

  Future<void> _onFetchTransactions(FetchTransactions event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    try {
      final response = await http.get(Uri.parse('https://www.lotusgoldmarkets.co/api/pull-transactions/${event.uniqueId}'));

      print(event.uniqueId);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['transactions'] != null && data['transactions'] is List) {
          emit(TransactionLoaded(data['transactions']));
        } else {
          emit(TransactionError('Failed to fetch transactions: data is not a list'));
        }
      } else {
        emit(TransactionError('Failed to fetch transactions: HTTP ${response.statusCode}'));
      }
    } catch (e) {
      emit(TransactionError('Failed to fetch transactions: $e'));
    }
  }

  Future<void> _onRefreshTransactions(RefreshTransactions event, Emitter<TransactionState> emit) async {
    // similar to _onFetchTransactions
    await _onFetchTransactions(FetchTransactions(event.uniqueId), emit);
  }
}
