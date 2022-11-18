import 'package:flutter/material.dart';
import 'package:xtodo/blocs/bloc_exports.dart';
import 'package:xtodo/constants/const.dart';
import 'package:xtodo/screens/recycle_bin.dart';
import 'package:xtodo/screens/tabs_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              padding:
                  const EdgeInsets.symmetric(vertical: 18.5, horizontal: 30.0),
              color: appColor,
              child: const Text(
                'Task Drawer',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return ListTile(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(TabsScreen.id),
                  leading: const Icon(
                    Icons.folder_special ,
                  ),
                  title: const Text('My Tasks'),
                  trailing: Text( '${state.pendingTasks.length} Pending | ${state.completedTasks.length} Completed'),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return ListTile(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(RecycleBin.id),
                  leading: const Icon(Icons.delete),
                  title: const Text('Bin'),
                  trailing: Text('${state.removedTasks.length}'),
                );
              },
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Switch(
                  activeColor: appColor,
                  value: state.switchValue,
                  onChanged: (value) {
                    value
                        ? context.read<SwitchBloc>().add(SwitchOnEvent())
                        : context.read<SwitchBloc>().add(SwitchOffEvent());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
