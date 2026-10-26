import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    required this.searchWord,
    required this.enableSearchWord,
    super.key,
  });

  final String searchWord;
  final bool enableSearchWord;

  void _openSearch() {
    Get.toNamed(
      '/search',
      parameters: enableSearchWord ? {'hintText': searchWord} : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const borderRadius = BorderRadius.all(Radius.circular(25));

    return Semantics(
      key: const ValueKey('home-search-entrypoint'),
      button: true,
      label: context.l10n.commonSearch,
      hint: searchWord,
      onTap: _openSearch,
      child: ExcludeSemantics(
        child: SizedBox(
          height: 44,
          child: Material(
            borderRadius: borderRadius,
            color: theme.colorScheme.onSecondaryContainer.withValues(
              alpha: 0.05,
            ),
            child: InkWell(
              borderRadius: borderRadius,
              splashColor: theme.colorScheme.primaryContainer.withValues(
                alpha: 0.3,
              ),
              onTap: _openSearch,
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  Icon(
                    Icons.search_outlined,
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      searchWord,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: theme.colorScheme.outline),
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
