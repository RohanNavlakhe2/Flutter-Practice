import 'package:chart_demo/my_flutter_app_icons.dart';
import 'package:chart_demo/my_icons_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyChart extends StatefulWidget {
  @override
  _MyChartState createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;
  List<BarChartGroupData> showingBarGroups;
  Size _size;
  IconData iconData = IconData(0xe360, fontFamily: 'MaterialIcons');
  Icon icon = Icon(Icons.add);

  AssetImage profileImg = AssetImage("assets/profile.png");

  @override
  void initState() {
    super.initState();

    ImageIcon imgIcon = ImageIcon(profileImg);

    final barGroup1 = makeGroupData(0, 5, 10,8,6,3);
    final barGroup2 = makeGroupData(1, 15, 5,20,8,6);
    final barGroup3 = makeGroupData(2, 18, 5,20,14,2);
    final barGroup4 = makeGroupData(3, 20, 16,10,15,20);
    final barGroup5 = makeGroupData(4, 17, 6,8,18,14);
    final barGroup6 = makeGroupData(5, 5, 10,8,6,3);
    final barGroup7 = makeGroupData(6, 15, 5,19,8,6);
    final barGroup8 = makeGroupData(7,18, 5,20,14,2);
    final barGroup9 = makeGroupData(8,  20, 16,10,15,20);
    final barGroup10 = makeGroupData(9, 5, 10,8,6,3);
    final barGroup11 = makeGroupData(10, 18, 5,20,14,2);
    final barGroup12 = makeGroupData(11, 5, 10,8,6,3);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
      barGroup8,
      barGroup9,
      barGroup10,
      barGroup11,
      barGroup12,
    ];

    showingBarGroups = items;
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: _size.width,
        height: 500,
        color: Colors.red,
        child: Card(
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: BarChart(BarChartData(
                maxY: 20,
                titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => const TextStyle(color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                      margin: 20,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            return 'Jan';
                          case 1:
                            return 'Feb';
                          case 2:
                            return 'March';
                          case 3:
                            return 'April';
                          case 4:
                            return 'May';
                          case 5:
                            return 'Jun';
                          case 6:
                            return 'July';
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
                barGroups: showingBarGroups,
                barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.black,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem("Group - $groupIndex \n", TextStyle(color: Colors.white),
                        children: [
                      TextSpan(
                          children: [
                             TextSpan(
                                text: "${String.fromCharCode(iconData.codePoint)}",
                                style: TextStyle(fontFamily: 'MaterialIcons',color: Colors.red)
                            ),
                            TextSpan(
                                text: "25 total requests",
                                style: TextStyle(color: Colors.white)
                            ),
                          ]
                      )
                    ]);
                  },
                )))),
          ),
        ),
      ),
    );

    /*AspectRatio(
      aspectRatio: 4,
      child:Container(
        color: Colors.red,
        child: Card*/
  }

  /* leftTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (value) => const TextStyle(
                      color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                  margin: 32,
                  reservedSize: 14,
                  getTitles: (value) {
                    if (value == 0) {
                      return '0K';
                    } else if (value == 5) {
                      return '5K';
                    } else if (value == 10) {
                      return '10K';
                    }else if(value == 15){
                      return '15K';
                    } else {
                      return '';
                    }
                  },
                ),*/

  BarChartGroupData makeGroupData(int x, double y1, double y2,double y3,double y4,double y5) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y3,
        colors: [rightBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y4,
        colors: [rightBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y5,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }


}
