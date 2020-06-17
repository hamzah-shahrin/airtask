import 'package:airtask/controllers/storage_controller.dart';
import 'package:airtask/models/task_group.dart';
import 'package:airtask/services/service_locator.dart';
import 'package:airtask/widgets/group_modal.dart';
import 'package:airtask/widgets/task_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class ListScreen extends StatefulWidget {
  final TaskGroup taskGroup;

  ListScreen({Key key, this.taskGroup}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListScreen();
}

class _ListScreen extends State<ListScreen> {

  final storageController = serviceLocator<StorageController>();
  var _taskGroup;

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
    _taskGroup = widget.taskGroup;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: _taskGroup.color,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: _taskGroup.color),
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right:10.0),
                            child: ClipOval(
                              child: Material(
                                color: _taskGroup.color,
                                child: InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Icon(OMIcons.arrowBack, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(_taskGroup.title,
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:30.0),
                            child: ClipOval(
                              child: Material(
                                color: _taskGroup.color,
                                child: InkWell(
                                  onTap: () async {
                                    await showModalBottomSheet(
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
                                            child: GroupModal(storageController: storageController, group: widget.taskGroup),
                                          ),
                                        );
                                      }
                                    ).then((newTaskGroup) {
                                      setState(() {
                                        if (newTaskGroup != null){
                                          _taskGroup.color = newTaskGroup.color;
                                          _taskGroup.title = newTaskGroup.title;
                                        }
                                      });
                                    });
                                  },
                                  child: Icon(OMIcons.edit, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0),
                            child: ClipOval(
                              child: Material(
                                color: _taskGroup.color,
                                child: InkWell(
                                  onTap: () async {
                                    await showModalBottomSheet(
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
                                            child: TaskModal(storageController: storageController, taskGroup: _taskGroup),
                                          ),
                                        );
                                      }
                                    ).then((value) {setState(() {});});
                                  },
                                  child: Icon(OMIcons.add, color: Colors.white, size: 30),
                                ),
                              ),
                            ),
                          ),
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
                            child: FutureBuilder(
                              future: storageController.tasks,
                              builder: (context, snapshot) {
                                var tasks;
                                if (snapshot.hasData)
                                  tasks = (snapshot.data).where((e) => e.groupId == _taskGroup.id).toList() ?? [];
                                else tasks = [];
                                if (tasks.length > 0) return Container(
                                    child: ScrollConfiguration(
                                      behavior: ScrollBehavior()
                                        ..buildViewportChrome(
                                            context, null, AxisDirection.down),
                                      child: ListView.builder(
                                          padding: EdgeInsets.all(10.0),
                                          shrinkWrap: true,
                                          itemCount: tasks.length,
                                          itemBuilder: (context, index) {
                                            return Dismissible(
                                              secondaryBackground: Container(
                                                alignment: Alignment.centerRight,
                                                padding: EdgeInsets.only(right: 20.0),
                                                child: Icon(OMIcons.delete,
                                                    color: Colors.red),
                                              ),
                                              background: Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.only(left: 20.0),
                                                child: Icon(OMIcons.edit,
                                                    color: Colors.green),
                                              ),
                                              confirmDismiss: (DismissDirection direction) async {
                                                if (direction == DismissDirection.startToEnd) {
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
                                                            child: TaskModal(storageController: storageController, taskGroup: _taskGroup, task: tasks[index]),
                                                          ),
                                                        );
                                                      });
                                                  setState(() {});
                                                  return false;
                                                } else {
                                                  storageController.deleteTask(id: tasks[index].id);
                                                  setState(() {});
                                                  return true;
                                                }
                                              },
                                              key: ObjectKey(index),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    storageController.editTask(
                                                        id: tasks[index].id,
                                                        groupId: tasks[index].groupId,
                                                        text: tasks[index].text,
                                                        completed: !tasks[index].completed
                                                    );
                                                    tasks[index].completed = !tasks[index].completed;
                                                  });
                                                },
                                                child: Container(
                                                  margin:
                                                  EdgeInsets.only(bottom: 0.0),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(tasks[index].completed
                                                            ? Icons.check : Icons.remove),
                                                        SizedBox(width: 10),
                                                        Flexible(
                                                          child: Text(tasks[index].text,
                                                              style: TextStyle(
                                                                  decoration: null,
                                                                  color: tasks[index].completed
                                                                      ? Colors.black54 : Colors.black)),
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
                                else return Center(child:Text('Add a task!'));
                              }
                            )
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
