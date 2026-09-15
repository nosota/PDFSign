import 'package:flutter/material.dart';

import 'package:pdfsign/core/constants/image_import_limits.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_images_provider.dart';

/// Tells the user about images an import refused.
///
/// Says nothing when everything was added: the images appearing in the
/// sidebar is the confirmation. Names the limit that was hit when every
/// refusal hit the same one, which is the usual case — the alternative,
/// dropping the file in silence, reads as a bug.
void showImageImportReport(BuildContext context, ImageImportReport report) {
  if (report.rejections.isEmpty) {
    return;
  }

  final l10n = AppLocalizations.of(context);
  if (l10n == null) {
    return;
  }

  final count = report.rejections.length;
  final message = switch (report.sharedRejection) {
    ImageImportRejection.tooLarge =>
      l10n.imagesTooLarge(count, ImageImportLimits.fileSizeLabel),
    ImageImportRejection.tooManyPixels =>
      l10n.imagesTooManyPixels(count, ImageImportLimits.resolutionLabel),
    null => l10n.imagesNotAdded(count),
  };

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
