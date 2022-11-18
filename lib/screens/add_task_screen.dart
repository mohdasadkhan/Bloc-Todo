import 'package:flutter/material.dart';
import 'package:xtodo/constants/const.dart';
import 'package:xtodo/models/task.dart';
import 'package:xtodo/services/guid_gen.dart';
import '../blocs/bloc_exports.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({
    Key? key,
  }) : super(key: key);

  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            const Text(
              'Add Task',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: taskController,
              autofocus: true,
              decoration: appInputDecoration('title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter task to Add';
                }
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: descriptionController,
              autofocus: true,
              decoration: appInputDecoration('title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter task to Add';
                }
              },
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 20.0),
                    )),
                TextButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        Task newTask = Task(title: taskController.text, taskDescription: descriptionController.text, taskId: GUIDGen.generate(), date: DateTime.now().toString());
                        context.read<TasksBloc>().add(AddTask(task: newTask));
                        taskController.clear();
                        Navigator.pop(context);
                      }

                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 20.0),
                    )),
              ],
            )
          ]),
        ),
      ),
    );
  }

  appInputDecoration(String label) {
    return InputDecoration(
        labelText: label,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: red,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ));
  }
}
