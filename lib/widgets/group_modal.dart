import 'package:airtask/controllers/storage_controller.dart';
import 'package:airtask/models/task_group.dart';
import 'package:airtask/widgets/colored_radio_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupModal extends StatefulWidget {

  final StorageController storageController;
  final TaskGroup group;

  const GroupModal({Key key,
    @required this.storageController, this.group}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GroupModal();
}

class _GroupModal extends State<GroupModal> {

  final _colors = Colors.accents;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  int _selectedColor;

  void _selectColor(int index) {
    setState(() {
      _selectedColor = index;
    });
  }

  @override
  void initState() {
    _selectedColor = widget.group == null ? 0 : _colors.indexWhere(
        (element) => element.value == widget.group.color.value);
    _titleController.text = widget.group == null ? null : widget.group.title;
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.group == null ? 'Add a new list' : 'Edit a list'),
                  ClipOval(
                    child: Material(
                      color: Colors.indigo[900],
                      child: InkWell(
                        splashColor: Colors.indigoAccent,
                        child: SizedBox(width: 25, height: 25,
                          child: Icon(
                              widget.group == null ? Icons.add : Icons.check,
                              color: Colors.white, size: 18)),
                        onTap: () {
                          var _text = _titleController.text;
                          if (_formKey.currentState.validate()) {
                            if (widget.group == null) widget.storageController
                              .addGroup(
                                title: _text,
                                color: _colors[_selectedColor]);
                            else widget.storageController.editGroup(
                                id: widget.group.id,
                                title: _text,
                                color: _colors[_selectedColor]);
                            _titleController.clear();
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context, widget.group == null
                              ? null : TaskGroup(id: widget.group.id,
                                title: _text, color: _colors[_selectedColor]));
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title',
                    labelStyle: TextStyle(fontSize: 14)),
                validator: (value) {
                  if (value.isEmpty) return 'Please enter a title';
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text('Select list color'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Container(
                  height: 30,
                  child: ListView.builder(
                    itemCount: _colors.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ColoredRadioButton(
                      defaultColor: _colors[index],
                      isSelected: _selectedColor == index ? true : false,
                      onPressed: () => _selectColor(index),
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}