import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:restaurants/models/CityData.dart';
import 'package:restaurants/models/RestaurantData.dart';
import 'package:restaurants/utils/Common.dart';
import 'package:restaurants/utils/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  Client client = Client();
  var user_key = '7743aea88c2d4f753465c610ef1cf5a8';
  static SharedPreferences _sharedPreferences;

  void init() async {
    if (_sharedPreferences == null)
      _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<RestaurantData> fetchRestaurantList() async {
    if (Common.connection != Strings.CON_NON && Common.connection.isNotEmpty) {
      print("entered");
      Map<String, String> _headerData = Map();
      _headerData['user-key'] = user_key;

      var url = Uri.parse('https://www.zomato.com/api/v2.1/search');
      final response = await client.get(url, headers: _headerData);
      print(response.body.toString());
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        print(response.body.toString());
        _sharedPreferences.setString(Strings.DATA, response.body.toString());
        return RestaurantData.fromJson(json.decode(response.body));
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    } else {
      String data = _sharedPreferences.get(Strings.DATA);
      if (data != null && data.isNotEmpty) {
        return RestaurantData.fromJson(json.decode(data));
      }
    }
  }

  Future<List<CityData>> fetchSearchRestaurant(String city) async {
    List<CityData> _cityList = List();

    print("entered");
    Map<String, String> _headerData = Map();
    _headerData['user-key'] = user_key;
    var url =
        Uri.parse('https://developers.zomato.com/api/v2.1/cities?q=$city');
    final response = await client.get(url, headers: _headerData);
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      print(response.body.toString());

      Map<String, dynamic> mainMap = json.decode(response.body);
      List<dynamic> mList = mainMap['location_suggestions'];
      for (int i = 0; i < mList.length; i++) {
        CityData cityData = CityData.fromJson(mList[i]);
        _cityList.add(cityData);
      }
      return _cityList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
