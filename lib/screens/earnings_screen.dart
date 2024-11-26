import 'package:flutter/material.dart';
import 'package:northstar_app/Models/earningsgraph.dart';
import 'package:northstar_app/Models/earningsstats.dart';
import 'package:northstar_app/utils/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../ApiPackage/ApiClient.dart';
import '../Models/earnings.dart';
import '../Models/rank.dart';
import '../utils/SharedPrefUtils.dart';
import '../utils/helper_methods.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {

  Earningsstats earn_stats = Earningsstats(days_7: 0, days_30: 0, total_earnings: 0, wallet: 0);
  List<Earningsgraph> earn_graph = [];
  List<Earnings> earn_list = [];
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior =  TooltipBehavior(enable: true, header: '', format: 'point.x\namount : point.y');
    super.initState();

    _handleEarningsStats();
    _handleEarningsGraph();
    _handleEarningsList();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Earnings"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: EarningsContainer(
                        title: "Last 7 Days", subtitle: "\$ ${earn_stats.days_7}"),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: EarningsContainer(
                        title: "Last 30 Days", subtitle: "\$ ${earn_stats.days_30}"),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: EarningsContainer(
                        title: "Total Earnings", subtitle: "\$ ${earn_stats.total_earnings}"),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: EarningsContainer(
                        title: "Northe Wallet", subtitle: "\$ ${earn_stats.wallet}"),
                  )
                ],
              ),
              const SizedBox(height: 24),
              Text(
                "Earnings Growth",
                style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SfCartesianChart(
                    tooltipBehavior: _tooltipBehavior,
                    primaryXAxis: CategoryAxis(),
                    series: <CartesianSeries>[
                      LineSeries<Earningsgraph, String>(
                          enableTooltip: true,
                          dataSource: earn_graph,
                          xValueMapper: (Earningsgraph data, _) => "${DateTime.parse(data.date).month}/${DateTime.parse(data.date).day}",
                          yValueMapper: (Earningsgraph data, _) => double.parse(data.amount)
                      )
                    ]
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Earnings",
                style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: PaginatedDataTable(
                  rowsPerPage: 10,
                  source: EarnList(earn_list),
                  horizontalMargin: 0,
                  columnSpacing: 0,
                    columns: [
                      DataColumn(
                        label: Container(
                          width: width * .2,
                          child: Text('Period'),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          width: width * .2,
                          child: Text('Earned'),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          width: width * .2,
                          child: Text('Adjusted'),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          width: width * .15,
                          child: Text('Status'),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          width: width * .25,
                          child: Text('Rank'),
                        ),
                      ),
                    ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<dynamic> _handleEarningsStats() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    showLoadingDialog(context);
    dynamic res = await ApiClient().earningsstats(ustoken);

    if (res["success"]) {
      var tmpdata = res["data"];
        setState(() {
          earn_stats.days_7 = double.parse(tmpdata["7_days"].toString());
          earn_stats.days_30 = double.parse(tmpdata["30_days"].toString());
          earn_stats.total_earnings = double.parse(tmpdata["total_earnings"].toString());
          earn_stats.wallet = double.parse(tmpdata["wallet"].toString());
        });
        return earn_stats;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
  Future<dynamic> _handleEarningsGraph() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    dynamic res = await ApiClient().earningsgraph(ustoken);

    if (res["success"]) {
      var tmpdata = res["data"];
      for(var element in tmpdata) {
        Earningsgraph eg = Earningsgraph(date: element["date"], amount: element["amount"]);
        setState(() {
          earn_graph.add(eg);
        });
      }
      return earn_graph;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
  Future<dynamic> _handleEarningsList() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    dynamic res = await ApiClient().earningslist(ustoken);
    Navigator.pop(context);

    if (res["success"]) {
      var tmpdata = res["data"]["data"];
      for(var element in tmpdata) {
        Earnings en = Earnings(earnings_bonusId: element["id"], earnings_adjamount: element["amount"],
            earnings_minus_amount: element["minus_amount"], earnings_from: element["from"],
            earnings_to: element["to"], earnings_status: earningsStatus(element["status"]),
            earnings_rank: Rank(user_rankid: element["rank"]["id"], user_rankname: element["rank"]["name"]));
        setState(() {
          earn_list.add(en);
        });
      }
      return earn_list;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
}

class EarnList extends DataTableSource {
  EarnList(this._data);
  final List<Earnings> _data;

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text('${getFormatedDate(_data[index].earnings_from)} -\n${getFormatedDate(_data[index].earnings_to)}')),
      DataCell(Text('\$${_data[index].earnings_minus_amount}')),
      DataCell(Text('\$${_data[index].earnings_adjamount}')),
      DataCell(Text(_data[index].earnings_status)),
      DataCell(Text(_data[index].earnings_rank.user_rankname)),
    ]);
  }
}

class EarningsContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  const EarningsContainer({
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
