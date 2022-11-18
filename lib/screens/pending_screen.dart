import 'package:flutter/material.dart';
import 'package:xtodo/blocs/bloc_exports.dart';
import 'package:xtodo/models/task.dart';
import 'package:xtodo/screens/my_drawer.dart';
import 'package:xtodo/widgets/tasks_list.dart';

class PendingTasksScreen extends StatelessWidget {
  PendingTasksScreen({Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  static const id = 'pending_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.pendingTasks;
        return Scaffold(
          drawer: const MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                      '${tasksList.length} Pending | ${state.completedTasks.length} Completed'),
                ),
              ),
              TasksList(tasksList: tasksList)
            ],
          ),
        );
      },
    );
  }
}
