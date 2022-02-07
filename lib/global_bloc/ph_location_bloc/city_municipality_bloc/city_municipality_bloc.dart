import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/repositories/repositories.dart';
import './bloc.dart';

class CityMunicipalityBloc
    extends Bloc<CityMunicipalityEvent, CityMunicipalityState> {
  CityMunicipalityBloc() : super(CityMunicipalityInitState()) {
    on<FetchCityMunicipalityFromApi>(onFetchCityMunicipalityFromApi);
    on<FetchCityMunicipalityFromLocal>(onFetchCityMunicipalityFromLocal);
    on<SearchCityMunicipalityByKeyword>(onsearchCityMunicipalityByKeyword);
  }
  final PhLocationRepo _phLocationRepo = AppRepo.phLocationRepository;

  void onFetchCityMunicipalityFromApi(FetchCityMunicipalityFromApi event,
      Emitter<CityMunicipalityState> emit) async {
    emit(CityMunicipalityLoadingState());
    try {
      await _phLocationRepo.fetchCitiesMunicipalities();
      emit(CityMunicipalityLoadedState(_phLocationRepo.cities));
    } on HttpException catch (e) {
      emit(CityMunicipalityErrorState(e.message));
    }
  }

  void onFetchCityMunicipalityFromLocal(FetchCityMunicipalityFromLocal event,
      Emitter<CityMunicipalityState> emit) async {
    emit(CityMunicipalityLoadingState());
    try {
      if (_phLocationRepo.cities.isEmpty) {
        await _phLocationRepo.fetchCitiesMunicipalities();
      }
      emit(CityMunicipalityLoadedState(_phLocationRepo.cities));
    } on HttpException catch (e) {
      emit(CityMunicipalityErrorState(e.message));
    }
  }

  void onsearchCityMunicipalityByKeyword(SearchCityMunicipalityByKeyword event,
      Emitter<CityMunicipalityState> emit) {
    emit(CityMunicipalityLoadingState());
    emit(CityMunicipalityLoadedState(
        _phLocationRepo.searchCityMunicipalityByKeyword(event.keyword)));
  }
}
