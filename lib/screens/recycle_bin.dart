import 'package:flutter/material.dart';
import 'package:xtodo/blocs/bloc_exports.dart';
import 'package:xtodo/constants/const.dart';
import 'package:xtodo/screens/my_drawer.dart';
import 'package:xtodo/widgets/tasks_list.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({Key? key}) : super(key: key);
  static const id = 'recycle_bin_screen';

  void onTap(BuildContext context) =>
      context.read<TasksBloc>().add(DeleteAllTasks());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: appColor,
            title: const Text(
              'Recycle Bin',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              PopupMenuButton(
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: TextButton.icon(
                            onPressed: () => onTap(context),
                            icon: const Icon(Icons.delete_forever),
                            label: const Text('Delete all Tasks'),
                          ),
                          onTap: () => onTap(context),
                        )
                      ]),
            ],
          ),
          drawer: const MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text('${state.removedTasks.length} Tasks'),
                ),
              ),
              TasksList(tasksList: state.removedTasks)
            ],
          ),
        );
      },
    );
  }
}
