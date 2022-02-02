import 'package:equatable/equatable.dart';

abstract class ProvinceEvent extends Equatable {
  const ProvinceEvent();
  @override
  List<Object?> get props => [];
}

class FetchProvinceFromLocal extends ProvinceEvent {}

class FetchProvinceFromApi extends ProvinceEvent {}

class SearchProvinceByKeyword extends ProvinceEvent {
  final String keyword;

  const SearchProvinceByKeyword(this.keyword);

  @override
  List<Object?> get props => [keyword];
}
