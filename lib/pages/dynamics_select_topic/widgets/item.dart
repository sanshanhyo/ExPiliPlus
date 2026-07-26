import 'package:ex_piliplus/common/widgets/custom_icon.dart';
import 'package:ex_piliplus/models_new/dynamic/dyn_topic_top/topic_item.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/num_utils.dart';
import 'package:flutter/material.dart';

class DynTopicItem extends StatelessWidget {
  const DynTopicItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  final TopicItem item;
  final ValueChanged<TopicItem> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        dense: true,
        onTap: () => onTap(item),
        title: Text.rich(
          TextSpan(
            children: [
              const WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    CustomIcons.topic_tag,
                    size: 18,
                  ),
                ),
              ),
              TextSpan(
                text: item.name,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 23),
          child: Text(
            context.l10n.topicStats(
              NumUtils.numFormat(item.view),
              NumUtils.numFormat(item.discuss),
            ),
            style: TextStyle(color: Theme.of(context).colorScheme.outline),
          ),
        ),
      ),
    );
  }
}
