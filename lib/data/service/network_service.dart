import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:transport/data/model/travel_model.dart';

class NetworkService {
  final dio = Dio();
  String url = 'https://bibiptrip.com/api/avibus/search_trips_cities/';

  Future<List<Travel>> getTravels(
      String departureCity, String destinationCity, DateTime date) async {
    final response = await dio.get(
        '$url?departure_city=$departureCity&destination_city=$destinationCity&date=${DateFormat('yyyy-MM-dd').format(date)}');
    List<Travel> travels = [];
    if (response.statusCode == 200) {
      for (var travel in response.data['trips']) {
        travels.add(Travel.fromJson(travel));
      }
    }
    return travels;
  }
}
