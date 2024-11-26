import 'package:flutter/material.dart';
import 'package:northstar_app/components/warning_dialog.dart';
import 'package:northstar_app/screens/contacts/contacts_home_screen.dart';
import 'package:northstar_app/screens/earnings_screen.dart';
import 'package:northstar_app/screens/home_screen.dart';
import 'package:northstar_app/screens/mission/inspire_screen.dart';
import 'package:northstar_app/screens/mission/reboot_screen.dart';
import 'package:northstar_app/screens/mission/recharge_screen.dart';
import 'package:northstar_app/screens/my_team/unilevel_tree_list_screen.dart';
import 'package:northstar_app/screens/my_team/unilevel_tree_tree_screen.dart';
import 'package:northstar_app/screens/my_team/upline_enroller.dart';
import 'package:northstar_app/screens/notification_screen.dart';
import 'package:northstar_app/screens/side_menu/widgets/side_menu_item.dart';
import 'package:northstar_app/screens/team_chat/team_chat_home_screen.dart';
import 'package:northstar_app/screens/history_screen.dart';
import 'package:northstar_app/screens/reports_screen.dart';
import 'package:northstar_app/screens/resources_screen.dart';
import 'package:northstar_app/screens/share_screen.dart';
import 'package:northstar_app/screens/support_screen.dart';
import 'package:northstar_app/screens/training_videos/training_videos_screen.dart';
import 'package:northstar_app/utils/helper_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/SharedPrefUtils.dart';
import '../../utils/app_contstants.dart';
import '../sign_in_screen.dart';
import 'widgets/side_menu_header.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  String userFullName = "", username = "", useruuid = "";

  @override
  void initState() {
    super.initState();
    _init();
  }
  Future<void> _init() async {
      var uf = await SharedPrefUtils.readPrefStr("fullname");
      var un = await SharedPrefUtils.readPrefStr("username");
      var uu = await SharedPrefUtils.readPrefStr("uuid");
      setState(() {
        userFullName = uf;
        username = un;
        useruuid = uu;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(34, 52, 71, 1),
      child: Column(
        children: [
          SideMenuHeader(userFullName: userFullName, username: username, useruuid: useruuid),
          Expanded(child: _buildMenuList(context)),
        ],
      ),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    // Define a list of menu items and expansion items
    final List<Map<String, dynamic>> menuItems = [
      {'text': 'Home', 'icon': Icons.home, 'screen': const HomeScreen()},
      {'text': 'Share', 'icon': Icons.share, 'screen': const ShareScreen()},
      {
        'text': 'Contact Manager',
        'icon': Icons.person,
        'screen': const ContactsHomeScreen()
      },
      {
        'text': 'Team Chat',
        'icon': Icons.chat,
        'screen': const TeamChatHomeScreen()
      },
      {
        'text': 'My Team',
        'icon': Icons.people,
        'children': [
          {
            'text': 'Unilevel Tree List View',
            'screen': const UnilevelTreeListScreen()
          },
          {
            'text': 'Unilevel Tree Tree View',
            'screen': const UnilevelTreeTreeScreen()
          },
          {'text': 'Upline Enrollers', 'screen': const UplineEnroller()},
        ],
      },
      {
        'text': 'Reports',
        'icon': Icons.report,
        'screen': const ReportsScreen()
      },
      {
        'text': 'Earnings',
        'icon': Icons.account_balance,
        'screen': const EarningsScreen()
      },
      {
        'text': 'Mission',
        'icon': Icons.check_circle,
        'children': [
          {'text': 'Reboot', 'screen': const RebootScreen()},
          {'text': 'Recharge', 'screen': const RechargeScreen()},
          {'text': 'Inspire', 'screen': const InspireScreen()},
        ],
      },
      {
        'text': 'Training Videos',
        'icon': Icons.video_file,
        'screen': const TrainingVideosScreen()
      },
      {
        'text': 'Resources',
        'icon': Icons.account_balance,
        'screen': const ResourcesScreen()
      },
      {
        'text': 'History',
        'icon': Icons.history,
        'screen': const HistoryScreen()
      },
      {
        'text': 'Notification',
        'icon': Icons.notifications,
        'screen': NotificationScreen()
      },
      {
        'text': 'Shop',
        'icon': Icons.shop,
        'onTap': () =>
            launchMyUrl(Uri.parse(shop_url)),
      },
      {
        'text': 'Autoship',
        'icon': Icons.card_membership,
        'onTap': () => launchMyUrl(Uri.parse(autoship_url)),
      },
      {
        'text': 'Support',
        'icon': Icons.headset_mic,
        'screen': const SupportScreen()
      },
      {'text': 'Logout',
        'icon': Icons.logout,
        'onTap': () => {
          showDialog(
            context: context,
            builder: (context) => WarningDialog(
                warningText: "logout",
                onCancel: () => Navigator.pop(context),
                onConfirm: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('usrname');

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                          (Route<dynamic> route) => false
                  );
                },
            ),
          )
      }},
    ];

    // Build the menu list dynamically
    return ListView.builder(
      padding: EdgeInsets.only(top: 4),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        if (item.containsKey('children')) {
          // ExpansionTile item
          return _buildExpansionTile(
              context, item['text'], item['icon'], item['children']);
        } else {
          // Regular menu item
          return _buildMenuItem(
            context,
            itemText: item['text'],
            itemIcon: item['icon'],
            screen: item['screen'],
            onTap: item['onTap'],
          );
        }
      },
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required String itemText,
      required IconData itemIcon,
      Widget? screen,
      Function()? onTap}) {
    return SideMenuListItem(
      itemText: itemText,
      itemIcon: itemIcon,
      onTap: onTap ?? () => popNavigate(context, screen),
    );
  }

  Widget _buildExpansionTile(
    BuildContext context,
    String title,
    IconData icon,
    List<Map<String, dynamic>> children,
  ) {
    return ExpansionTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -2),
      iconColor: Colors.white.withOpacity(0.7),
      collapsedIconColor: Colors.white.withOpacity(0.7),
      leading: Icon(icon, color: Colors.white.withOpacity(0.7)),
      title: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(title,
            style:
                TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15)),
      ),
      children: children
          .map((child) => ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                title: Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    child['text'],
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 15),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => child['screen']));
                },
              ))
          .toList(),
    );
  }
}
