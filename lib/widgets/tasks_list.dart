import 'package:flutter/material.dart';
import 'package:time_elapsed/time_elapsed.dart';
import 'package:xtodo/models/task.dart';
import 'package:xtodo/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.tasksList,
  }) : super(key: key);

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: tasksList
              .map(
                (task) => ExpansionPanelRadio(
                  value: task.taskId,
                  headerBuilder: (context, isOpen) => TaskTile(task: task),
                  body: ListTile(
                    title: SelectableText.rich(
                      TextSpan(children: [
                        const TextSpan(text: 'Text: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: task.title),
                       const  TextSpan(text: '\n\nDescription: ', style: TextStyle(fontWeight: FontWeight.bold)),
                       TextSpan(text: task.taskDescription + '\n'),
                       TextSpan(text: '' + TimeElapsed.fromDateStr(task.date))
                      ]),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}