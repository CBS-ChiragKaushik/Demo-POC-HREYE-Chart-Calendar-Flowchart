import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:org_chart/org_chart.dart';
import 'package:high_chart/high_chart.dart';

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
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CalendarPackagesTab(),
          Example2(),
          GraphPackagesTab(graphType: 'pie'),
          StepperTab(),
          VehicleInductionScreen(),
          // CombinationChartTab(),
          ExampleChart()
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min, // Ensures the height fits the content
        children: [
          Divider(height: 1, color: Colors.grey), // Optional divider
          TabBar(
            controller: _tabController,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
            tabs: [
              Tab(text: "Calendar"),
              Tab(text: "Org Chart"),
              Tab(text: "Graphs"),
              Tab(text: "Stepper"),
              Tab(text: "Vehicles"),
              Tab(text: "HighCharts"), // New tab label
            ],
          ),
        ],
      ),
    );
  }
}

class ExampleChart extends StatefulWidget {
  const ExampleChart({super.key});

  @override
  ExampleChartState createState() => ExampleChartState();
}

class ExampleChartState extends State<ExampleChart> {



  final String _chartData = '''{
      title: {
          text: 'Combination chart'
      },    
      xAxis: {
          categories: ['Apples', 'Oranges', 'Pears', 'Bananas', 'Plums']
      },
      labels: {
          items: [{
              html: 'Total fruit consumption',
              style: {
                  left: '50px',
                  top: '18px',
                  color: ( // theme
                      Highcharts.defaultOptions.title.style &&
                      Highcharts.defaultOptions.title.style.color
                  ) || 'black'
              }
          }]
      },
      series: [{
          type: 'column',
          name: 'Jane',
          data: [3, 2, 1, 3, 3]
      }, {
          type: 'column',
          name: 'John',
          data: [2, 4, 5, 7, 6]
      }, {
          type: 'column',
          name: 'Joe',
          data: [4, 3, 3, 5, 0]
      }
        ]
    }''';


  final String _chartdataline = '''{
      title: {
          text: 'Combination chart'
      },    
      xAxis: {
          categories: ['Apples', 'Oranges', 'Pears', 'Bananas', 'Plums']
      },
      labels: {
          items: [{
              html: 'Total fruit consumption',
              style: {
                  left: '50px',
                  top: '18px',
                  color: ( // theme
                      Highcharts.defaultOptions.title.style &&
                      Highcharts.defaultOptions.title.style.color
                  ) || 'black'
              }
          }]
      },
      series: [
      {
          type: 'spline',
          name: 'Average',
          data: [3, 2.67, 3, 6.33, 3.33],
          marker: {
              lineWidth: 2,
              lineColor: Highcharts.getOptions().colors[3],
              fillColor: 'white'
          }
      }
        ]
    }''';

