import 'package:equatable/equatable.dart';

abstract class BrgyEvent extends Equatable {
  const BrgyEvent();
  @override
  List<Object?> get props => [];
}

class FetchBrgyFromLocal extends BrgyEvent {}

class FetchBrgyFromApi extends BrgyEvent {}

class SearchBrgyByKeyword extends BrgyEvent {
  final String keyword;

  const SearchBrgyByKeyword(this.keyword);

  @override
  List<Object?> get props => [keyword];
}
