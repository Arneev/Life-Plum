import 'package:flutter/material.dart';
import 'navHeading.dart';
import 'navTitles.dart';

class NavBar extends StatelessWidget {
  BuildContext routeContext;
  GlobalKey<ScaffoldState> scaffoldKey;

  NavBar(BuildContext context, GlobalKey _scaffoldKey) {
    routeContext = context;
    scaffoldKey = _scaffoldKey;
  }

  void goToHome() {
    Navigator.popUntil(routeContext, (route) {
      return route.settings.name == '/';
    });
  }

  void goToJournal() {
    if (ModalRoute.of(routeContext).settings.name != '/journal') {
      if (ModalRoute.of(routeContext).settings.name != '/') {
        Navigator.pop(routeContext);
      }
      Navigator.pushNamed(routeContext, "/journal");

      if (ModalRoute.of(routeContext).settings.name == '/') {
        if (scaffoldKey.currentState.isDrawerOpen) {
          scaffoldKey.currentState.openEndDrawer();
        }
      }
    }
  }

  void goToHabits() {
    if (ModalRoute.of(routeContext).settings.name != '/habit') {
      if (ModalRoute.of(routeContext).settings.name != '/') {
        Navigator.pop(routeContext);
      }
      Navigator.pushNamed(routeContext, "/habit");

      if (ModalRoute.of(routeContext).settings.name == '/') {
        if (scaffoldKey.currentState.isDrawerOpen) {
          scaffoldKey.currentState.openEndDrawer();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NavHeading(),
          NavTitles(goToHome, goToJournal, goToHabits),
        ],
      ),
    );
  }
}
