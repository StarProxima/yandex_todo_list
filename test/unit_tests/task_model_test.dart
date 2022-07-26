import 'package:flutter_test/flutter_test.dart';
import 'package:todo_manager/models/importance.dart';
import 'package:todo_manager/models/task_model.dart';

void main() {
  test(
    'Task create constructor create a valid task',
    () {
      final task = Task.create(
        text: 'Test task text',
        done: true,
        importance: Importance.low,
        deadline: DateTime(2024, 1, 1, 12),
      );

      expect(task.text, 'Test task text');
      expect(task.done, true);
      expect(task.importance, Importance.low);
      expect(task.deadline, DateTime(2024, 1, 1, 12));
    },
  );

  test(
    'Task edit method works correctly',
    () async {
      final task = Task.create(
        text: 'Test task text',
        done: true,
        importance: Importance.low,
        deadline: DateTime(2024, 1, 1, 12),
      );

      await Future.delayed(const Duration(milliseconds: 10));

      final editedTask = task.edit(
        text: 'Edited task text',
        done: false,
        importance: Importance.important,
        deadline: DateTime(2023),
      );

      final taskWithoutDeadline = editedTask.edit(
        deleteDeadline: true,
      );

      expect(editedTask.text, 'Edited task text');
      expect(editedTask.done, false);
      expect(editedTask.importance, Importance.important);
      expect(editedTask.deadline, DateTime(2023));
      expect(editedTask.createdAt, task.createdAt);
      expect(task.changedAt.isBefore(editedTask.changedAt), true);
      expect(taskWithoutDeadline.deadline, null);
    },
  );
}
