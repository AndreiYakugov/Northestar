import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:northstar_app/Models/reportfive.dart';
import 'package:northstar_app/Models/reporthundred.dart';
import 'package:northstar_app/Models/reportuser.dart';
import 'package:northstar_app/utils/app_colors.dart';
import 'package:northstar_app/utils/helper_methods.dart';

import '../ApiPackage/ApiClient.dart';
import '../utils/SharedPrefUtils.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {

  ReportUser reportUser = ReportUser(image: "", id: "", username: "", status: "", pv: "", credit: "", affiliate: "", preferred: "", retail: "", commission: "");
  List<ReportFive> reportFiveList = [];
  List<ReportHundred> reportHundredList = [];

  @override
  void initState() {
    super.initState();
    _init();
  }
  void _init() {
    _handleReportsProfile();
    _handleReportsHeader();
    _handleReportsFive();
    _handleReportsHundred();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: reportUser.image == null ?
                      CircleAvatar(
                        backgroundColor: AppColors.txtFldFillClr)
                          :
                      CircleAvatar(
                        backgroundImage: NetworkImage(reportUser.image!),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "ID:",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              Spacer(),
                              Text(
                                reportUser.id,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Username:",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              Spacer(),
                              Text(
                                reportUser.username,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Status:",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              Spacer(),
                              Text(
                                reportUser.status,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Personal Volume (PV):",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              Spacer(),
                              Text(
                                reportUser.pv,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Credit Wallet Balance:",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              Spacer(),
                              Text(
                                "\$${reportUser.credit}",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ReportContainer(
                            title: "Affiliates",
                            subtitle: reportUser.affiliate,
                          ),
                          SizedBox(height: 10),
                          ReportContainer(
                            title: "Preffered",
                            subtitle: reportUser.preferred,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ReportContainer(
                            title: "Retail",
                            subtitle: reportUser.retail,
                          ),
                          SizedBox(height: 10),
                          ReportContainer(
                            title: "Commissions",
                            subtitle: "\$${reportUser.commission}",
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Top 5 Enrollers",
                style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                itemCount: reportFiveList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: reportFiveList[index].image == null ?
                              CircleAvatar(
                                  backgroundColor: AppColors.txtFldFillClr)
                                  :
                              CircleAvatar(
                                backgroundImage: NetworkImage(reportFiveList[index].image!),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        reportFiveList[index].name,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Rank:",
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                      Spacer(),
                                      Text(
                                        reportFiveList[index].rank,
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Affiliates:",
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                      Spacer(),
                                      Text(
                                        reportFiveList[index].affiliate,
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "PV:",
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                      Spacer(),
                                      Text(
                                        reportFiveList[index].autoship,
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Preferred:",
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                      Spacer(),
                                      Text(
                                        reportFiveList[index].preferred,
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "GV:",
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                      Spacer(),
                                      Text(
                                        reportFiveList[index].gv,
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Retail:",
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                      Spacer(),
                                      Text(
                                        reportFiveList[index].retail,
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 12),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Text(
                "Top 100 Leaderboard",
                style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                itemCount: reportHundredList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: reportHundredList[index].image == null ?
                          CircleAvatar(
                              backgroundColor: AppColors.txtFldFillClr)
                              :
                          CircleAvatar(
                            backgroundImage: NetworkImage(reportHundredList[index].image!),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    reportHundredList[index].name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "PE:",
                                    style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                  Spacer(),
                                  Text(
                                    reportHundredList[index].pe,
                                    style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: reportHundredList[index].billingcountry == null ?
                                    CircleAvatar(
                                        backgroundColor: AppColors.txtFldFillClr)
                                        :
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(reportHundredList[index].billingcountry!),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    reportHundredList[index].countryname,
                                    style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
  Future<dynamic> _handleReportsProfile() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    showLoadingDialog(context);
    dynamic res = await ApiClient().reportsProfile(ustoken);

    if (res["success"]) {
      var tmpdata = res["data"];
      setState(() {
        reportUser.image = tmpdata["image"];
        reportUser.id = tmpdata["uuid"];
        reportUser.username = tmpdata["username"];
        reportUser.status = contactStatus(tmpdata["status"]);
        reportUser.pv = tmpdata["qualification"]["pv"];
        reportUser.credit = tmpdata["wallet"]["current_balance"];
      });
      return reportUser;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
  Future<dynamic> _handleReportsHeader() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    dynamic res = await ApiClient().reportsHeader(ustoken);

    if (res["success"]) {
      var tmpdata = res["data"];
      print("ME : $tmpdata");
      setState(() {
        reportUser.affiliate = tmpdata["users_count"]["affiliate_users_count"];
        reportUser.retail = tmpdata["users_count"]["ratail_users_count"];
        reportUser.preferred = tmpdata["users_count"]["total_customers"];
        reportUser.commission = tmpdata["commissions_earned"];
      });
      return reportUser;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
  Future<dynamic> _handleReportsFive() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    dynamic res = await ApiClient().reportsFive(ustoken);

    if (res["success"]) {
      var tmpdata = res["data"];
      for(var element in tmpdata) {
        ReportFive rf = ReportFive(image: element["image"], name: "${element["first_name"]} ${element["last_name"]}",
            affiliate: element["pea"], preferred: element["pep"], retail: element["per"],
            autoship: element["pv"], gv: element["gv"], rank: element["rank"]["name"]);
        setState(() {
          reportFiveList.add(rf);
        });
      }
      return reportFiveList;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
  Future<dynamic> _handleReportsHundred() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    dynamic res = await ApiClient().reportsHundred(ustoken);
    Navigator.pop(context);

    if (res["success"]) {
      var tmpdata = res["data"];
      for(var element in tmpdata) {
        ReportHundred rh = ReportHundred(pe: element["pe"],
            name: "${element["user"]["first_name"]} ${element["user"]["last_name"]}",
            image: element["user"]["image"], billingcountry: element["user"]["country"].toString().toLowerCase(),
            countryname: Country.tryParse(element["user"]["country"])!.name);
        setState(() {
          reportHundredList.add(rh);
        });
      }
      return reportHundredList;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
}

class ReportContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  const ReportContainer({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
