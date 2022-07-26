// Required for code readability when setting a location in the RouteInformation
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import '../models/app_route.dart';
import 'navigation_state.dart';

// adb shell am start -W -a android.intent.action.VIEW -d http://starproxima.nullexp.dev/home_page/task_details com.example.todo_manager
// adb shell am start -W -a android.intent.action.VIEW -c android.intent.category.DEFAULT -d https://starproxima.nullexp.dev/home_page/task_details/ com.example.todo_manager
// adb shell am start -W -a android.intent.action.VIEW -c android.intent.category.DEFAULT -d https://starproxima.nullexp.dev/home_page/task_details/16615357673033 com.example.todo_manager

class AppRouteInformationParser
    extends RouteInformationParser<NavigationStateDTO> {
  @override
  Future<NavigationStateDTO> parseRouteInformation(
    RouteInformation routeInformation,
  ) {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.length == 1 &&
        uri.pathSegments[0] == AppRoute.homePage.str) {
      return Future.value(
        NavigationStateDTO.homePage(),
      );
    } else if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[1] == AppRoute.taskDetails.str) {
        return Future.value(
          NavigationStateDTO.taskDetails(),
        );
      }
    } else if (uri.pathSegments.length == 3) {
      if (uri.pathSegments[1] == AppRoute.taskDetails.str) {
        return Future.value(
          NavigationStateDTO.taskDetails(uri.pathSegments[2]),
        );
      }
    }

    return Future.value(NavigationStateDTO.homePage());
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationStateDTO configuration) {
    String location = '';
    if (configuration.onHomePage) {
      location += '/' + AppRoute.homePage.str;
    }
    if (configuration.onTaskDetails) {
      location += '/' + AppRoute.taskDetails.str;
    }
    if (configuration.taskId != null) {
      location += '/' + configuration.taskId!;
    }

    return RouteInformation(location: location);
  }
}
