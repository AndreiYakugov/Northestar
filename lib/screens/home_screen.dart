import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:northstar_app/screens/contacts/contacts_home_screen.dart';
import 'package:northstar_app/screens/notification_screen.dart';
import 'package:northstar_app/screens/team_chat/team_chat_home_screen.dart';
import 'package:northstar_app/screens/history_screen.dart';
import 'package:northstar_app/screens/reports_screen.dart';
import 'package:northstar_app/screens/share_screen.dart';
import 'package:northstar_app/screens/side_menu/side_menu.dart';
import 'package:northstar_app/utils/SharedPrefUtils.dart';
import 'package:northstar_app/utils/app_colors.dart';
import 'package:northstar_app/utils/app_contstants.dart';
import 'package:northstar_app/utils/helper_methods.dart';

import '../ApiPackage/ApiClient.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<String> imgList = [];
  final List<String> texts = [
    'Share',
    'Reports',
    'Back Office',
    'Team Chat',
    'Contacts',
    'Notification',
    'Shop',
    'Autoship',
    'History',
  ];
  final List<IconData> icons = [
    Icons.share,
    Icons.report,
    Icons.local_post_office,
    Icons.chat,
    Icons.contact_emergency,
    Icons.notifications,
    Icons.shop,
    Icons.card_membership,
    Icons.history
  ];

  @override
  void initState() {
    super.initState();

    _handleBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NORTHSTAR'),
      ),
      drawer: const Drawer(
        child: SideMenu(),
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * .25,
              autoPlay: true,
              viewportFraction: 0.94,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imgList
                .map((item) => Container(
                      width: MediaQuery.of(context).size.width - 8,
                      margin: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                        child: Image.network(
                          item,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? AppColors.primaryColor
                      : Colors.white,
                ),
              );
            }).toList(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height * .4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 3; i++) buildRow(i),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Function to build a row of 3 containers
  Widget buildRow(int rowIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++) buildContainer(rowIndex, i),
      ],
    );
  }

  Widget buildContainer(int rowIndex, int columnIndex) {
    int index = rowIndex * 3 + columnIndex; // Calculate the index in the lists
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (index == 0) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ShareScreen()));
          } else if (index == 1) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ReportsScreen()));
          } else if (index == 2) {
            launchMyUrl(Uri.parse(backoffice_url));
          } else if (index == 3) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TeamChatHomeScreen()));
          } else if (index == 4) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ContactsHomeScreen()));
          } else if (index == 5) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NotificationScreen()));
          } else if (index == 6) {
            launchMyUrl(Uri.parse(shop_url));
          } else if (index == 7) {
            launchMyUrl(Uri.parse(autoship_url));
          } else if (index == 8) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HistoryScreen()));
          }
        },
        child: Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: rowIndex > 0 ? Colors.white70 : Colors.transparent,
                width: 0.8,
              ),
              left: BorderSide(
                color: columnIndex > 0 ? Colors.white70 : Colors.transparent,
                width: 0.8,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icons[index], size: 30.0, color: Colors.white),
              const SizedBox(height: 8.0),
              Text(
                texts[index],
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<dynamic> _handleBanner() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    showLoadingDialog(context);
    dynamic res = await ApiClient().banner(ustoken);
    Navigator.pop(context);

    if (res["success"]) {
      var banners = res["data"];
      for(var element in banners) {
        setState(() {
          imgList.add(element["image"]);
        });
      }
      return imgList;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
}
