import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'material_icons.dart';
import 'cupertino_icons.dart';

/// Registry for managing icon data across different icon sets.
class IconRegistry {
  static final IconRegistry _instance = IconRegistry._internal();

  factory IconRegistry() => _instance;

  IconRegistry._internal();

  /// Maps icon set IDs to their respective icon lists
  final Map<int, List<IconData>> _iconSets = {
    1: materialIcons, // Material Icons
    2: cupertinoIcons, // Cupertino Icons
  };

  /// Registers a new icon set with the given ID
  void registerIconSet(int setId, List<IconData> icons) {
    _iconSets[setId] = icons;
  }

  /// Creates IconData from an encoded icon code
  ///
  /// Icon codes are encoded as: (setId << 16) | iconIndex
  /// - Lower 16 bits: icon index within the set
  /// - Upper 16 bits: icon set identifier
  IconData? createIconData(int iconCode) {
    int setId = (iconCode >> 16) & 0xFF;
    int iconIndex = iconCode & 0xFFFF;

    final iconSet = _iconSets[setId];
    if (iconSet != null && iconIndex < iconSet.length) {
      return iconSet[iconIndex];
    }

    return null;
  }

  /// Gets the number of registered icon sets
  int get iconSetCount => _iconSets.length;

  /// Gets all registered icon set IDs
  Set<int> get registeredSetIds => _iconSets.keys.toSet();
}
