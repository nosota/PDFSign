import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/presentation/providers/shared_preferences_provider.dart';

/// Units for displaying object dimensions.
enum SizeUnit {
  /// Centimeters
  cm,

  /// Inches
  inch,
}

const _key = 'size_unit_preference';

/// Provider for managing the preferred size unit (cm or inch).
///
/// Persists the preference in SharedPreferences and syncs between windows.
final sizeUnitPreferenceProvider =
    NotifierProvider<SizeUnitPreferenceNotifier, SizeUnit>(
  SizeUnitPreferenceNotifier.new,
);

/// Notifier for size unit preference state.
class SizeUnitPreferenceNotifier extends Notifier<SizeUnit> {
  @override
  SizeUnit build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final stored = prefs.getString(_key);
    return stored == 'inch' ? SizeUnit.inch : SizeUnit.cm;
  }

  /// Toggles between cm and inch.
  void toggle() {
    final prefs = ref.read(sharedPreferencesProvider);
    final newUnit = state == SizeUnit.cm ? SizeUnit.inch : SizeUnit.cm;
    prefs.setString(_key, newUnit.name);
    state = newUnit;
  }

  /// Sets the unit directly.
  void setUnit(SizeUnit unit) {
    if (state == unit) return;
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setString(_key, unit.name);
    state = unit;
  }
}
