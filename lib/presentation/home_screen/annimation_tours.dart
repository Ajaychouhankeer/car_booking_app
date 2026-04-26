import 'package:bloc_project_basic/core/constants/image_constant.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../../data/models/category_model.dart';


class AnimatedTourSection extends StatefulWidget {
  const AnimatedTourSection({super.key});

  @override
  State<AnimatedTourSection> createState() => _AnimatedTourSectionState();
}

class _AnimatedTourSectionState extends State<AnimatedTourSection> {
  final PageController _controller = PageController(viewportFraction: 0.75);
  double currentPage = 0;

  final List<TourCategory> tours = [
    TourCategory(
      title: "Darshan Tours",
      icon: Icons.temple_hindu,
      image: ImageConstants.CtDarshan,
    ),
    TourCategory(
      title: "Family Tours",
      icon: Icons.family_restroom,
      image:ImageConstants.CtFamily,
    ),
    TourCategory(
      title: "Group Tours",
      icon: Icons.groups,
      image: ImageConstants.CtFamily,
    ),
    TourCategory(
      title: "Business Tours",
      icon: Icons.business_center,
      image: ImageConstants.CtBusiness,
    ),
    TourCategory(
      title: "Airport Transport",
      icon: Icons.flight,
      image: ImageConstants.CtAirportDrop,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: _controller,
        itemCount: tours.length,
        itemBuilder: (context, index) {
          final scale = max(0.85, 1 - (currentPage - index).abs() * 0.2);

          return Transform.scale(
            scale: scale,
            child: _buildCard(tours[index]),
          );
        },
      ),
    );
  }

  Widget _buildCard(TourCategory tour) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(tour.image),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ],
      ),

      child: Stack(
        children: [

          /// DARK OVERLAY (text visible karne ke liye)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.2),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          /// CONTENT
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(tour.icon, size: 40, color: Colors.white),
                const SizedBox(height: 10),
                Text(
                  tour.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}