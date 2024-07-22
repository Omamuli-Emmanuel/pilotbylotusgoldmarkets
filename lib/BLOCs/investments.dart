import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Define abstract classes for events
abstract class InvestEvent {}

// Concrete event classes
class FetchInvestments extends InvestEvent {
  final String uniqueId;
  FetchInvestments(this.uniqueId);
}

class RefreshInvestments extends InvestEvent {
  final String uniqueId;
  RefreshInvestments(this.uniqueId);
}

// Define abstract classes for states
abstract class InvestState {}

// Concrete state classes
class InvestLoadingState extends InvestState {}

class InvestLoadedState extends InvestState {
  final List<dynamic> investments;
  InvestLoadedState(this.investments);
}

class InvestErrorState extends InvestState {
  final String message;
  InvestErrorState(this.message);
}

// Define BLoC
class InvestBloc extends Bloc<InvestEvent, InvestState> {
  InvestBloc() : super(InvestLoadingState());

  @override
  Stream<InvestState> mapEventToState(InvestEvent event) async* {
    if (event is FetchInvestments || event is RefreshInvestments) {
      yield InvestLoadingState();
      try {
        final investments = await _fetchInvestments((event as dynamic).uniqueId);
        yield InvestLoadedState(investments);
      } catch (error) {
        yield InvestErrorState('Failed to fetch investments');
      }
    }
  }

  Future<List<dynamic>> _fetchInvestments(String uniqueId) async {
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
        List<dynamic> investments = jsonResponse['opportunities'];
        return investments;
      } else {
        throw Exception('Failed to load investments. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching investments: $error');
      throw Exception('Failed to fetch investments: $error');
    }
  }
}
