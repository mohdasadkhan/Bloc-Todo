import 'package:flutter/material.dart';
import 'package:xtodo/constants/const.dart';
import 'package:xtodo/models/task.dart';
import 'package:xtodo/services/guid_gen.dart';
import '../blocs/bloc_exports.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;
  EditTaskScreen({Key? key, required this.oldTask}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController taskController =
        TextEditingController(text: oldTask.title);
    final TextEditingController descriptionController =
        TextEditingController(text: oldTask.taskDescription);
    return Form(
      key: _formKey,
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            const Text(
              'Edit Task',
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
                      if (_formKey.currentState!.validate()) {
                        var editedTask = Task(
                            title: taskController.text,
                            taskDescription: descriptionController.text,
                            taskId: oldTask.taskId,
                            isFavorite: oldTask.isFavorite,
                            isDone: false,
                            date: DateTime.now().toString());
                        context.read<TasksBloc>().add(
                            EditTask(oldTask: oldTask, newTask: editedTask));
                        taskController.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Save',
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
