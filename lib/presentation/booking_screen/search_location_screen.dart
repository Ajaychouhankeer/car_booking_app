import 'package:bloc_project_basic/core/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/distance_bloc/distance_bloc.dart';
import '../../logic/distance_bloc/distance_event.dart';
import '../../logic/distance_bloc/distance_state.dart';

class SearchLocationScreen extends StatefulWidget {
  final bool isPickup;

  const SearchLocationScreen({super.key, required this.isPickup});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isPickup ? "Select Pickup" : "Select Drop"),
      ),

      body: Column(
        children: [

          /// 🔍 SEARCH FIELD
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search location...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                if (widget.isPickup) {
                  context.read<DistanceBloc>()
                      .add(FetchFromSuggestionsEvent(value));
                } else {
                  context.read<DistanceBloc>()
                      .add(FetchToSuggestionsEvent(value));
                }
              },
            ),
          ),

          /// 📍 SUGGESTIONS FULL SCREEN
          Expanded(
            child: BlocBuilder<DistanceBloc, DistanceState>(
              builder: (context, state) {

                final suggestions = widget.isPickup
                    ? state.fromSuggestions
                    : state.toSuggestions;

                if (suggestions.isEmpty) {
                  return const Center(child: Text("No results"));
                }

                return ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = suggestions[index];

                    return ListTile(
                      leading: Icon(Icons.location_on,color: AppColors.MainBlueColor,),
                      title: _highlightText(
                        suggestion,
                        searchController.text,
                      ),
                      onTap: () {
                        Navigator.pop(context, suggestion);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _highlightText(String text, String query) {
    if (query.isEmpty) {
      return Text(text);
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();

    final startIndex = lowerText.indexOf(lowerQuery);

    if (startIndex == -1) {
      return Text(text);
    }

    final endIndex = startIndex + query.length;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text.substring(0, startIndex),
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: text.substring(startIndex, endIndex),
            style: TextStyle(
              color: AppColors.orrangeMain,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: text.substring(endIndex),
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}