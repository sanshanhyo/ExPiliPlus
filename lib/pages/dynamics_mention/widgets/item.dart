import 'package:ex_piliplus/common/widgets/image/network_img_layer.dart';
import 'package:ex_piliplus/models/common/image_type.dart';
import 'package:ex_piliplus/models_new/dynamic/dyn_mention/item.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/num_utils.dart';
import 'package:flutter/material.dart';

class DynMentionItem extends StatelessWidget {
  const DynMentionItem({
    super.key,
    required this.item,
    required this.onTap,
    required this.onCheck,
  });

  final MentionItem item;
  final VoidCallback onTap;
  final ValueChanged<bool?> onCheck;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        dense: true,
        onTap: onTap,
        visualDensity: .standard,
        leading: NetworkImgLayer(
          src: item.face,
          width: 42,
          height: 42,
          type: ImageType.avatar,
        ),
        title: Text(
          item.name!,
          style: const TextStyle(fontSize: 14),
        ),
        subtitle: Text(
          context.l10n.memberFollowerCount(NumUtils.numFormat(item.fans)),
          style: TextStyle(color: Theme.of(context).colorScheme.outline),
        ),
        trailing: Checkbox(
          tristate: false,
          value: item.checked,
          onChanged: (value) {
            item.checked = value!;
            (context as Element).markNeedsBuild();
            onCheck(value);
          },
        ),
      ),
    );
  }
}
