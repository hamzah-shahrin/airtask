import 'package:airtask/controllers/storage_controller.dart';
import 'package:airtask/models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class TaskModal extends StatefulWidget {

  final StorageController storageController;
  final int groupId;
  final Task task;
  TaskModal({Key key,
    @required this.storageController,
    @required this.groupId, this.task}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskModal();

}

class _TaskModal extends State<TaskModal>{

  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  void initState() {
    _textController.text = widget.task == null ? null : widget.task.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(widget.task == null ? 'Add a new task' : 'Edit a task'),
                  Spacer(),
                  Tooltip(
                    preferBelow: false,
                    message: '42 character limit. Stick to concise tasks!',
                    child: Icon(Icons.help_outline, color: Colors.indigo[900], size: 30),
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors.indigo[900],
                      child: InkWell(
                        splashColor: Colors.indigoAccent,
                        child: SizedBox(width: 25, height: 25,
                            child: Icon(
                                widget.task == null ? Icons.add : Icons.check,
                                color: Colors.white, size: 18)),
                        onTap: () {
                          if (widget.task == null) widget.storageController.addTask(
                            groupId: widget.groupId, text: _textController.text);
                          else widget.storageController.editTask(
                            id: widget.task.id, groupId: widget.groupId,
                            text: _textController.text, completed: widget.task.completed);
                          _textController.clear();
                          FocusScope.of(context).unfocus();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(42)
                ],
                controller: _textController,
                decoration: InputDecoration(labelText: 'Task',
                    labelStyle: TextStyle(fontSize: 14)),
                validator: (value) {
                  if (value.isEmpty) return 'Please enter a task';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}