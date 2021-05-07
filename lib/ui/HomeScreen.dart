import 'package:flutter/material.dart';
import 'package:restaurants/blocs/RestaurantBloc.dart';
import 'package:restaurants/blocs/RestaurantSearchBloc.dart';
import 'package:restaurants/models/CityData.dart';
import 'package:restaurants/models/RestaurantData.dart';
import 'package:restaurants/utils/CustomColors.dart';
import 'package:restaurants/utils/CustomWidget.dart';
import 'package:restaurants/utils/SizeConfig.dart';
import 'package:restaurants/utils/Strings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  bool _isSearching = false;
  String _city = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bloc.fetchAllRestaurant();
    if (_isSearching) blocSearch.fetchAllRestaurant(_city);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: _isSearching
            ? StreamBuilder(
                stream: blocSearch.searchRestaurant,
                builder: (context, AsyncSnapshot<List<CityData>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return _singleRowSearch(snapshot, index);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              )
            : StreamBuilder(
                stream: bloc.allRestaurant,
                builder: (context, AsyncSnapshot<RestaurantData> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.restaurants.length,
                      itemBuilder: (context, index) {
                        return _singleRow(snapshot, index);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
      ),
    );
  }

  Widget _singleRow(AsyncSnapshot<RestaurantData> snapshot, int index) {
    Restaurants restaurants = snapshot.data.restaurants[index];
    String img = restaurants.restaurant.featuredImage.toString().isEmpty
        ? restaurants.restaurant.thumb.toString()
        : restaurants.restaurant.featuredImage.toString();
    return Container(
      padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: SizeConfig.safeBlockHorizontal * 100.0,
            height: SizeConfig.safeBlockHorizontal * 50.0,
            decoration: BoxDecoration(
              color: Colors.black12,
              image: DecorationImage(
                image: NetworkImage(img),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal * 2.0,
          ),
          CustomWidget.customTextBold(
              text: restaurants.restaurant.name,
              size: 4.5,
              color: CustomColors.primaryColor),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal * 2.0,
          ),
          CustomWidget.customText(
              text: restaurants.restaurant.location.address,
              size: 4.0,
              color: CustomColors.secondary),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal * 3.0,
          ),
          Row(
            children: [
              CustomWidget.customText(
                  text: '${Strings.average_cost_for_two} ',
                  size: 4.0,
                  color: CustomColors.secondary),
              Expanded(
                child: CustomWidget.customText(
                    text:
                        'Rs. ${restaurants.restaurant.averageCostForTwo.toString()}',
                    size: 4.0,
                    color: CustomColors.secondary),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal * 3.0,
          ),
          Row(
            children: [
              CustomWidget.customText(
                  text:
                      '${restaurants.restaurant.allReviewsCount.toString()} Votes',
                  size: 4.0,
                  color: CustomColors.secondary),
              SizedBox(
                width: SizeConfig.safeBlockHorizontal * 5.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.safeBlockHorizontal * 2.0,
                    horizontal: SizeConfig.safeBlockHorizontal * 5.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: CustomWidget.customText(
                    text:
                        '${restaurants.restaurant.userRating.aggregateRating.toString()} /5.0',
                    size: 4.0,
                    color: CustomColors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _singleRowSearch(AsyncSnapshot<List<CityData>> snapshot, int index) {
    CityData cityData = snapshot.data[index];
    return Container(
      padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomWidget.customTextBold(
              text: cityData.name, size: 4.5, color: CustomColors.primaryColor),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal * 2.0,
          ),
          CustomWidget.customTextBold(
              text: cityData.name, size: 4.0, color: CustomColors.secondary),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal * 3.0,
          ),
        ],
      ),
    );
  }

  Widget appBarTitle = new Text(
    "Home Screen",
    style: new TextStyle(
      color: Colors.white,
    ),
    textAlign: TextAlign.start,
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  Widget buildAppBar(BuildContext context) {
    return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: actionIcon,
        onPressed: () {
          setState(() {
            if (this.actionIcon.icon == Icons.search) {
              this.actionIcon = new Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle = new TextField(
                controller: _searchQuery,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.white),
                    hintText: "Search City...",
                    hintStyle: new TextStyle(color: Colors.white)),
                onChanged: _onTextChange,
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
  }

  void _onTextChange(String str) {
    blocSearch.fetchAllRestaurant(str);
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Search Sample",
        style: new TextStyle(color: Colors.white),
      );
      _city = '';
      _isSearching = false;
      _searchQuery.clear();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchQuery.dispose();
    bloc.dispose();
    blocSearch.dispose();
  }
}
