import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../pages/Invest.dart';


// Define abstract classes for events
abstract class WithdrawEvent {}

// Concrete event classes
class FetchWithdrawals extends WithdrawEvent {
  final String uniqueId;
  FetchWithdrawals(this.uniqueId);
}

class RefreshWithdrawals extends WithdrawEvent {
  final String uniqueId;
  RefreshWithdrawals(this.uniqueId);
}

// Define state
class WithdrawState {
  final List<dynamic> withdrawals;
  WithdrawState(this.withdrawals);
}

// Define BLoC
class InvestBloc extends Bloc<WithdrawEvent, WithdrawState> {
  InvestBloc() : super(WithdrawState([]));

  @override
  Stream<WithdrawState> mapEventToState(WithdrawEvent event) async* {
    if (event is FetchWithdrawals) {
      yield await _fetchInvestments(event.uniqueId);
    } else if (event is RefreshWithdrawals) {
      yield await _fetchInvestments(event.uniqueId);
    }
  }

  Future<WithdrawState> _fetchInvestments(String uniqueId) async {
    try {
      final response = await http.get(
        Uri.parse('https://www.lotusgoldmarkets.co/api/investments/$uniqueId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer YOUR_JWT_TOKEN', // Ensure you include the JWT token if needed
        },
      );

      print('HTTP Response Code: ${response.statusCode}');
      print('HTTP Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> withdrawals = jsonResponse['opportunities'];
        return WithdrawState(withdrawals);
      } else {
        throw Exception('Failed to load investments. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching investments: $error');
      throw Exception('Failed to fetch investments: $error');
    }
  }
}
