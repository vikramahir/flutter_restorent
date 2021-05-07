import 'package:restaurants/models/RestaurantData.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/repository.dart';

class RestaurantBloc {
  final _repository = Repository();
  final _restaurantFetcher = PublishSubject<RestaurantData>();

  Stream<RestaurantData> get allRestaurant => _restaurantFetcher.stream;

  fetchAllRestaurant() async {
    RestaurantData restaurantData = await _repository.fetchAllRestaurant();
    _restaurantFetcher.sink.add(restaurantData);
  }

  dispose() {
    _restaurantFetcher.close();
  }
}

final bloc = RestaurantBloc();
