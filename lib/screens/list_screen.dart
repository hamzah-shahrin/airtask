import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class ListScreen extends StatefulWidget {
  final int listId;

  ListScreen({Key key, this.listId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListScreen();
}

class _ListScreen extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.redAccent,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.redAccent),
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(OMIcons.arrowBack, color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Text('List ${widget.listId + 1}',
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.white)),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              print("hi");
                            },
                            child: Icon(OMIcons.edit, color: Colors.white),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              print("hi");
                            },
                            child: Icon(OMIcons.add,
                                color: Colors.white, size: 30),
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
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3))
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black, width: 1.2))),
                            child: Text('Items',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: Container(
                              child: ScrollConfiguration(
                                behavior: ScrollBehavior()
                                  ..buildViewportChrome(
                                      context, null, AxisDirection.down),
                                child: ListView.builder(
                                    padding: EdgeInsets.all(10.0),
                                    shrinkWrap: true,
                                    itemCount: 20,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        direction: DismissDirection.endToStart,
                                        background: Container(
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.only(right: 20.0),
                                          color: Colors.red,
                                          child: Icon(OMIcons.delete,
                                              color: Colors.white),
                                        ),
                                        key: ObjectKey(index),
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            margin:
                                                EdgeInsets.only(bottom: 0.0),
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(Icons.remove),
                                                  SizedBox(width: 10),
                                                  Text('Item ${index + 1}',
                                                      style: TextStyle(
                                                          color: Colors.black))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
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
        ));
  }
}
