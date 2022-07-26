import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../models/task_model.dart';

class AddTaskCard extends StatelessWidget {
  AddTaskCard({Key? key, required this.onAddTask}) : super(key: key);

  final Function(Task) onAddTask;

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  void onEditingComplete() {
    focusNode.unfocus();
    if (controller.text.isNotEmpty) {
      Task task = Task.create(
        text: controller.text,
      );
      onAddTask(task);
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        maxLines: null,
        textInputAction: TextInputAction.done,
        onEditingComplete: onEditingComplete,
        style: textTheme.bodyMedium,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(top: 14, bottom: 14, left: 52, right: 16),
          hintText: S.of(context).addTaskCardHint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
