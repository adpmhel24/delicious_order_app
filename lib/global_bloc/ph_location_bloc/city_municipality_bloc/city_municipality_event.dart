import 'package:equatable/equatable.dart';

abstract class CityMunicipalityEvent extends Equatable {
  const CityMunicipalityEvent();
  @override
  List<Object?> get props => [];
}

class FetchCityMunicipalityFromApi extends CityMunicipalityEvent {}

class SearchCityMunicipalityByKeyword extends CityMunicipalityEvent {
  final String keyword;

  const SearchCityMunicipalityByKeyword(this.keyword);

  @override
  List<Object?> get props => [keyword];
}
