import 'package:equatable/equatable.dart';

abstract class CustTypeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCustTypeFromLocal extends CustTypeEvent {}

class FetchCustTypeFromAPI extends CustTypeEvent {}

class SearchCustTypeByKeyword extends CustTypeEvent {
  final String keyword;

  SearchCustTypeByKeyword(this.keyword);
  @override
  List<Object> get props => [keyword];
}
