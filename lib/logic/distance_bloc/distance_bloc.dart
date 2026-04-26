import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'distance_event.dart';
import 'distance_state.dart';
import 'package:bloc_project_basic/data/networks/response/api_response.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<T> debounce<T>() {
  return (events, mapper) =>
      events.debounceTime(const Duration(milliseconds: 500)).switchMap(mapper);
}

class DistanceBloc extends Bloc<DistanceEvent, DistanceState> {
  DistanceBloc() : super(DistanceState.initial()) {
    on<CalculateDistanceEvent>(_calculateDistance);

    on<FetchFromSuggestionsEvent>(
          (event, emit) async {

        emit(state.copyWith(isFromLoading: true));

        final results = await getLocationSuggestions(event.query);

        emit(state.copyWith(
          fromSuggestions: results,
          isFromLoading: false,
        ));
      },
      transformer: debounce(),
    );

    on<FetchToSuggestionsEvent>(
          (event, emit) async {

        emit(state.copyWith(isToLoading: true));

        final results = await getLocationSuggestions(event.query);

        emit(state.copyWith(
          toSuggestions: results,
          isToLoading: false,
        ));
      },
      transformer: debounce(),
    );

    on<ResetDistanceEvent>((event, emit) {
      emit(
        state.copyWith(
          distanceResponse: const ApiResponse.initial(),
          fromSuggestions: [],
          toSuggestions: [],
        ),
      );
    });
  }

  Future<void> _calculateDistance(
      CalculateDistanceEvent event,
      Emitter<DistanceState> emit,
      ) async {
    try {
      /// 🔄 Loading
      emit(state.copyWith(
        distanceResponse: const ApiResponse.loading(),
      ));

      /// 🔹 Step 1: Convert address → LatLng
      final fromLocations =
      await locationFromAddress(event.from);
      final toLocations =
      await locationFromAddress(event.to);

      final from = fromLocations.first;
      final to = toLocations.first;

      /// 🔹 Step 2: OSRM API
      final url =
          "http://router.project-osrm.org/route/v1/driving/"
          "${from.longitude},${from.latitude};"
          "${to.longitude},${to.latitude}?overview=false";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        double distanceMeters =
        data['routes'][0]['distance'];

        double distanceKm = distanceMeters / 1000;

        String result =
            "${distanceKm.toStringAsFixed(2)} km";

        /// ✅ Success
        emit(state.copyWith(
          distanceResponse:
          ApiResponse.completed(result),
        ));
      } else {
        /// ❌ Error
        emit(state.copyWith(
          distanceResponse:
          const ApiResponse.error("API Error"),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        distanceResponse:
        ApiResponse.error(e.toString()),
      ));
    }
  }



  Future<List<String>> getLocationSuggestions(String query) async {
    if (query.isEmpty) return [];

    final url =
        "https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'User-Agent': 'your_app_name' // important
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return List<String>.from(
        data.map((e) => e['display_name']),
      );
    } else {
      return [];
    }
  }
}

