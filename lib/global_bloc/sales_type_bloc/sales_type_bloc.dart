import '/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class SalesTypeBloc extends Bloc<SalesTypeEvent, SalesTypeState> {
  final SalesTypeRepo _salesTypeRepo = AppRepo.salesTypeRepository;
  SalesTypeBloc() : super(InitState()) {
    on<FetchSalesTypeFromLocal>(onFetchFromLocal);
    on<FetchSalesTypeFromAPI>(onFetchFromAPI);
  }

  Future<void> onFetchFromLocal(
      FetchSalesTypeFromLocal event, Emitter<SalesTypeState> emit) async {
    emit(LoadingState());
    try {
      if (_salesTypeRepo.salesType.isEmpty) {
        await _salesTypeRepo.fetchFromAPI();
      }
      emit(SalesTypeLoadedState(_salesTypeRepo.salesType));
    } on Exception catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> onFetchFromAPI(
      FetchSalesTypeFromAPI event, Emitter<SalesTypeState> emit) async {
    emit(LoadingState());
    try {
      await _salesTypeRepo.fetchFromAPI();
      emit(SalesTypeLoadedState(_salesTypeRepo.salesType));
    } on Exception catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
