import 'package:bloc_project_basic/core/constants/string_constants.dart';
import 'package:bloc_project_basic/presentation/home_screen/vehical_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';
import '../../core/navigations/navigation_service.dart';
import '../../core/themes/app_text_style.dart';
import '../../core/widgets/common_search_bar.dart';
import '../../router/app_router.dart';
import '../vehical_detail_screen/vehicle_details_screen.dart';
import 'category_list_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {


    List<String> categories = [
      "Family Trip",
      "Darshan",
      "One Way Trip",
      "Airport Transfer",
      "Tourist Trip",
      "Business Trip",
      "Wedding Trip ",
      "Transport Service"
    ];

    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //
      //       UserAccountsDrawerHeader(
      //         decoration: const BoxDecoration(
      //           color: Colors.orangeAccent,
      //         ),
      //         accountName: const Text("User"),
      //         accountEmail: Text("No Email",),
      //         currentAccountPicture: const CircleAvatar(
      //           backgroundColor: Colors.white,
      //           child: Icon(Icons.person, size: 35),
      //         ),
      //       ),
      //
      //       ListTile(
      //         leading: const Icon(Icons.person),
      //         title: const Text("Exit"),
      //         onTap: () {
      //           NavigationService.pushNamed(AppRoutes.splash);
      //         },
      //       ),
      //
      //       const ListTile(
      //         leading: Icon(Icons.shopping_bag),
      //         title: Text("My Orders"),
      //       ),
      //
      //       const ListTile(
      //         leading: Icon(Icons.favorite),
      //         title: Text("Favorites"),
      //       ),
      //
      //       const ListTile(
      //         leading: Icon(Icons.local_offer),
      //         title: Text("Discounts"),
      //       ),
      //
      //       const ListTile(
      //         leading: Icon(Icons.subscriptions),
      //         title: Text("Subscription"),
      //       ),
      //
      //       const ListTile(
      //         leading: Icon(Icons.notifications),
      //         title: Text("Notifications"),
      //       ),
      //
      //       const ListTile(
      //         leading: Icon(Icons.location_on),
      //         title: Text("Saved Address"),
      //       ),
      //
      //       const ListTile(
      //         leading: Icon(Icons.info),
      //         title: Text("About Us"),
      //       ),
      //
      //       const ListTile(
      //         leading: Icon(Icons.support_agent),
      //         title: Text("Help & Support"),
      //       ),
      //
      //       const ListTile(
      //         leading: Icon(Icons.settings),
      //         title: Text("Settings"),
      //       ),
      //
      //       const ListTile(
      //         leading: Icon(Icons.logout),
      //         title: Text("Logout"),
      //       ),
      //     ],
      //   ),
      // ),
      // /// AppBar
      // appBar: AppBar(
      // //  backgroundColor: Colors.white,
      //   backgroundColor: AppColors.lightDarkBackgroundColor,
      //   elevation: 0,
      //
      //   /// Center Title
      //   centerTitle: true,
      //   title: Text(
      //     "Home",
      //     style: AppTextStyle.titleStyleLB16bb,
      //   ),
      //
      //
      //   leading: Builder(
      //     builder: (context) => IconButton(
      //       icon: const Icon(Icons.menu, color: Colors.yellow),
      //       onPressed: () {
      //         Scaffold.of(context).openDrawer();
      //       },
      //     ),
      //   ),
      //
      //   /// Right Icons
      //   actions: [
      //
      //     IconButton(
      //       icon: const Icon(Icons.search, color: Colors.yellow),
      //       onPressed: () {},
      //     ),
      //
      //     IconButton(
      //       icon: const Icon(Icons.qr_code_scanner, color: Colors.yellow),
      //       onPressed: () {},
      //     ),
      //
      //     SizedBox(width: 10.w)
      //   ],
      // ),

      /// Body
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 60.h),

              /// Greeting
              Text(
                "Welcome, Ajay 👋",
                style: AppTextStyle.titleStyleLB18bb,
              ),

              SizedBox(height: 5.h),

              /// Big Title
              Text(
                "Book your Next trip with Us",
                style: AppTextStyle.titleStyleLB24bb,
              ),

              SizedBox(height: 15.h),

              CommonSearchBar(
                hintText: "Search cars, locations...",
                onChanged: (value) {
                  print(value);
                },
              ),

              SizedBox(height: 20.h),

              SizedBox(
                height: 410.h,
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        children: [

                          Image.asset(
                            ImageConstants.saleImg,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),

                          Image.asset(
                            ImageConstants.saleImg,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),

                          Image.asset(
                            ImageConstants.saleImg,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 8.h),

                    /// Dots Indicator
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        activeDotColor: Colors.yellow,
                        dotColor: Colors.grey,
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),

              /// Category Title
              Text(
                StringConstants.categories,
                style: AppTextStyle.titleStyleLB18bb,
              ),

              SizedBox(height: 15.h),

              /// Reusable Category Widget
              CategoryListWidget(
                categories: categories,
                onTap: (value) {
                  print("Clicked: $value");
                },
              ),

              SizedBox(height: 25.h),

              /// Vehicle Title
              Text(
                StringConstants.availablevehicles,
                style: AppTextStyle.titleStyleLB18bb,
              ),

              SizedBox(height: 15.h),

              /// Vehicle List
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  print(ImageConstants.VehicalSwift);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VehicleDetailScreen(
                            vehicleData: {
                              "imageUrl": ImageConstants.VehicalSwift,
                              "vehicleName": "Swift Dzire",
                              "travelType": "Family",
                              "usageType": "Passenger",
                              "pricePerKm": 12,
                              "seats": 5,
                              "fuelType": "Petrol",
                              "ac": true,
                              "features": [
                                "Music System",
                                "Charging Port",
                                "Comfort Seats"
                              ],
                              "available": true,
                              "description": "Best for family trips and city rides",
                              "rating": 4.5,
                              "totalTrips": 120,
                            },
                          ),
                        ),
                      );
                    },
                    child: VehicleCard(
                      carName: "Toyota Innova",
                      imageUrl: ImageConstants.VehicalSwift,
                      price: "₹15/km",
                      seats: "7",
                      time: "25 mins",
                      onBook: () {
                        print("Book Now Clicked");
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
