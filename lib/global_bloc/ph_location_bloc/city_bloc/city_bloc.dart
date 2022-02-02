import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/repositories/repositories.dart';
import './bloc.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(CityInitState()) {
    on<FetchCityFromApi>(onFetchingCityFromAPI);
    on<SearchCityByKeyword>(onSearchCityByKeyword);
  }
  final PhLocationRepo _phLocationRepo = AppRepo.phLocationRepository;

  void onFetchingCityFromAPI(
      FetchCityFromApi event, Emitter<CityState> emit) async {
    emit(CityLoadingState());
    try {
      await _phLocationRepo.fetchCity();
      emit(CityLoadedState(_phLocationRepo.cities));
    } on Exception catch (e) {
      emit(CityErrorState(e.toString()));
    }
  }

  void onSearchCityByKeyword(
      SearchCityByKeyword event, Emitter<CityState> emit) {
    emit(CityLoadingState());
    emit(CityLoadedState(_phLocationRepo.searchCityByKeyword(event.keyword)));
  }
}
