part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}
class SearchProductEvent extends SearchEvent {
  final String query;
  SearchProductEvent({required this.query});
}
