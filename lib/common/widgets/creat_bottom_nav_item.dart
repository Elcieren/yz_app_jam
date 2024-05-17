import 'package:flutter/material.dart';
import 'package:yz_app_jam/ui/profil/profil_view.dart';

class TabItemData {
  String title;
  Widget icon;
  TabItemData({
    required this.title,
    required this.icon,
  });
  static Map<TabItem, TabItemData> tabs = {
    TabItem.Plant: TabItemData(
      title: "çİçek",
      icon: Icon(Icons.map, color: Color(0xff20AE67)),
    ),
    TabItem.Help: TabItemData(
      title: "Gönderiler",
      icon: Icon(
        Icons.home,
        color: Color(0xff20AE67),
      ),
    ),
    TabItem.Post: TabItemData(
      title: "Paylaşım",
      icon: Icon(Icons.add_circle, color: Color(0xff20AE67)),
    ),
    TabItem.YapayZeka: TabItemData(
      title: "Yapay Zeka",
      icon: Icon(Icons.lightbulb_outline, color: Color(0xff20AE67)),
    ),
    TabItem.EarthquakeCall: TabItemData(
      title: "Mantar",
      icon: Icon(Icons.alarm, color: Color(0xff20AE67)),
    ),
    TabItem.Profil: TabItemData(
      title: "Profil",
      icon: Icon(Icons.people, color: Color(0xff20AE67)),
    ),
  };
}

BottomNavigationBarItem createNavItem(TabItem tabItem) {
  final currentTab = TabItemData.tabs[tabItem]!;
  return BottomNavigationBarItem(
    icon: currentTab.icon,
    label: currentTab.title,
  );
}

enum TabItem { Profil, Plant, Help, Post, EarthquakeCall, YapayZeka }

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return Container(
        child: Center(child: Text("Sayfa1")),
      );
    case 1:
      return Container(
        child: Center(child: Text("Sayfa2")),
      );
    case 2:
      return Container(
        child: Center(child: Text("Sayfa3")),
      );
    case 3:
      return Container(
        child: Center(child: Text("Sayfa4")),
      );
    case 4:
      return Container(
        child: Center(child: Text("Sayfa5")),
      );
    case 5:
      return ProfilView();
    default:
      return Container();
  }
}
