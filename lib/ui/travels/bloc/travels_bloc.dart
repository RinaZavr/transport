import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:transport/data/model/travel_model.dart';
import 'package:transport/data/service/network_service.dart';

part 'travels_event.dart';
part 'travels_state.dart';

class TravelsBloc extends Bloc<TravelsEvent, TravelsState> {
  TravelsBloc() : super(TravelsInitial()) {
    on<GetTravelsEvent>(getTravels);
  }

  getTravels(GetTravelsEvent event, emit) async {
    try{
    emit(TravelsInitial());
    List<Travel> travels = await NetworkService().getTravels(event.departureCity, event.destinationCity, event.date);
    if(travels.isEmpty) {
      emit(TravelsError('Рейсов пока нет'));
      return;
    }
    emit(TravelsLoaded(travels));
    } catch(e) {
      emit(TravelsError(e.toString()));
    }
  }
}