  final String _chartdatapie = '''{
      title: {
          text: 'Combination chart'
      },    
      xAxis: {
          categories: ['Apples', 'Oranges', 'Pears', 'Bananas', 'Plums']
      },
      labels: {
          items: [{
              html: 'Total fruit consumption',
              style: {
                  left: '50px',
                  top: '18px',
                  color: ( // theme
                      Highcharts.defaultOptions.title.style &&
                      Highcharts.defaultOptions.title.style.color
                  ) || 'black'
              }
          }]
      },
        series: [
      {
          type: 'pie',
          name: 'Total consumption',
          data: [
          {
              name: 'Jane',
              y: 13,
              color: Highcharts.getOptions().colors[0] // Jane's color
          }, 
          {
              name: 'John',
              y: 23,
              color: Highcharts.getOptions().colors[1] // John's color
          }, 
          {
              name: 'Joe',
              y: 19,
              color: Highcharts.getOptions().colors[2] // Joe's color
          }
          ],
          center: [150, 100],
          size: 250,
          showInLegend: false,
          dataLabels: {
              enabled: false
          }
        }
        ]
    }''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('High Charts'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HighCharts(
              loader: const SizedBox(
                width: 200,
                child: LinearProgressIndicator(),
              ),
              size: const Size(700, 700),
              data: _chartData,
              scripts: const [
                "https://code.highcharts.com/highcharts.js",
                'https://code.highcharts.com/modules/networkgraph.js',
                'https://code.highcharts.com/modules/exporting.js',
              ],
            ),
            // SizedBox(height: 10,),
            HighCharts(
              loader: const SizedBox(
                width: 200,
                child: LinearProgressIndicator(),
              ),
              size: const Size(700, 700),
              data: _chartdataline,
              scripts: const [
                "https://code.highcharts.com/highcharts.js",
                'https://code.highcharts.com/modules/networkgraph.js',
                'https://code.highcharts.com/modules/exporting.js',
              ],
            ),

            HighCharts(
              loader: const SizedBox(
                width: 200,
                child: LinearProgressIndicator(),
              ),
              size: const Size(700, 700),
              data: _chartdatapie,
              scripts: const [
                "https://code.highcharts.com/highcharts.js",
                'https://code.highcharts.com/modules/networkgraph.js',
                'https://code.highcharts.com/modules/exporting.js',
              ],
            ),

          ],
        ),
      ),
    );
  }
}

// HighCharts Combination Chart Tab
// class CombinationChartTab extends StatelessWidget {
//   final String _chartData = '''{
//     title: {
//         text: 'Combination chart'
//     },
//     xAxis: {
//         categories: ['Apples', 'Oranges', 'Pears', 'Bananas', 'Plums']
//     },
//     labels: {
//         items: [{
//             html: 'Total fruit consumption',
//             style: {
//                 left: '50px',
//                 top: '18px',
//                 color: (Highcharts.defaultOptions.title.style &&
//                         Highcharts.defaultOptions.title.style.color) || 'black'
//             }
//         }]
//     },
//     series: [
//     {
//         type: 'column',
//         name: 'Jane',
//         data: [3, 2, 1, 3, 3]
//     },
//     {
//         type: 'column',
//         name: 'John',
//         data: [2, 4, 5, 7, 6]
//     },
//     {
//         type: 'column',
//         name: 'Joe',
//         data: [4, 3, 3, 5, 0]
//     },
//     {
//         type: 'spline',
//         name: 'Average',
//         data: [3, 2.67, 3, 6.33, 3.33],
//         marker: {
//             lineWidth: 2,
//             lineColor: Highcharts.getOptions().colors[3],
//             fillColor: 'white'
//         }
//     }
//     , {
//         type: 'pie',
//         name: 'Total consumption',
//         data: [
//         {
//             name: 'Jane',
//             y: 13,
//             color: Highcharts.getOptions().colors[0]
//         },
//         {
//             name: 'John',
//             y: 23,
//             color: Highcharts.getOptions().colors[1]
//         },
//         {
//             name: 'Joe',
//             y: 19,
//             color: Highcharts.getOptions().colors[2]
//         }
//         ],
//         center: [100, 80],
//         size: 100,
//         showInLegend: false,
//         dataLabels: {
//             enabled: false
//         }
//     }
//     ]
//   }''';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: HighCharts(
//         loader: const Center(
//           child: CircularProgressIndicator(),
//         ),
//         size: const Size(double.infinity, 400),
//         data: _chartData,
//         scripts: const [
//            "https://code.highcharts.com/highcharts.js",
//           // 'https://code.highcharts.com/modules/networkgraph.js',
//           // 'https://code.highcharts.com/modules/exporting.js',
//         ],
//       ),
//     );
//   }
// }

class StepperTab extends StatefulWidget {
  @override
  _StepperTabState createState() => _StepperTabState();
}

class _StepperTabState extends State<StepperTab> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepTapped: (int step) {
          setState(() {
            _currentStep = step;
          });
        },
        onStepContinue: () {
          if (_currentStep < 4) {
            setState(() {
              _currentStep += 1;
            });
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        steps: [
          Step(
            title: Text(""),
            content: Text("This is the first step."),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: Text(""),
            content: Text("This is the second step."),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: Text(""),
            content: Text("This is the third step."),
            isActive: _currentStep >= 2,
          ),
          Step(
            title: Text(""),
            content: Text("This is the fourth step."),
            isActive: _currentStep >= 3,
          ),
          Step(
            title: Text(""),
            content: Text("This is the final step."),
            isActive: _currentStep >= 4,
          ),
        ],
      ),
    );
  }
}

class VehicleInductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundColor: Colors.orange.shade100,
          child: Icon(Icons.person, color: Colors.orange),
        ),
        title: Text(
          'Vehicle Induction',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.orange),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter Vehicle No.',
                      labelStyle: TextStyle(fontSize: 14, color: Colors.black),
                      border: OutlineInputBorder(),
                      hintText: 'Enter..',
                      suffixIcon: Icon(Icons.search, color: Colors.orange),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Search',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'No Results Search',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}

class BottomNavigationBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildNavItem(Icons.add_circle_outline, 'Add Vehicle'),
        _buildNavItem(Icons.person_outline, 'Owner'),
        _buildNavItem(Icons.person, 'Driver'),
        _buildNavItem(Icons.map_outlined, 'Planning'),
        _buildNavItem(Icons.verified_user_outlined, 'Compliance'),
      ],
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 24),
      label: label,
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
