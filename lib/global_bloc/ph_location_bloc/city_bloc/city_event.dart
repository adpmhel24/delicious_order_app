import 'package:equatable/equatable.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();
  @override
  List<Object?> get props => [];
}

class FetchCityFromApi extends CityEvent {}

class SearchCityByKeyword extends CityEvent {
  final String keyword;

  const SearchCityByKeyword(this.keyword);

  @override
  List<Object?> get props => [keyword];
}
