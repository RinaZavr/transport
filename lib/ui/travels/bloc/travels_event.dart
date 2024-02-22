part of 'travels_bloc.dart';

@immutable
sealed class TravelsEvent {}

class GetTravelsEvent extends TravelsEvent {
  String departureCity;
  String destinationCity;
  DateTime date;
  GetTravelsEvent({required this.departureCity, required this.destinationCity, required this.date});
}