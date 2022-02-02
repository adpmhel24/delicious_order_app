import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import '/data/repositories/repositories.dart';

class DiscTypeBloc extends Bloc<DiscTypeEvent, DiscTypeState> {
  final DiscountTypeRepo _discountTypeRepo = AppRepo.discTypeRepository;
  DiscTypeBloc() : super(DiscTypeInitState()) {
    on<FetchDiscTypeFromLocal>(onFetchFromLocal);
    on<FetchDiscTypeFromAPI>(onFetchFromAPI);
  }

  void onFetchFromLocal(
      FetchDiscTypeFromLocal event, Emitter<DiscTypeState> emit) async {
    emit(DiscTypeLoadingState());
    try {
      if (_discountTypeRepo.discTypes.isEmpty) {
        await _discountTypeRepo.fetchDiscType();
      }
    } on HttpException catch (e) {
      emit(DiscTypeError(e.message));
    }
    emit(DiscTypeLoadedState(_discountTypeRepo.discTypes));
  }

  void onFetchFromAPI(
      FetchDiscTypeFromAPI event, Emitter<DiscTypeState> emit) async {
    emit(DiscTypeLoadingState());
    try {
      await _discountTypeRepo.fetchDiscType();
    } on HttpException catch (e) {
      emit(DiscTypeError(e.message));
    }
    emit(DiscTypeLoadedState(_discountTypeRepo.discTypes));
  }
}
