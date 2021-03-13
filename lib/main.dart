import 'package:flutter/material.dart';
import 'package:life_plum/habit/habit.dart';
import 'package:life_plum/journals/journal.dart';
import 'notifications/notifications.dart';
import 'helperFiles/style.dart';
import 'weather/weather.dart';
import 'quote/quote.dart';
import 'rateDay/rateDay.dart';
import 'goal/goal.dart';
import 'navigator/navbar.dart';
import 'graph/graph.dart';
import 'package:flutter/services.dart';
import 'package:event_bus/event_bus.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setOrientation();

    return MaterialApp(
      routes: {
        '/journal': (context) => Journal(),
        '/habit': (context) => Habit(),
      },
      theme: MyThemeData,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: MyAppBar,
      drawer: NavBar(context, scaffoldKey),
      body: MyMainBody(),
    );
  }
}

// ignore: non_constant_identifier_names

class MyMainBody extends StatefulWidget {
  @override
  _MyMainBodyState createState() => _MyMainBodyState();
}

class _MyMainBodyState extends State<MyMainBody>
    with AutomaticKeepAliveClientMixin<MyMainBody> {
  @override
  void initState() {
    super.initState();
    try {
      setUpNotifications();
    } on Exception catch (error) {
      print(
          "Problem settings up notifications, ${error.toString()} - end of Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final EventBus eventBus = EventBus();
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: <Widget>[
                    WeatherSection(),
                    Quote(),
                    RateDay(eventBus),
                    GoalPlan(),
                  ],
                ),
              ),
              HappyGraph(eventBus),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

//Helper Functions
void setOrientation() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}
