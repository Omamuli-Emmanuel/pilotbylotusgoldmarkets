import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Define events
abstract class AllWithdrawalsEvent extends Equatable {
  const AllWithdrawalsEvent();

  @override
  List<Object> get props => [];
}

class FetchWithdrawals extends AllWithdrawalsEvent {
  final String uniqueId;

  const FetchWithdrawals(this.uniqueId);

  @override
  List<Object> get props => [uniqueId];
}

class RefreshWithdrawals extends AllWithdrawalsEvent {
  final String uniqueId;

  const RefreshWithdrawals(this.uniqueId);

  @override
  List<Object> get props => [uniqueId];
}

// Define states
abstract class WithdrawalsState extends Equatable {
  const WithdrawalsState();

  @override
  List<Object> get props => [];
}

class WithdrawalInitial extends WithdrawalsState {}

class WithdrawalsLoading extends WithdrawalsState {}

class WithdrawalsLoaded extends WithdrawalsState {
  final List<dynamic> transactions;

  const WithdrawalsLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class WithdrawalsError extends WithdrawalsState {
  final String message;

  const WithdrawalsError(this.message);

  @override
  List<Object> get props => [message];
}

// Define BLoC
class WithdrawalsBloc extends Bloc<AllWithdrawalsEvent, WithdrawalsState> {
  WithdrawalsBloc() : super(WithdrawalInitial()) {
    on<FetchWithdrawals>(_onFetchWithdrawals);
    on<RefreshWithdrawals>(_onRefreshWithdrawals);
  }

  Future<void> _onFetchWithdrawals(FetchWithdrawals event, Emitter<WithdrawalsState> emit) async {
    emit(WithdrawalsLoading());
    try {
      final response = await http.get(Uri.parse('https://www.lotusgoldmarkets.co/api//pull-withdrawals/${event.uniqueId}'));

      print(event.uniqueId);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['transactions'] != null && data['transactions'] is List) {
          emit(WithdrawalsLoaded(data['transactions']));
        } else {
          emit(WithdrawalsError('Failed to fetch transactions: data is not a list'));
        }
      } else {
        emit(WithdrawalsError('Failed to fetch transactions: HTTP ${response.statusCode}'));
      }
    } catch (e) {
      emit(WithdrawalsError('Failed to fetch transactions: $e'));
    }
  }

  Future<void> _onRefreshWithdrawals(RefreshWithdrawals event, Emitter<WithdrawalsState> emit) async {
    // similar to _onFetchTransactions
    await _onFetchWithdrawals(FetchWithdrawals(event.uniqueId), emit);
  }
}
