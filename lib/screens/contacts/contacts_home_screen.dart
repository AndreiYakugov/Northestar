import 'package:flutter/material.dart';
import 'package:northstar_app/screens/contacts/my_team.dart';
import 'package:northstar_app/screens/contacts/prospects.dart';
import 'package:northstar_app/utils/SharedPrefUtils.dart';
import 'package:northstar_app/utils/app_colors.dart';
import 'package:northstar_app/utils/app_contstants.dart';
import 'package:northstar_app/utils/helper_methods.dart';

import '../../ApiPackage/ApiClient.dart';
import '../../Models/contact.dart';

class ContactsHomeScreen extends StatefulWidget {
  const ContactsHomeScreen({super.key});

  @override
  State<ContactsHomeScreen> createState() => _ContactsHomeScreenState();
}

class _ContactsHomeScreenState extends State<ContactsHomeScreen> {
  TextEditingController searchFieldController = TextEditingController();

  List<Contact> contacts = [];
  List<Contact> contactsOnSearchResult = [];

  @override
  void initState() {
    super.initState();

    _handleContactsTeam();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Contacts Manager"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildSearchField(),
                const SizedBox(height: 8),
                _buildTabBar(),
                Expanded(child: _buildTabBarView())
              ],
            ),
          )),
    );
  }

  TabBarView _buildTabBarView() {
    return TabBarView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: searchFieldController.text.isNotEmpty &&
              contactsOnSearchResult.isEmpty
              ? Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text(
                    'No results',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 22,
                        color: Color(0xff848484)),
                  ),
                ),
              )
            ],
          )
          : MyTeam(contacts: searchFieldController.text.isNotEmpty ? contactsOnSearchResult : contacts),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Propects(),
        )
      ],
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      indicatorColor: AppColors.primaryColor,
      dividerColor: Colors.transparent,
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: Colors.white,
      tabs: const [
        Tab(text: "My Team"),
        Tab(text: "Prospects"),
      ],
    );
  }

  Widget _buildSearchField() {
    return SizedBox(
      height: 44,
      child: TextField(
        controller: searchFieldController,
        textInputAction: TextInputAction.done,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Search",
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 8,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
        ),
        onChanged: (value) {
          setState(() {
            contactsOnSearchResult = contacts
                .where((element) =>
                element.name
                    .toLowerCase()
                    .contains(value.toLowerCase()))
                .toList();
          });
        },
      ),
    );
  }
  Future<dynamic> _handleContactsTeam() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    showLoadingDialog(context);
    dynamic res = await ApiClient().contactsteam(ustoken);
    Navigator.pop(context);

    if (res["success"]) {
      var tmpdata = res["data"]["data"];
      for(var element in tmpdata) {
        Contact ct = Contact(name: "${element["first_name"]} ${element["last_name"]}",
            email: element["email"],
            status: contactStatus(element["status"]),
            phone: element["phone"],
            username: element["username"]);
        setState(() {
          contacts.add(ct);
        });
      }
      return contacts;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
}
