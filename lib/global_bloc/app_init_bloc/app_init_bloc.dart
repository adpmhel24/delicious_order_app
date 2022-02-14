import '../../data/repositories/repositories.dart';
import './bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInitBloc extends Bloc<AppInitEvent, AppInitState> {
  AppInitBloc() : super(OpeningAppState()) {
    on<OpeningApp>(onOpeningApp);
    on<AddingNewURL>(onAddingURL);
  }

  final VersionRepo _versionRepo = VersionRepo();

  void onOpeningApp(OpeningApp event, Emitter<AppInitState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("url") == null) {
      emit(NoURLState());
    } else {
      emit(AddedNewURlState(prefs.getString("url")!));
    }

    if (prefs.getString("url") != null) {
      // Check if there's update available after adding url.
      if (await _versionRepo.isUpdatedAvailable()) {
        emit(NewUpdateAvailable(
            _versionRepo.currentVersion, _versionRepo.packageInfo));
      } else {
        emit(NoUpdateAvailable());
      }
    }
  }

  void onAddingURL(AddingNewURL event, Emitter<AppInitState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("url", event.url);
    emit(AddedNewURlState(prefs.getString("url")!));

    if (prefs.getString("url") != null) {
      // Check if there's update available after adding url.
      if (await _versionRepo.isUpdatedAvailable()) {
        emit(NewUpdateAvailable(
            _versionRepo.currentVersion, _versionRepo.packageInfo));
      } else {
        emit(NoUpdateAvailable());
      }
    }
  }
}
