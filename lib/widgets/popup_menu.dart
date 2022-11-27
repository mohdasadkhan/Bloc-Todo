import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xtodo/models/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislike;
  final VoidCallback editTaskCallBack;
  final VoidCallback restoreTaskCallBack;
  const PopupMenu(
      {Key? key,
      required this.cancelOrDeleteCallback,
      required this.task,
      required this.likeOrDislike,
      required this.editTaskCallBack,
      required this.restoreTaskCallBack
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: !task.isDeleted!
            ? (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: () => editTaskCallBack(),
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                    ),
                    onTap: () => editTaskCallBack(),
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: task.isFavorite!
                          ? const Icon(Icons.bookmark_remove)
                          : const Icon(Icons.bookmark_add_outlined),
                      label: task.isFavorite!
                          ? const Text('Remove from \nBookmarks')
                          : const Text('Add to \nBookmarks'),
                    ),
                    onTap: likeOrDislike,
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: cancelOrDeleteCallback,
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                    ),
                    onTap: cancelOrDeleteCallback,
                  ),
                ]
            : (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: restoreTaskCallBack,
                      icon: const Icon(Icons.restore_from_trash),
                      label: const Text('Restore'),
                    ),
                    onTap: restoreTaskCallBack,
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Delete Forever'),
                    ),
                    onTap: () {},
                  ),
                ]);
  }
}
