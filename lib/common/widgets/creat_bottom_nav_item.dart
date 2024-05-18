import 'package:flutter/material.dart';
import 'package:yz_app_jam/ui/Sorgulama/sorgu_view.dart';
import 'package:yz_app_jam/ui/paylasim/help_view.dart';
import 'package:yz_app_jam/ui/post/post_view.dart';
import 'package:yz_app_jam/ui/profil/profil_view.dart';
import 'package:yz_app_jam/ui/yapazeka/yapay_zeka_view.dart';

class TabItemData {
  String title;
  Widget icon;
  TabItemData({
    required this.title,
    required this.icon,
  });
  static Map<TabItem, TabItemData> tabs = {
    TabItem.Plant: TabItemData(
      title: "Ne Bu",
      icon: Icon(Icons.help, color: Color(0xff20AE67)),
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
      icon: Icon(Icons.question_answer, color: Color(0xff20AE67)),
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

enum TabItem { Profil, Plant, Help, Post, YapayZeka }

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return SorguView();
    case 1:
      return HelpView();
    case 2:
      return PostView();
    case 3:
      return YapayZekaView();
    case 4:
      return ProfilView();

    default:
      return Container();
  }
}
