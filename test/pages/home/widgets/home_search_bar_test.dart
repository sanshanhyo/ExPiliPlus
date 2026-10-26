import 'package:ex_piliplus/l10n/app_localization_delegates.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/pages/home/widgets/home_search_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets(
    'semantic home search entry opens the search route with its hint',
    (tester) async {
      final semantics = tester.ensureSemantics();
      addTearDown(semantics.dispose);

      await tester.pumpWidget(
        GetMaterialApp(
          locale: const Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: appLocalizationsDelegates,
          getPages: [
            GetPage<void>(
              name: '/search',
              page: () => const _SearchDestination(),
            ),
          ],
          home: Scaffold(
            body: Row(
              children: const [
                Expanded(
                  child: HomeSearchBar(
                    searchWord: 'fixed search query',
                    enableSearchWord: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final homeSearchBar = find.byType(HomeSearchBar);
      expect(homeSearchBar, findsOneWidget);
      final l10n = AppLocalizations.of(tester.element(homeSearchBar))!;
      final searchEntry = find.bySemanticsLabel(l10n.commonSearch);
      expect(searchEntry, findsOneWidget);
      await tester.tap(searchEntry);
      await tester.pumpAndSettle();

      expect(Get.currentRoute, '/search');
      expect(find.text('fixed search query'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      Get.reset();
    },
  );
}

class _SearchDestination extends StatelessWidget {
  const _SearchDestination();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Text(Get.parameters['hintText'] ?? 'no search hint')),
  );
}
