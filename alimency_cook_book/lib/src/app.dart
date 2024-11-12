import 'package:alimency_cook_book/src/home.dart';
import 'package:alimency_cook_book/src/repositories/dummy_ingredient_repo.dart';
import 'package:alimency_cook_book/src/view_models/ingredient_model.dart';
import 'package:alimency_cook_book/src/user_pantry/new_ingredient_view.dart';
import 'package:alimency_cook_book/src/user_pantry/user_pantry_view.dart';
import 'package:alimency_cook_book/src/view_models/pantry_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

 @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return ChangeNotifierProvider<PantryViewModel>(
          create: (_) => PantryViewModel(DummyIngredientRepo()),  // Add the provider here
          child: MaterialApp(
            restorationScopeId: 'app',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
            ],
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case SettingsView.routeName:
                      return SettingsView(controller: settingsController);
                    case SampleItemDetailsView.routeName:
                      return const SampleItemDetailsView();
                    case UserPantry.routeName:
                      return UserPantry();
                    case NewIngredientView.routeName:
                      return NewIngredientView();
                    default:
                      return Home();
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}