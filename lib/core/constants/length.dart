
import 'package:flutter/cupertino.dart';
import '../navigations/navigation_service.dart';

class AppLength{
  static double screenFullHeight(){
    return MediaQuery.of(NavigationService.navigatorKey.currentContext!).size.height;
  }
  static double screenHeightPart(double part){
    return MediaQuery.of(NavigationService.navigatorKey.currentContext!).size.height/part;
  }
  static double screenFullWidth(){
    return MediaQuery.of(NavigationService.navigatorKey.currentContext!).size.width;
  }
  static double screenWidthPart(double part){
    return MediaQuery.of(NavigationService.navigatorKey.currentContext!).size.width/part;
  }
}