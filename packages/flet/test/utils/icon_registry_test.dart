import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flet/src/utils/icon_registry.dart';

void main() {
  group('IconRegistry', () {
    test('should create material icon data correctly', () {
      final registry = IconRegistry();

      // Test material icon (setId = 1, iconIndex = 0 should be Icons.abc)
      final iconData = registry.createIconData(0x00010000);

      expect(iconData, isNotNull);
      expect(iconData, equals(Icons.abc));
    });

    test('should create cupertino icon data correctly', () {
      final registry = IconRegistry();

      // Test cupertino icon (setId = 2, iconIndex = 0 should be CupertinoIcons.add)
      final iconData = registry.createIconData(0x00020000);

      expect(iconData, isNotNull);
      expect(iconData, equals(CupertinoIcons.add));
    });

    test('should return null for unknown icon set', () {
      final registry = IconRegistry();

      // Test unknown icon set (setId = 99)
      final iconData = registry.createIconData(0x00630000);

      expect(iconData, isNull);
    });

    test('should return null for out of bounds icon index', () {
      final registry = IconRegistry();

      // Test out of bounds index (assuming material icons don't have 99999 icons)
      final iconData =
          registry.createIconData(0x0001869F); // setId=1, index=99999

      expect(iconData, isNull);
    });

    test('should handle icon code decoding correctly', () {
      final registry = IconRegistry();

      // Test with specific icon codes
      final materialIcon =
          registry.createIconData(0x00010001); // setId=1, index=1
      final cupertinoIcon =
          registry.createIconData(0x00020001); // setId=2, index=1

      expect(materialIcon, isNotNull);
      expect(cupertinoIcon, isNotNull);
      expect(materialIcon, isNot(equals(cupertinoIcon)));
    });

    test('should allow registering new icon sets', () {
      final registry = IconRegistry();
      final customIcons = [Icons.home, Icons.settings, Icons.person];

      registry.registerIconSet(3, customIcons);

      final iconData = registry.createIconData(0x00030000); // setId=3, index=0
      expect(iconData, equals(Icons.home));

      final iconData2 = registry.createIconData(0x00030001); // setId=3, index=1
      expect(iconData2, equals(Icons.settings));
    });

    test('should provide access to registered set IDs', () {
      final registry = IconRegistry();

      expect(registry.registeredSetIds, contains(1));
      expect(registry.registeredSetIds, contains(2));
      expect(registry.iconSetCount, greaterThan(0));
    });
  });
}
