import 'package:flutter/material.dart';

import '../models/control.dart';
import 'icon_registry.dart';
import 'material_state.dart';

IconData? parseIconData(int? value, [IconData? defaultValue]) {
  if (value == null) return defaultValue;

  return IconRegistry().createIconData(value);
}

WidgetStateProperty<Icon?>? parseWidgetStateIcon(
  dynamic value,
  ThemeData theme, {
  Icon? defaultIcon,
  WidgetStateProperty<Icon?>? defaultValue,
}) {
  if (value == null) return defaultValue;
  return getWidgetStateProperty<Icon?>(
      value, (jv) => Icon(parseIconData(jv as int)), defaultIcon);
}

extension IconParsers on Control {
  IconData? getIconData(String propertyName, [IconData? defaultValue]) {
    return parseIconData(get(propertyName), defaultValue);
  }

  WidgetStateProperty<Icon?>? getWidgetStateIcon(
      String propertyName, ThemeData theme,
      {Icon? defaultIcon, WidgetStateProperty<Icon?>? defaultValue}) {
    return parseWidgetStateIcon(get(propertyName), theme,
        defaultIcon: defaultIcon, defaultValue: defaultValue);
  }
}
