import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/repositories/repositories.dart';
import './bloc.dart';

class BrgyBloc extends Bloc<BrgyEvent, BrgyState> {
  BrgyBloc() : super(BrgyInitState()) {
    on<FetchBrgyFromLocal>(onFetchingBrgyFromLocal);
    on<FetchBrgyFromApi>(onFetchingBrgyFromAPI);
    on<SearchBrgyByKeyword>(onSearchBrgyByKeyword);
  }
  final PhLocationRepo _phLocationRepo = AppRepo.phLocationRepository;

  void onFetchingBrgyFromLocal(
      FetchBrgyFromLocal event, Emitter<BrgyState> emit) async {
    emit(BrgyLoadingState());
    try {
      if (_phLocationRepo.brgys.isEmpty) {
        await _phLocationRepo.fetchBrgys();
      }
      emit(BrgyLoadedState(_phLocationRepo.brgys));
    } on HttpException catch (e) {
      emit(BrgyErrorState(e.message));
    }
  }

  void onFetchingBrgyFromAPI(
      FetchBrgyFromApi event, Emitter<BrgyState> emit) async {
    emit(BrgyLoadingState());
    try {
      await _phLocationRepo.fetchBrgys();
      emit(BrgyLoadedState(_phLocationRepo.brgys));
    } on HttpException catch (e) {
      emit(BrgyErrorState(e.message));
    }
  }

  void onSearchBrgyByKeyword(
      SearchBrgyByKeyword event, Emitter<BrgyState> emit) {
    emit(BrgyLoadingState());
    emit(BrgyLoadedState(
        _phLocationRepo.searchBarangaysByKeyword(event.keyword)));
  }
}
