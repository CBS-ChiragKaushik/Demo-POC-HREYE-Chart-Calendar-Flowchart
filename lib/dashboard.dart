import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:org_chart/org_chart.dart';


void main() {
  runApp(MyDashboardApp());
}

class MyDashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Calendar Packages"),
            Tab(text: "Organization Chart"),
            Tab(text: "Graph Packages"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CalendarPackagesTab(),
          Example2(),  // Replace with the updated organization chart example
          GraphPackagesTab(graphType: 'pie'),
        ],
      ),
    );
  }
}

class CalendarPackagesTab extends StatefulWidget {
  @override
  _CalendarPackagesTabState createState() => _CalendarPackagesTabState();
}

class _CalendarPackagesTabState extends State<CalendarPackagesTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Easy Date Timeline", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        EasyDateTimeLine(
          initialDate: selectedDate,
          onDateChange: (newSelectedDate) {
            if (newSelectedDate != selectedDate) {
              Timer(Duration.zero, () {
                setState(() {
                  selectedDate = newSelectedDate;
                });
              });
            }
          },
        ),

        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff3371FF),
                    Color(0xff8426D6),
                  ],
                ),
              ),
            ),
          ),
        ),

        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
          },
          dayProps: const EasyDayProps(
            height: 56.0,
            // You must specify the width in this case.
            width: 124.0,
          ),
          headerProps: const EasyHeaderProps(
            dateFormatter: DateFormatter.fullDateMonthAsStrDY(),
          ),
          itemBuilder: (context, date, isSelected, onTap) {
            return InkWell(
              // You can use `InkResponse` to make your widget clickable.
              // The `onTap` callback responsible for triggering the `onDateChange`
              // callback.
              onTap: onTap,
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                //the same width that provided previously.
                width: 124.0,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xffFF6D60) : null,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      EasyDateFormatter.shortMonthName(date, "en_US"),
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.white : const Color(0xff6D5D6E),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      date.day.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : const Color(0xff393646),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      EasyDateFormatter.shortDayName(date, "en_US"),
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.white : const Color(0xff6D5D6E),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )


      ],
    );
  }
}

class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {

  final OrgChartController<Map> orgChartController = OrgChartController<Map>(

    boxSize: const Size(150, 80),
    items: [
      {
        "id": '0',
        "text": 'Main Block',
      },
      {
        "id": '1',
        "text": 'Block 2',
        "to": '0',
      },
      {
        "id": '2',
        "text": 'Block 3',
        "to": '0',
      },
      {
        "id": '3',
        "text": 'Block 4',
        "to": '1',
      },
    ],
    idProvider: (data) => data["id"],
    toProvider: (data) => data["to"],
    toSetter: (data, newID) => data["to"] = newID,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade100,
                Colors.blue.shade200,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: OrgChart<Map>(
                cornerRadius: 10,
                controller: orgChartController,
                isDraggable: true,
                linePaint: Paint()
                  ..color = Colors.black
                  ..strokeWidth = 5
                  ..style = PaintingStyle.stroke,
                onTap: (item) {
                  orgChartController.addItem({
                    "id": orgChartController.uniqueNodeId,
                    "text": 'New Block',
                    "to": item["id"],
                  });
                  setState(() {});
                },
                builder: (details) {
                  return GestureDetector(
                    child: Card(
                      elevation: 5,
                      color: details.isBeingDragged
                          ? Colors.green.shade100
                          : details.isOverlapped
                          ? Colors.red.shade200
                          : Colors.teal.shade50,
                      child: Center(
                          child: Text(
                            details.item["text"],
                            style: TextStyle(
                                color: Colors.purple.shade900, fontSize: 20),
                          )),
                    ),
                  );
                },
                optionsBuilder: (item) {
                  return [
                    const PopupMenuItem(value: 'Remove', child: Text('Remove')),
                  ];
                },
                onOptionSelect: (item, value) {
                  if (value == 'Remove') {
                    orgChartController.removeItem(
                        item["id"], ActionOnNodeRemoval.unlink);
                  }
                },
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                label: const Text('Reset & Change Orientation'),
                onPressed: () {
                  orgChartController.switchOrientation();
                }),
          ),
        ),
      ],
    );
  }
}

class GraphPackagesTab extends StatelessWidget {
  final String graphType;

  GraphPackagesTab({required this.graphType});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: Echarts(
              option: '''
                {
                  tooltip: {
                    trigger: '${graphType == 'pie' ? 'item' : 'axis'}',
                    ${graphType == 'pie' ? '' : "axisPointer: { type: 'shadow' }"}
                  },
                  xAxis: ${graphType == 'pie' ? 'null' : '''{
                    type: 'category',
                    data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                  }'''},
                  yAxis: ${graphType == 'pie' ? 'null' : '''{
                    type: 'value'
                  }'''},
                  series: [
                    {
                      data: ${graphType == 'pie'
                  ? '[{value: 150, name: "Mon"}, {value: 230, name: "Tue"}, {value: 224, name: "Wed"}, {value: 218, name: "Thu"}, {value: 135, name: "Fri"}, {value: 147, name: "Sat"}, {value: 260, name: "Sun"}]'
                  : '[150, 230, 224, 218, 135, 147, 260]'
              },
                      type: '$graphType',
                      ${graphType == 'pie' ? 'radius: "50%",' : 'color: "#3398DB"'}
                    }
                  ]
                }
              ''',
              onMessage: (String message) {
                print("Tapped on $graphType data: $message");
              },
            ),
          ),
          SizedBox(height: 20),  // Space between the two charts

          // Gauge Chart
          Expanded(
            child: GaugeChartWidget(),  // Separate widget for the gauge chart
          ),
        ],
      ),
    );
  }
}


class GaugeChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        child: Echarts(
          option: '''
            {
              tooltip: {
                formatter: '{a} <br/>{b} : {c}%'
              },
              series: [
                {
                  name: 'Pressure',
                  type: 'gauge',
                  detail: {
                    formatter: '{value}'
                  },
                  data: [
                    {
                      value: 72.67,
                      name: 'SCORE'
                    }
                  ]
                }
              ]
            }
          ''',
          onMessage: (String message) {
            print("Tapped on Gauge data: $message");
          },
        ),
      ),
    );
  }
}
