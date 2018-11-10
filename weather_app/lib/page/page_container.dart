import 'package:flutter/material.dart';

/// TODO: make comment suck less.
/// This widget houses all page widgets
/// It provides the menu, ...
///
class PageContainer extends StatelessWidget {
  final List<Widget> menuItems = [];

  void buildMenuItems() {
    menuItems.add(
      DrawerHeader(
        child: Text('Drawer Header'),
        decoration: BoxDecoration(color: Colors.blue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    buildMenuItems();

    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: menuItems,
        ),
      ),
      body: Container(),
    );
  }
}
