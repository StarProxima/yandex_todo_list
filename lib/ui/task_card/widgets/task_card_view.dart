part of '../task_card.dart';

class _TaskCardView extends ConsumerWidget {
  const _TaskCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(_currentTaskInTaskCard);

    final crossedOut = Theme.of(context).extension<AppTextStyle>()!.crossedOut!;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return TaskDetailsPage(
                task: task,
              );
            },
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TaskCheckbox(
            value: task.done,
            task: task,
            onChanged: (value) {
              ref.read(taskList.notifier).edit(task.edit(done: value));
            },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: RichText(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: task.done
                          ? crossedOut
                          : Theme.of(context).textTheme.bodyMedium,
                      children: [
                        if (task.importance == Importance.important)
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 3),
                              child: AppSvgIcons(
                                AppSvgIcon.important,
                                color: task.done
                                    ? crossedOut.color
                                    : AppColors.red,
                              ),
                            ),
                          ),
                        if (task.importance == Importance.low)
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 3),
                              child: AppSvgIcons(
                                AppSvgIcon.low,
                                color: crossedOut.color,
                              ),
                            ),
                          ),
                        TextSpan(
                          text: task.text,
                        ),
                      ],
                    ),
                  ),
                ),
                if (task.deadline != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat('dd MMMM yyyy', 'ru_RU')
                          .format(task.deadline!),
                      style: Theme.of(context)
                          .extension<AppTextStyle>()!
                          .subtitle!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15, left: 14, right: 18),
            child: Icon(
              Icons.info_outline,
            ),
          ),
        ],
      ),
    );
  }
}
