import 'package:chart_demo/responsive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'bar_data.dart';

class DashboardDemo extends StatefulWidget {
  @override
  _DashboardDemoState createState() => _DashboardDemoState();
}

class _DashboardDemoState extends State<DashboardDemo> {

  List<BarChartGroupData> celebrityRevenueStatsChartData;
  Size _size;

  @override
  void initState() {
    celebrityRevenueChartDummyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return AspectRatio(aspectRatio: 4,
    child: Card(
        margin: EdgeInsets.all(15),
        child: celebrityRevenueChart()),);
  }

  Widget celebrityRevenueChart() => Padding(
    padding: EdgeInsets.all(15),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 1,
      itemBuilder: (context, index) {
        return Container(
          //constraints: BoxConstraints(minWidth: _size.width,maxWidth: _size.width*2),
          width: Responsive.isDesktop(context) ? _size.width : _size.width*2,
          color: Colors.yellow,
          padding: EdgeInsets.only(left: 15,right: 15),
          child: BarChart(
              BarChartData(
                 /* groupsSpace: Responsive.isDesktop(context) ? 80 : Responsive.isTablet(context) ? 20 : 20,
                  alignment: BarChartAlignment.center,*/
                  maxY: 20,
                  titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (value) => const TextStyle(color: Colors.black,fontSize: 14),
                        margin: 20,
                        getTitles: (double value) {
                          switch (value.toInt()) {
                            case 0:
                              return 'Jan';
                            case 1:
                              return 'Feb';
                            case 2:
                              return 'Mar';
                            case 3:
                              return 'Apr';
                            case 4:
                              return 'May';
                            case 5:
                              return 'Jun';
                            case 6:
                              return 'Jul';
                            case 7:
                              return 'Aug';
                            case 8:
                              return 'Sep';
                            case 9:
                              return 'Oct';
                            case 10:
                              return 'Nov';
                            case 11:
                              return 'Dec';
                            default:
                              return '';
                          }
                        },
                      ),
                      leftTitles: SideTitles(showTitles: false)),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: celebrityRevenueStatsChartData
              )
          ),
        );
      },

    ),
  );

  void celebrityRevenueChartDummyData(){
    //Dummy data for Service Chart
    final barData1 = BarData(barHeightValue: 8, barColor: Colors.blue);
    final barData2 = BarData(barHeightValue: 15, barColor: Colors.pink);
    final barData3 = BarData(barHeightValue: 5, barColor: Colors.green);
    final barData4 = BarData(barHeightValue: 11, barColor: Colors.purple);

    final serviceStatsBarGroup1 = makeBarGroup(0,[barData1,barData2,barData3, barData4]);
    final serviceStatsBarGroup2 = makeBarGroup(1,[barData1,barData2,barData3, barData4]);
    final serviceStatsBarGroup3 = makeBarGroup(2,[barData1,barData2,barData3, barData4]);
    final serviceStatsBarGroup4 =  makeBarGroup(3,[barData1,barData2,barData3, barData4]);
    final serviceStatsBarGroup5 =  makeBarGroup(4,[barData1,barData2,barData3, barData4]);
    final serviceStatsBarGroup6 =  makeBarGroup(5,[barData1,barData2,barData3, barData4]);
    final serviceStatsBarGroup7 =  makeBarGroup(6,[barData1,barData2,barData3, barData4]);
    final serviceStatsBarGroup8 =  makeBarGroup(7,[barData1,barData2,barData3, barData4]);
    final serviceStatsBarGroup9 =  makeBarGroup(8,[barData1,barData2,barData3, barData4]);
    final serviceStatsBarGroup10 = makeBarGroup(9,[barData1,barData2,barData3, barData4]);
    final serviceStatsBarGroup11 = makeBarGroup(10,[barData1,barData2,barData3, barData4]);
    final serviceStatsBarGroup12 = makeBarGroup(11,[barData1,barData2,barData3, barData4]);

    celebrityRevenueStatsChartData = [
      serviceStatsBarGroup1,
      serviceStatsBarGroup2,
      serviceStatsBarGroup3,
      serviceStatsBarGroup4,
      serviceStatsBarGroup5,
      serviceStatsBarGroup6,
      serviceStatsBarGroup7,
      serviceStatsBarGroup8,
      serviceStatsBarGroup9,
      serviceStatsBarGroup10,
      serviceStatsBarGroup11,
      serviceStatsBarGroup12,
    ];

    //celebrity revenue

  }

  BarChartGroupData makeBarGroup(int groupPosition,List<BarData> numberOfBarsInGroup) {
    List<BarChartRodData> barChartRods = [];
    numberOfBarsInGroup.forEach((bar) {
      barChartRods.add(
          BarChartRodData(
            y: bar.barHeightValue,
            colors: [bar.barColor],
            width: 4,
          )
      );
    });
    return BarChartGroupData(barsSpace: 4, x: groupPosition, barRods: barChartRods);


  }
}
