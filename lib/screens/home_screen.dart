import 'package:airtask/screens/list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  final tempItems = <String>["One", "Two", "Three", "Four", "Five", "Six"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.indigo[900],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.indigo[900]),
                child: Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: (){print("hi");},
                        child: Icon(Icons.bubble_chart, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Text('Airtask', style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500, fontSize: 20,
                          color: Colors.white)),
                      Spacer(),
                      InkWell(
                        onTap: (){print("hi");},
                        child: Icon(Icons.add, color: Colors.white, size: 30),
                      )
                    ],
                  ),
                ),
              ),
              flex: 2),
            Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                        boxShadow: [BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3)
                        )]),
                    child: Padding(
                        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 4),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(
                                  color: Colors.black, width: 1.2
                                ))
                              ),
                              child: Text('Task Lists', style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400
                              )),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: Container(
                                child: ScrollConfiguration(
                                  behavior: ScrollBehavior()..buildViewportChrome(
                                      context, null, AxisDirection.down),
                                  child: ListView.builder(
                                      padding: EdgeInsets.all(10.0),
                                      shrinkWrap: true,
                                      itemCount: tempItems.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () => Navigator.push(context,
                                              FadeRoute(page: ListScreen(listId: index))),
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 10.0),
                                            decoration: BoxDecoration(
                                              color: Colors.accents[index],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10)
                                              ),
                                              boxShadow: [BoxShadow(
                                                color: Colors.accents[index].withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3)
                                              )]
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(30),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(tempItems[index], style: TextStyle(color: Colors.white)),
                                                  Spacer(),
                                                  Text('3/5', style: TextStyle(color: Colors.white))
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                flex: 10),
          ],
        ),
      )
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}