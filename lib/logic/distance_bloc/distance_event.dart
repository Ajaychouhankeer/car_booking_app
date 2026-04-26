abstract class DistanceEvent {}

class CalculateDistanceEvent extends DistanceEvent {
  final String from;
  final String to;

  CalculateDistanceEvent({
    required this.from,
    required this.to,
  });
}

class FetchFromSuggestionsEvent extends DistanceEvent {
  final String query;

  FetchFromSuggestionsEvent(this.query);
}

class FetchToSuggestionsEvent extends DistanceEvent {
  final String query;

  FetchToSuggestionsEvent(this.query);
}

class ResetDistanceEvent extends DistanceEvent {}