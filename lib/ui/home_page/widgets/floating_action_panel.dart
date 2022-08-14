import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/task_model.dart';
import '../../../repositories/tasks_controller.dart';
import '../../task_details_page/task_details_page.dart';

class FloatingActionPanel extends ConsumerWidget {
  const FloatingActionPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (kDebugMode)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: FloatingActionButton(
              heroTag: null,
              mini: true,
              onPressed: () {
                var task = Task.random();
                ref.watch(taskList.notifier).add(task);
              },
              child: const Icon(
                Icons.casino,
                size: 25,
              ),
            ),
          ),
        if (kDebugMode)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: FloatingActionButton(
              heroTag: null,
              mini: true,
              onPressed: () {
                throw Exception('Test crash by button in HomePage');
              },
              child: const Icon(
                Icons.warning,
                size: 25,
              ),
            ),
          ),
        FloatingActionButton(
          heroTag: null,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailsPage(
                  onSave: (task) {
                    ref.watch(taskList.notifier).add(task);
                  },
                ),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            size: 35,
          ),
        ),
      ],
    );
  }
}