import 'package:bloc_project_basic/core/themes/app_text_style.dart';
import 'package:bloc_project_basic/core/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';
import '../../core/constants/string_constants.dart';
import '../../logic/distance_bloc/distance_bloc.dart';
import '../../logic/distance_bloc/distance_event.dart';
import '../../logic/distance_bloc/distance_state.dart';
import 'package:bloc_project_basic/data/networks/response/status.dart';

import 'distance_search_screen.dart';


class DistanceScreen extends StatefulWidget {
  const DistanceScreen({super.key});

  @override
  State<DistanceScreen> createState() => DistanceScreenState();
}

class DistanceScreenState extends State<DistanceScreen> {

  final fromController = TextEditingController();
  final toController = TextEditingController();

  @override
  void dispose() {
    fromController.clear();
    toController.clear();

    fromController.dispose();
    toController.dispose();

    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  void clearFields() {
    /// clear text
    fromController.clear();
    toController.clear();

    context.read<DistanceBloc>().add(FetchFromSuggestionsEvent(""));
    context.read<DistanceBloc>().add(FetchToSuggestionsEvent(""));
    context.read<DistanceBloc>().add(ResetDistanceEvent());
  }



  void calculateDistance() {
    if (fromController.text.isEmpty || toController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both locations")),
      );
      return;
    }

    context.read<DistanceBloc>()
        .add(FetchFromSuggestionsEvent(""));
    context.read<DistanceBloc>()
        .add(FetchToSuggestionsEvent(""));

    context.read<DistanceBloc>().add(
      CalculateDistanceEvent(
        from: fromController.text.trim(),
        to: toController.text.trim(),
      ),
    );
  }

