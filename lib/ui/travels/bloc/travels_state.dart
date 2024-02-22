part of 'travels_bloc.dart';

@immutable
sealed class TravelsState {}

final class TravelsInitial extends TravelsState {}

final class TravelsLoaded extends TravelsState {
  final List<Travel> travels;
  TravelsLoaded(this.travels);
}

final class TravelsError extends TravelsState {
  final String message;
  TravelsError(this.message);
}
