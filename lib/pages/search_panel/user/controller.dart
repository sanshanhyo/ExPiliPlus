import 'dart:math';

import 'package:ex_piliplus/models/common/search/user_search_type.dart';
import 'package:ex_piliplus/models/search/result.dart';
import 'package:ex_piliplus/pages/search/widgets/search_text.dart';
import 'package:ex_piliplus/pages/search_panel/controller.dart';
import 'package:ex_piliplus/utils/extension/context_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchUserController
    extends SearchPanelController<SearchUserData, SearchUserItemModel> {
  SearchUserController({
    required super.keyword,
    required super.searchType,
    required super.tag,
  });

  @override
  void onInit() {
    super.onInit();
    userType = UserType.all.obs;
    userOrderType = UserOrderType.def.obs;
  }

  void onShowFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth: min(640, context.mediaQueryShortestSide),
      ),
      builder: (context) {
        final theme = Theme.of(context);
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 20,
            left: 16,
            right: 16,
            bottom: 100 + MediaQuery.viewPaddingOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Text(
                context.l10n.searchUserSort,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: UserOrderType.values.map(
                  (e) {
                    final isCurr = e == userOrderType!.value;
                    return SearchText(
                      text: e.localizedLabel(context.l10n),
                      onTap: (_) {
                        userOrderType!.value = e;
                        order = e.order;
                        onSortSearch(label: e.localizedLabel(context.l10n));
                      },
                      bgColor: isCurr
                          ? theme.colorScheme.secondaryContainer
                          : null,
                      textColor: isCurr
                          ? theme.colorScheme.onSecondaryContainer
                          : null,
                    );
                  },
                ).toList(),
              ),
              const SizedBox(height: 20),
              Text(
                context.l10n.searchUserType,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: UserType.values.map(
                  (e) {
                    final isCurr = e == userType!.value;
                    return SearchText(
                      text: e.localizedLabel(context.l10n),
                      onTap: (_) {
                        userType!.value = e;
                        onSortSearch(label: e.localizedLabel(context.l10n));
                      },
                      bgColor: isCurr
                          ? theme.colorScheme.secondaryContainer
                          : null,
                      textColor: isCurr
                          ? theme.colorScheme.onSecondaryContainer
                          : null,
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
