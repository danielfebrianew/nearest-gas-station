import 'package:find_nearest_gas_station/pages/map_page.dart';
import 'package:find_nearest_gas_station/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

const _mainColor = Color(0xff26403B);
const _secondaryColor = Color(0xffB3D1CB);

class MainPageState extends State<MainPage> {
  List<Place>? searchPlaces;
  int _currentIndex = 0;
  List<Widget> pages = const [SearchLocation(), MapPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _mainBody(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: _mainColor,
      title: const Text('Find Nearest Gas Station'),
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
      centerTitle: true,
    );
  }

  Widget _mainBody() {
    return SafeArea(
      child: pages[_currentIndex],
    );
  }

  Widget _bottomNavigationBar() {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: _secondaryColor,
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(
            color: _secondaryColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      child: NavigationBar(
        height: 90,
        backgroundColor: _mainColor,
        selectedIndex: _currentIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(
              Icons.search,
              color: _mainColor,
            ),
            icon: Icon(
              Icons.search_outlined,
              color: _secondaryColor,
            ),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.location_on_outlined,
              color: _mainColor,
            ),
            icon: Icon(
              Icons.location_on,
              color: _secondaryColor,
            ),
            label: 'Maps',
          ),
        ],
      ),
    );
  }
}
