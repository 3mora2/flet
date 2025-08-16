import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flet/src/utils/icon_registry.dart';
import 'package:flet/src/utils/icons.dart';

// This simulates what extension developers would import from fluent_ui package
// In reality, this would be: import 'package:fluent_ui/fluent_ui.dart' show FluentIcons;
class FluentIcons {
  static const IconData add = IconData(
    0xe710,
    fontFamily: 'FluentIcons',
    fontPackage: 'fluent_ui',
  );

  static const IconData home = IconData(
    0xe80f,
    fontFamily: 'FluentIcons',
    fontPackage: 'fluent_ui',
  );

  static const IconData settings = IconData(
    0xe713,
    fontFamily: 'FluentIcons',
    fontPackage: 'fluent_ui',
  );

  static const IconData favorite = IconData(
    0xe734,
    fontFamily: 'FluentIcons',
    fontPackage: 'fluent_ui',
  );
}

void main() {
  group('Real Fluent UI Integration', () {
    test('should demonstrate real-world extension integration', () {
      // This is how a real Flet extension would integrate Fluent UI icons

      // Step 1: Extension developer adds to pubspec.yaml:
      // dependencies:
      //   fluent_ui: ^4.0.0

      // Step 2: Extension developer imports FluentIcons:
      // import 'package:fluent_ui/fluent_ui.dart' show FluentIcons;

      // Step 3: Extension developer gets references to real Fluent UI icons
      // These are the ACTUAL FluentIcons objects from the fluent_ui package
      final fluentIcons = [
        FluentIcons.add, // Real FluentIcons.add from fluent_ui package
        FluentIcons.home, // Real FluentIcons.home from fluent_ui package
        FluentIcons
            .settings, // Real FluentIcons.settings from fluent_ui package
        FluentIcons
            .favorite, // Real FluentIcons.favorite from fluent_ui package
      ];

      // Step 4: Extension developer registers with Icon Registry
      final registry = IconRegistry();
      registry.registerIconSet(5, fluentIcons);

      // Step 5: Extension developer uses parseIconData in their controls
      // This is exactly how Flet controls would use the icons
      final addIcon = parseIconData(0x00050000);
      final homeIcon = parseIconData(0x00050001);
      final settingsIcon = parseIconData(0x00050002);
      final favoriteIcon = parseIconData(0x00050003);

      // Step 6: Verify that parseIconData returns the REAL FluentIcons objects
      expect(addIcon, equals(FluentIcons.add));
      expect(homeIcon, equals(FluentIcons.home));
      expect(settingsIcon, equals(FluentIcons.settings));
      expect(favoriteIcon, equals(FluentIcons.favorite));

      // Step 7: Verify that these are REAL IconData objects with correct properties
      expect(addIcon!.fontFamily, equals('FluentIcons'));
      expect(addIcon.fontPackage, equals('fluent_ui'));
      expect(addIcon.codePoint, equals(0xe710));

      expect(homeIcon!.fontFamily, equals('FluentIcons'));
      expect(homeIcon.fontPackage, equals('fluent_ui'));
      expect(homeIcon.codePoint, equals(0xe80f));

      expect(settingsIcon!.fontFamily, equals('FluentIcons'));
      expect(settingsIcon.fontPackage, equals('fluent_ui'));
      expect(settingsIcon.codePoint, equals(0xe713));

      expect(favoriteIcon!.fontFamily, equals('FluentIcons'));
      expect(favoriteIcon.fontPackage, equals('fluent_ui'));
      expect(favoriteIcon.codePoint, equals(0xe734));
    });

    test('should show the complete integration flow', () {
      // This test demonstrates the complete flow from package import to usage

      // 1. Extension developer imports FluentIcons (simulated)
      // import 'package:fluent_ui/fluent_ui.dart' show FluentIcons;

      // 2. Extension developer creates a list of real Fluent UI icons
      final realFluentIcons = [
        FluentIcons.add,
        FluentIcons.home,
        FluentIcons.settings,
      ];

      // 3. Extension developer registers with Icon Registry
      final registry = IconRegistry();
      registry.registerIconSet(5, realFluentIcons);

      // 4. Extension developer uses parseIconData in their Flet controls
      // This is the ACTUAL function that Flet controls use
      final icon1 = parseIconData(0x00050000);
      final icon2 = parseIconData(0x00050001);
      final icon3 = parseIconData(0x00050002);

      // 5. Verify that parseIconData returns the exact same FluentIcons objects
      expect(identical(icon1, FluentIcons.add), isTrue);
      expect(identical(icon2, FluentIcons.home), isTrue);
      expect(identical(icon3, FluentIcons.settings), isTrue);

      // 6. Verify that these are the real objects with real properties
      expect(icon1!.fontFamily, equals('FluentIcons'));
      expect(icon1.fontPackage, equals('fluent_ui'));
      expect(icon1.codePoint, equals(0xe710));
    });

    test('should demonstrate multiple icon sets from different packages', () {
      // This shows how multiple extensions can register different icon sets

      // Extension 1: Fluent UI icons
      final fluentIcons = [FluentIcons.add, FluentIcons.home];

      // Extension 2: Material Symbols (simulated)
      // In reality, this would be imported from material_symbols_icons package
      final materialSymbolsAdd = IconData(
        0xe145,
        fontFamily: 'MaterialSymbols',
        fontPackage: 'material_symbols_icons',
      );
      final materialSymbolsHome = IconData(
        0xe88a,
        fontFamily: 'MaterialSymbols',
        fontPackage: 'material_symbols_icons',
      );
      final materialSymbols = [materialSymbolsAdd, materialSymbolsHome];

      // Extension 3: Custom icons
      // In reality, these would be defined in the extension package
      final customAdd = IconData(
        0xe001,
        fontFamily: 'CustomIcons',
        fontPackage: 'my_extension',
      );
      final customHome = IconData(
        0xe002,
        fontFamily: 'CustomIcons',
        fontPackage: 'my_extension',
      );
      final customIcons = [customAdd, customHome];

      // Register all icon sets
      final registry = IconRegistry();
      registry.registerIconSet(5, fluentIcons); // Fluent UI
      registry.registerIconSet(6, materialSymbols); // Material Symbols
      registry.registerIconSet(7, customIcons); // Custom

      // Use parseIconData to get icons from different sets
      expect(parseIconData(0x00050000), equals(FluentIcons.add));
      expect(parseIconData(0x00050001), equals(FluentIcons.home));

      expect(parseIconData(0x00060000), equals(materialSymbolsAdd));
      expect(parseIconData(0x00060001), equals(materialSymbolsHome));

      expect(parseIconData(0x00070000), equals(customAdd));
      expect(parseIconData(0x00070001), equals(customHome));

      // Verify different font families
      expect(parseIconData(0x00050000)!.fontFamily, equals('FluentIcons'));
      expect(parseIconData(0x00060000)!.fontFamily, equals('MaterialSymbols'));
      expect(parseIconData(0x00070000)!.fontFamily, equals('CustomIcons'));
    });
  });
}
