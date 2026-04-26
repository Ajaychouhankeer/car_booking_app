import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/distance_bloc/distance_bloc.dart';
import '../../logic/distance_bloc/distance_event.dart';
import '../../logic/distance_bloc/distance_state.dart';

class DistanceSearchScreen extends StatefulWidget {
  final bool isFrom;

  const DistanceSearchScreen({super.key, required this.isFrom});

  @override
  State<DistanceSearchScreen> createState() =>
      _DistanceSearchScreenState();
}

class _DistanceSearchScreenState
    extends State<DistanceSearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// clear old suggestions
    Future.microtask(() {
      if (widget.isFrom) {
        context.read<DistanceBloc>()
            .add(FetchFromSuggestionsEvent(""));
      } else {
        context.read<DistanceBloc>()
            .add(FetchToSuggestionsEvent(""));
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onSearchChanged(String value) {
    if (widget.isFrom) {
      context
          .read<DistanceBloc>()
          .add(FetchFromSuggestionsEvent(value));
    } else {
      context
          .read<DistanceBloc>()
          .add(FetchToSuggestionsEvent(value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// 🔹 APP BAR
      appBar: AppBar(
        title: Text(widget.isFrom ? "Pickup Location" : "Drop Location"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: Column(
        children: [

          /// 🔍 SEARCH FIELD
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              autofocus: true,
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: widget.isFrom
                    ? "Search pickup location"
                    : "Search drop location",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding:
                const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          /// 🔽 FULL SCREEN SUGGESTIONS
          Expanded(
            child: BlocBuilder<DistanceBloc, DistanceState>(
              builder: (context, state) {
                final suggestions = widget.isFrom
                    ? state.fromSuggestions
                    : state.toSuggestions;

                final isLoading = widget.isFrom
                    ? state.isFromLoading
                    : state.isToLoading;

                /// 🔄 LOADING
                if (isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                /// ❌ EMPTY
                if (suggestions.isEmpty) {
                  return const Center(
                    child: Text("No locations found"),
                  );
                }

                /// ✅ LIST
                return ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final item = suggestions[index];

                    return ListTile(
                      leading: const Icon(Icons.location_on),

                      /// 🔥 HIGHLIGHT TEXT
                      title: highlightText(item, controller.text),

                      onTap: () {
                        Navigator.pop(context, item); // ✅ return
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
}

/// 🔥 TEXT HIGHLIGHT FUNCTION
Widget highlightText(String text, String query) {
  if (query.isEmpty) return Text(text);

  final lowerText = text.toLowerCase();
  final lowerQuery = query.toLowerCase();

  final startIndex = lowerText.indexOf(lowerQuery);

  if (startIndex == -1) return Text(text);

  final endIndex = startIndex + query.length;

  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: text.substring(0, startIndex),
          style: const TextStyle(color: Colors.black),
        ),
        TextSpan(
          text: text.substring(startIndex, endIndex),
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: text.substring(endIndex),
          style: const TextStyle(color: Colors.black),
        ),
      ],
    ),
  );
}