import 'package:flutter/material.dart';
import 'package:frontend/providers/TimeSheet.dart';
import '../providers/Tasks.dart';
import '../Services/Services.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_dropdown.dart';

class DropDownTask extends StatefulWidget {
  DropDownTask({key}) : super(key: key);

  @override
  _DropDownTaskState createState() => _DropDownTaskState();
}

class _DropDownTaskState extends State<DropDownTask> {
  List<Tasks> _users;

  Tasks _taskModel = Tasks();
  List<DropdownMenuItem<Tasks>> _taskModelList;
  List<DropdownMenuItem<Tasks>> _buildTaskModelDropdown(List taskModelList) {
    List<DropdownMenuItem<Tasks>> items = List();
    for (Tasks taskModel in taskModelList) {
      items.add(DropdownMenuItem(
        value: taskModel,
        child: Text(taskModel.name),
      ));
    }
    return items;
  }

  _onChangeTaskDropdown(Tasks taskModel) {
    TimeSheet timeSheet = Provider.of<TimeSheet>(context, listen: false);
    setState(() {
      _taskModel = taskModel;
      timeSheet.selectedTask = _taskModel;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      if (service.projectId != null) {
        service.getTasks().then((users) {
          setState(() {
            _users = users;

            _taskModelList = _buildTaskModelDropdown(_users);

            _taskModel = _users.first;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Task",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 9),
            child: _users != null
                ? CustomDropdown(
                    dropdownMenuItemList: _taskModelList,
                    onChanged: _onChangeTaskDropdown,
                    value: _taskModel,
                    isEnabled: true)
                : Text(
                    "No tasks added",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
      ],
    );
  }
}
