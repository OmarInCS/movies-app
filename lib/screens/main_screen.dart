
import 'package:flutter/material.dart';
import 'package:movies_app/screens/tabs/browse/browse_tab.dart';
import 'package:movies_app/screens/tabs/home/home_tab.dart';
import 'package:movies_app/screens/tabs/search/search_tab.dart';
import 'package:movies_app/screens/tabs/watch_list/watch_list_tab.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;


  static const List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    WatchListTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: "Browse"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Watch List"
          ),

        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}




