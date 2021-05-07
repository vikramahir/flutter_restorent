import 'package:restaurants/models/CityData.dart';
import 'package:restaurants/models/RestaurantData.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/repository.dart';

class RestaurantSearchBloc {
  final _repository = Repository();
  final _searchRestaurantFetcher = PublishSubject< List<CityData>>();

  Stream<List<CityData>> get searchRestaurant =>
      _searchRestaurantFetcher.stream;

  fetchAllRestaurant(String city) async {
    if (city != null && city.isNotEmpty) {
      List<CityData> cityList =
          await _repository.fetchAllSearchRestaurant(city);
      _searchRestaurantFetcher.sink.add(cityList);
    }
  }

  dispose() {
    _searchRestaurantFetcher.close();
  }
}

final blocSearch = RestaurantSearchBloc();
