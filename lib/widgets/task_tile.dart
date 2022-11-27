import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xtodo/constants/const.dart';
import 'package:xtodo/models/task.dart';
import 'package:xtodo/screens/edit_task_screen.dart';
import 'package:xtodo/widgets/popup_menu.dart';

import '../blocs/bloc_exports.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _editTask(BuildContext context) {
    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: EditTaskScreen(
          oldTask: task,
        ),
      ),
    );
    // Navigator.pop(context);
  }

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    debugPrint('inside Remove Or Delete');
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Row(
            children: [
              const SizedBox(width: 10.0),
              task.isFavorite!
                  ? const Icon(Icons.star)
                  : const Icon(Icons.star_outline),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null),
                    ),
                    // Text(DateFormat('dd-MM-yyyy hh:mm').format(DateTime.now()))
                    Text(DateFormat()
                        .add_yMMMd()
                        .format(DateTime.parse(task.date)))
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Checkbox(
              activeColor: appColor,
              onChanged: task.isDeleted == false
                  ? (value) =>
                      context.read<TasksBloc>().add(UpdateTask(task: task))
                  : null,
              value: task.isDone,
            ),
            PopupMenu(
              task: task,
              cancelOrDeleteCallback: () => _removeOrDeleteTask(context, task),
              likeOrDislike: () => context
                  .read<TasksBloc>()
                  .add(MarkFavoriteOrUnFavorite(task: task)),
              editTaskCallBack: () => _editTask(context),
              restoreTaskCallBack: () => context.read<TasksBloc>().add(RestoreTask(task: task)),
            )
          ],
        ),
      ],
    );
  }
}


    // return ListTile(
    //   onLongPress: () => _removeOrDeleteTask(context, task),
    //   title: Text(
    //     task.title,
    //     style: TextStyle(
    //         decoration: task.isDone! ? TextDecoration.lineThrough : null),
    //     overflow: TextOverflow.ellipsis,
    //   ),
    //   trailing: Checkbox(
    //     activeColor: appColor,
    //     onChanged: task.isDeleted == false
    //         ? (value) => context.read<TasksBloc>().add(UpdateTask(task: task))
    //         : null,
    //     value: task.isDone,
    //   ),
    // );