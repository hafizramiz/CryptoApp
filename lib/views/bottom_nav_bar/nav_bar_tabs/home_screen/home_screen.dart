import 'package:cryptocurrency/view_models/drawer_view_model.dart';
import 'package:cryptocurrency/views/bottom_nav_bar/nav_bar_tabs/home_screen/my_trending_stream.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view_models/theme_setting_view_model.dart';
import 'my_choicechip_stream.dart';

class HomeScreen extends StatelessWidget {
  bool themeVar = false;

  @override
  Widget build(BuildContext context) {
    return Provider<DrawerViewModel>(
      create: (context) => DrawerViewModel(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text("Hello Exchange App"),
        ),
        drawer: Drawer(
          width: 250,
          child: ListView(padding: EdgeInsets.zero, children: [
            UserAccountsDrawerHeader(
              accountName: Text("Isim"),
              accountEmail: Text("Email"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text("Contact Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Consumer<ThemeSettings>(
              builder: (context, ThemeSettings themeSettings, child) {
                return SwitchListTile(
                    title: Text("Change Theme"),
                    value: themeSettings.themeStatus,
                    onChanged: (bool value) {
                      themeSettings.setThemeStatus(value);
                      print("Theme status: ${value}");
                    });
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log out"),
              onTap: () async {
                await Provider.of<DrawerViewModel>(context, listen: false)
                    .signOut();
              },
            ),
          ]),
        ),
        body: Column(
          children: [
            MyTrendingStream(),
            MyChoiceChipStream(),
          ],
        ),
      ),
    );
  }
}
