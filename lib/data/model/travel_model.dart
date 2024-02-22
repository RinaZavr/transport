import 'package:intl/intl.dart';

class Travel {
  Travel({
    required this.carrier,
    required this.bus,
    required this.cost,
    required this.departureCity,
    required this.departureAddress,
    required this.destinationCity,
    required this.destinationAddress,
    required this.departureTime,
    required this.arrivalTime
  });
  final String carrier;
  final String bus;
  final String cost;
  final String departureCity;
  final String departureAddress;
  final String destinationCity;
  final String destinationAddress;
  final DateTime departureTime;
  final DateTime arrivalTime;
  
  Travel.fromJson(Map<String, dynamic> json)
      : carrier = json['Carrier'],
       bus = json['Bus']['Model'],
       cost = json['PassengerFareCost'],
       departureCity = json['Departure']['Name'],
       departureAddress = json['Departure']['LocationType'],
       destinationCity = json['Destination']['Name'],
       destinationAddress = json['Destination']['LocationType'],
       departureTime = DateFormat("yyyy-MM-dd HH:mm").parse('${json['DepartureTime'].split('T').first} ${json['DepartureTime'].split('T').last}'),
       arrivalTime = DateFormat("yyyy-MM-dd HH:mm").parse('${json['ArrivalTime'].split('T').first} ${json['DepartureTime'].split('T').last}');
}