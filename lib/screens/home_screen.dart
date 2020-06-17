import 'package:airtask/controllers/storage_controller.dart';
import 'package:airtask/models/task_group.dart';
import 'package:airtask/screens/list_screen.dart';
import 'package:airtask/services/service_locator.dart';
import 'package:airtask/widgets/group_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final storageController = serviceLocator<StorageController>();

  void showModal(Widget contents) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: contents,
            ),
          );
        }
    );
  }

  @override
  void initState() {
    storageController.initController();
    super.initState();
  }

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
                            onTap: () {
                              print("hi");
                            },
                            child:
                                Icon(Icons.bubble_chart, color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Text('Airtask',
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.white)),
                          Spacer(),
                          ClipOval(
                            child: Material(
                              color: Colors.indigo[900],
                              child: InkWell(
                                onTap: () => showModal(GroupModal(
                                  storageController: storageController,
                                )),
                                splashColor: Colors.indigoAccent,
                                child: SizedBox(width: 30, height: 30,
                                    child: Icon(Icons.add, color: Colors.white, size: 30,)),
                              ),
                            ),
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
                              color: Colors.black.withOpacity(0.2),
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
                            child: Text('Task Lists',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: ChangeNotifierProvider(
                              create: (context) => storageController,
                              child: Consumer<StorageController>(
                                builder: (context, model, child) =>
                                    FutureBuilder<List<TaskGroup>>(
                                  future: model.taskGroups,
                                  builder: (context, snapshot) {
                                    List<TaskGroup> groups =
                                        snapshot.data ?? [];
                                    if (groups.length > 0)
                                      return Container(
                                        child: ScrollConfiguration(
                                          behavior: ScrollBehavior()
                                            ..buildViewportChrome(context, null,
                                                AxisDirection.down),
                                          child: ListView.builder(
                                              padding: EdgeInsets.all(10.0),
                                              shrinkWrap: true,
                                              itemCount: groups.length,
                                              itemBuilder: (context, index) {
                                                return Dismissible(
                                                  key: UniqueKey(),
                                                  confirmDismiss: (DismissDirection direction) async {
                                                    return await showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text('Confirm'),
                                                          content: Text('Are you sure you want to delete this list?'),
                                                          actions: <Widget>[
                                                            FlatButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop(true);
                                                                setState(() {storageController.deleteGroup(id: groups[index].id);});
                                                              },
                                                              child: Text('DELETE'),
                                                            ),
                                                            FlatButton(
                                                              onPressed: () => Navigator.of(context).pop(false),
                                                              child: Text('CANCEL'),
                                                            )
                                                          ],
                                                        );
                                                      }
                                                    );
                                                  },
                                                  direction: DismissDirection.endToStart,
                                                  background: Container(
                                                    alignment: Alignment.centerRight,
                                                    padding: EdgeInsets.only(right: 20.0),
                                                    child: Icon(OMIcons.delete,
                                                        color: Colors.red),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      await Navigator.push(
                                                        context,
                                                        FadeRoute(
                                                            page: ListScreen(
                                                                taskGroup: groups[
                                                                    index]))).then((_){setState((){});});
                                                      },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 10.0),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              groups[index].color,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: groups[
                                                                        index]
                                                                    .color
                                                                    .withOpacity(
                                                                        0.5),
                                                                spreadRadius: 1,
                                                                blurRadius: 7,
                                                                offset:
                                                                    Offset(0, 3))
                                                          ]),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(30),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Text(
                                                                  groups[index]
                                                                      .title,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 8.0),
                                                              child: Text('3/5',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      );
                                    else
                                      return Center(
                                          child: Text('Create a group!'));
                                  },
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
        ));
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
