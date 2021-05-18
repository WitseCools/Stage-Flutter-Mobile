import 'package:flutter/material.dart';
import 'package:frontend/Services/Services.dart';
import 'package:frontend/providers/analytics.dart';
import 'package:frontend/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Graph extends StatefulWidget {
  Graph({Key key}) : super(key: key);

  @override
  _GraphState createState() => _GraphState();
}

List<AllProjectTime> data = [];

class _GraphState extends State<Graph> {
  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.getStatic().then((value) {
        setState(() {
          data = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Services services = Provider.of<Services>(context);
    return FutureBuilder(
      future: services.getStatic(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Loading();
        } else
          return Container(
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  enableSideBySideSeriesPlacement: false,
                  series: <ChartSeries>[
                ColumnSeries<AllProjectTime, String>(
                  dataSource: data,
                  xValueMapper: (AllProjectTime proj, _) => proj.name,
                  yValueMapper: (AllProjectTime proj, _) => proj.totaal,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                  ),
                ),
              ]));
      },
    );
  }
}
