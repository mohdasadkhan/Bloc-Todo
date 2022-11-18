import 'package:flutter/material.dart';
import 'package:xtodo/constants/const.dart';
import 'package:xtodo/screens/add_task_screen.dart';
import 'package:xtodo/screens/completed_tasks_screen.dart';
import 'package:xtodo/screens/favorite_tasks_screen.dart';
import 'package:xtodo/screens/my_drawer.dart';
import 'package:xtodo/screens/pending_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {


  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: AddTaskScreen(),
      ),
    );
  }

  final List<Map<String, dynamic>> _pageDetails = [
    {'pagename': PendingTasksScreen(), 'title': 'Pending Tasks'},
    {'pagename': CompletedTasksScreen(), 'title': 'Completed Tasks'},
    {'pagename': FavoriteTasksScreen(), 'title': 'Favorite Tasks'},
  ];

  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text(
          _pageDetails[_selectedPageIndex]['title'],
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: _selectedPageIndex == 0 ? [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ] : [],
      ),
      drawer: const MyDrawer(),
      body: _pageDetails[_selectedPageIndex]['pagename'],
      floatingActionButton: _selectedPageIndex == 0 ?  FloatingActionButton(
        backgroundColor: appColor,
        onPressed: () => _addTask(context),
        tooltip: 'Add Task',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ) : null,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: appColor,
        selectedItemColor: Colors.cyan,
          currentIndex: _selectedPageIndex,
          onTap: (int index) {
            setState(() {
              _selectedPageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle_sharp),
              label: 'Pending Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done),
              label: 'Completed Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite Tasks',
            ),
          ]),
    );
  }
}