  void swapLocations() {
    final temp = fromController.text;
    fromController.text = toController.text;
    toController.text = temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,

      appBar: CommonWidgets.appBar(
        backgroundColor: AppColors.lightDarkBackgroundColor,
        title: 'Trip Distance',
        centerTitle: false,
      //    wantBackButton: false
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringConstants.enterTripLocation,
              style: AppTextStyle.titleStyleLB20bb,
            ),

            Text(
              StringConstants.findExactDistacne,
              style: AppTextStyle.titleStyleLB12bb,
            ),
            CommonWidgets.verticalSpace(height: 10),
            /// 🔷 Card UI
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lightDarkCardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Column(
                    children: [

                      /// FROM FIELD

                      /// 🔽 FROM SUGGESTIONS (BLOC BASED)
                      Builder(
                        builder: (context) {
                          return GestureDetector(
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DistanceSearchScreen(isFrom: true),
                                ),
                              );

                              if (result != null) {
                                fromController.text = result;
                              }
                            },
                            child: AbsorbPointer(
                              child: TextField(
                                controller: fromController,
                                decoration: InputDecoration(
                                  labelText: StringConstants.from,
                                  prefixIcon: const Icon(Icons.location_on),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  ValueListenableBuilder(
                    valueListenable: fromController,
                    builder: (context, _, __) {
                      return ValueListenableBuilder(
                        valueListenable: toController,
                        builder: (context, __, ___) {

                          if (fromController.text.isEmpty &&
                              toController.text.isEmpty) {
                            return const SizedBox();
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              /// 🔁 SWAP
                              GestureDetector(
                                onTap: swapLocations,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.swap_vert),
                                ),
                              ),

                              const SizedBox(width: 10),

                              /// ❌ CLEAR
                              GestureDetector(
                                onTap: clearFields,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.close, color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  Column(
                    children: [

                      /// 🔽 TO SUGGESTIONS
                      Builder(
                        builder: (context) {
                          return GestureDetector(
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DistanceSearchScreen(isFrom: false),
                                ),
                              );

                              if (result != null) {
                                toController.text = result;
                              }
                            },
                            child: AbsorbPointer(
                              child: TextField(
                                controller: toController,
                                decoration: InputDecoration(
                                  labelText: StringConstants.to,
                                  prefixIcon: const Icon(Icons.flag),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// BUTTON

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: calculateDistance,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.MainBlueColor,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child:  Text(
                        StringConstants.calculateDistance,
                        style: AppTextStyle.titleStyle16bb.copyWith(
                          color: AppColors.white
                        ),
                      ),


                    ),



                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// 🔥 RESULT SECTION
            BlocBuilder<DistanceBloc, DistanceState>(
              builder: (context, state) {
                switch (state.distanceResponse.status) {

                  case Status.loading:
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                                height: 150, // 👈 height = size
                                width: 150,
                                child: CircularProgressIndicator()),
                            SizedBox(height: 10),
                            Text(StringConstants.calculatingDistance),
                          ],
                        ),
                      ),
                    );


                  case Status.completed:
                    return Column(
                      children: [

                        /// 🔥 NEW ANIMATION SECTION
                        RouteAnimationWidget(
                          from: fromController.text,
                          to: toController.text,
                        ),
                        CommonWidgets.verticalSpace(height:5),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                           // color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(16),
                            image:DecorationImage(
                               image: AssetImage(
                                 ImageConstants.googleMapBgImage,
                               ),
                              fit: BoxFit.cover,
                            ),

                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.route,
                                  size: 40, color: Colors.green),
                              const SizedBox(height: 10),
                               Text("Total Distance",
                                 style: AppTextStyle.titleStyle10bw,
                               ),
                              const SizedBox(height: 8),
                              Text(
                                state.distanceResponse.data ?? "",
                                style: AppTextStyle.titleStyleLB24bb,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );

                  case Status.error:
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error, color: Colors.red),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              state.distanceResponse.message ??
                                  "Something went wrong",
                            ),
                          ),
                        ],
                      ),
                    );

                  case Status.initial:
                  default:
                    return const Text(
                      "",
                      style: TextStyle(fontSize: 16),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


// import 'dart:math';
// import 'package:flutter/material.dart';

class RouteAnimationWidget extends StatefulWidget {
  final String from;
  final String to;

  const RouteAnimationWidget({
    super.key,
    required this.from,
    required this.to,
  });

  @override
  State<RouteAnimationWidget> createState() =>
      _RouteAnimationWidgetState();
}

class _RouteAnimationWidgetState
    extends State<RouteAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  /// 🔥 Structured Path (realistic turns)
  final List<Offset> pathPoints = [
    const Offset(20, 120),   // start
    const Offset(120, 120),  // straight →
    const Offset(120, 60),   // turn ↑
    const Offset(220, 60),   // straight →
    const Offset(220, 100),  // turn ↓
    const Offset(300, 100),  // final →
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _controller.forward(); // run once
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 📍 Get position on path
  Offset getPosition(double t) {
    double total = pathPoints.length - 1;
    double index = t * total;

    int i = index.floor();
    double localT = index - i;

    if (i >= pathPoints.length - 1) return pathPoints.last;

    return Offset.lerp(pathPoints[i], pathPoints[i + 1], localT)!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.backGroundColor,
        boxShadow: [
          BoxShadow(color: AppColors.backGroundColor, blurRadius: 8)
        ],
      ),
      child: SizedBox(
        height: 180,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final pos = getPosition(_controller.value);

            return Stack(
              children: [

                /// 🗺️ BACKGROUND MAP IMAGE
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      ImageConstants.googleMapBgImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// ROADS (GREY)
                CustomPaint(
                  size: const Size(double.infinity, 180),
                  painter: RoadPainter(pathPoints),
                ),

                /// 🚗 CAR
                Positioned(
                  left: pos.dx,
                  top: pos.dy,
                  child: const Icon(
                    Icons.directions_car,
                    color: Colors.blue,
                    size: 26,
                  ),
                ),

                /// 🟢 START POINT + NAME
                // Positioned(
                //   left: pathPoints.first.dx - 20,
                //   top: pathPoints.first.dy - 60,
                //   child: Column(
                //     children: [
                //       Image.asset(
                //         ImageConstants.toLocationIcon,
                //         width: 40,
                //       ),
                //
                //       Text(widget.from,
                //           style: const TextStyle(fontSize: 10)),
                //     ],
                //   ),
                // ),

                Positioned(
                  left: pathPoints.first.dx - 20,
                  top: pathPoints.first.dy - 40,
                  child: SizedBox(
                    width: 90, // 🔥 control width
                    child: Column(
                      children: [
                        Image.asset(
                          ImageConstants.toLocationIcon,
                          width: 40,
                        ),

                        const SizedBox(height: 4),

                        Tooltip( // 🔥 full text on long press
                          message: widget.from,
                          child: Text(
                            widget.from,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis, // 🔥 IMPORTANT
                            textAlign: TextAlign.center,
                            style: AppTextStyle.titleStyle10bw
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// 🔴 END POINT + NAME
                // Positioned(
                //   left: pathPoints.last.dx - 5,
                //   top: pathPoints.last.dy - 60,
                //   child: Column(
                //     children: [
                //       Image.asset(
                //         ImageConstants.fromLocaionIcon,
                //         width: 40,
                //       ),
                //
                //       Text(widget.to,
                //           style: const TextStyle(fontSize: 10)),
                //     ],
                //   ),
                // ),

                Positioned(
                  left: pathPoints.last.dx - 30,
                  top: pathPoints.last.dy - 30,

                  child: SizedBox(
                    width: 90,
                    child: Column(
                      children: [
                        Image.asset(
                          ImageConstants.fromLocaionIcon,
                          width: 40,
                        ),

                        const SizedBox(height: 20),

                        Tooltip(
                          message: widget.to,
                          child: Text(
                            widget.to,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                              style: AppTextStyle.titleStyle10bw,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


              ],
            );
          },
        ),
      ),
    );
  }
}


class RoadPainter extends CustomPainter {
  final List<Offset> path;

  RoadPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    // final grey = Paint()
    //   ..color = Colors.grey.shade300
    //   ..strokeWidth = 3
    //   ..style = PaintingStyle.stroke;

    final blue = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    /// OTHER FAKE ROADS
    // canvas.drawLine(
    //     const Offset(50, 20), const Offset(250, 20), grey);
    // canvas.drawLine(
    //     const Offset(80, 150), const Offset(280, 140), grey);

    /// MAIN ROUTE
    final pathDraw = Path()..moveTo(path[0].dx, path[0].dy);
    for (int i = 1; i < path.length; i++) {
      pathDraw.lineTo(path[i].dx, path[i].dy);
    }

    canvas.drawPath(pathDraw, blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


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
