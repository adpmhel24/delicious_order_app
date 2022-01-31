import './bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInitBloc extends Bloc<AppInitEvent, AppInitState> {
  AppInitBloc() : super(OpeningAppState()) {
    on<OpeningApp>(onOpeningApp);
    on<AddingNewURL>(onAddingURL);
  }

  void onOpeningApp(OpeningApp event, Emitter<AppInitState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("url") == null) {
      emit(NoURLState());
    } else {
      emit(AddedNewURlState(prefs.getString("url")!));
    }
  }

  void onAddingURL(AddingNewURL event, Emitter<AppInitState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("url", event.url);
    emit(AddedNewURlState(prefs.getString("url")!));
  }
}
