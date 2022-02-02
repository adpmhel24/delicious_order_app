import 'package:equatable/equatable.dart';

abstract class MunicipalityEvent extends Equatable {
  const MunicipalityEvent();
  @override
  List<Object?> get props => [];
}

class FetchMunicipalityFromApi extends MunicipalityEvent {}

class SearchMunicipalityByKeyword extends MunicipalityEvent {
  final String keyword;

  const SearchMunicipalityByKeyword(this.keyword);

  @override
  List<Object?> get props => [keyword];
}
