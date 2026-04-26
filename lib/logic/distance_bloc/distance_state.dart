import 'package:bloc_project_basic/data/networks/response/api_response.dart';

class DistanceState {
  final ApiResponse<String> distanceResponse;

  final List<String> fromSuggestions;
  final List<String> toSuggestions;
  final bool isFromLoading;
  final bool isToLoading;

  DistanceState({
    required this.distanceResponse,
    this.fromSuggestions = const [],
    this.toSuggestions = const [],
    this.isFromLoading = false,
    this.isToLoading = false,
  });

  /// Initial state
  factory DistanceState.initial() {
    return DistanceState(
      distanceResponse: const ApiResponse.initial(),
    );
  }

  /// CopyWith (important for updates)
  DistanceState copyWith({
    ApiResponse<String>? distanceResponse,
    List<String>? fromSuggestions,
    List<String>? toSuggestions,
    bool? isFromLoading,
    bool? isToLoading,
  }) {
    return DistanceState(
      distanceResponse:
      distanceResponse ?? this.distanceResponse,
      fromSuggestions: fromSuggestions ?? this.fromSuggestions,
      toSuggestions: toSuggestions ?? this.toSuggestions,
      isFromLoading: isFromLoading ?? this.isFromLoading,
      isToLoading: isToLoading ?? this.isToLoading,

    );
  }
}