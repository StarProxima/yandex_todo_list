import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';
import 'widgets/add_task_card.dart';

import '../../models/task_model.dart';
import '../../repositories/tasks_controller.dart';
import 'widgets/floating_action_panel.dart';
import 'widgets/home_page_header_delegate.dart';
import 'widgets/task_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  void onEditTask(task) async {
    ref.read(taskList.notifier).edit(task);
  }

  void onDeleteTask(task) async {
    ref.read(taskList.notifier).delete(task);
  }

  void onAddTask(task) async {
    ref.read(taskList.notifier).add(task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: HomePageHeaderDelegate(
                    orientation == Orientation.portrait ? 200 : 125,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          color: Theme.of(context).shadowColor.withOpacity(0.2),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Consumer(
                      builder: (context, ref, child) {
                        ref.watch(appThemeMode);
                        ref.watch(dismissibleTaskListController);
                        List<Task> tasks = ref.read(filteredTaskList);
                        log('message');
                        return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: tasks.length + 1,
                          itemBuilder: (context, index) {
                            if (index == tasks.length) {
                              return AddTaskCard(
                                onAddTask: onAddTask,
                              );
                            }

                            final task = tasks[index];

                            return TaskCard(
                              task: task,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: const FloatingActionPanel(),
    );
  }
}
