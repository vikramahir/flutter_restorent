import 'dart:async';

import 'package:restaurants/models/CityData.dart';
import 'package:restaurants/models/RestaurantData.dart';
import 'package:restaurants/resources/ApiProvider.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<RestaurantData> fetchAllRestaurant() =>
      apiProvider.fetchRestaurantList();

  Future<List<CityData>> fetchAllSearchRestaurant(String city) =>
      apiProvider.fetchSearchRestaurant(city);
}
