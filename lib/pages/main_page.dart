import 'package:find_nearest_gas_station/pages/map_page.dart';
import 'package:find_nearest_gas_station/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

const _mainColor = Color(0xff26264D);
const _secondaryColor = Color(0xffDBDBE5);

class MainPageState extends State<MainPage> {
  List<Place>? searchPlaces;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _appBar(),
        body: _mainBody(),
      ),
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
      bottom: const TabBar(
        indicatorColor: _secondaryColor,
        indicatorWeight: 5,
        tabs: [
          Tab(
              icon: Icon(
            Icons.search_rounded,
            color: _secondaryColor,
          )),
          Tab(icon: Icon(Icons.map_sharp, color: _secondaryColor)),
        ],
      ),
    );
  }

  Widget _mainBody() {
    return const TabBarView(
      children: [
        SearchLocation(),
        MapPage(),
      ],
    );
  }

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    const color = _secondaryColor;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: _secondaryColor,
        ),
      ),
      hoverColor: _secondaryColor,
      onTap: onClicked,
    );
  }
}
