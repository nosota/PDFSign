import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'PDFSign'**
  String get appTitle;

  /// Welcome screen title
  ///
  /// In en, this message translates to:
  /// **'Welcome to PDFSign'**
  String get welcomeTitle;

  /// Button to open a PDF file
  ///
  /// In en, this message translates to:
  /// **'Open PDF'**
  String get openPdf;

  /// Recent files section title
  ///
  /// In en, this message translates to:
  /// **'Recent Files'**
  String get recentFiles;

  /// Message when there are no recent files
  ///
  /// In en, this message translates to:
  /// **'No recent files'**
  String get noRecentFiles;

  /// Button to select PDF on mobile
  ///
  /// In en, this message translates to:
  /// **'Select PDF'**
  String get selectPdf;

  /// No description provided for @file.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get file;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saveAs.
  ///
  /// In en, this message translates to:
  /// **'Save As...'**
  String get saveAs;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @quit.
  ///
  /// In en, this message translates to:
  /// **'Quit'**
  String get quit;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @redo.
  ///
  /// In en, this message translates to:
  /// **'Redo'**
  String get redo;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteSelected.
  ///
  /// In en, this message translates to:
  /// **'Delete Selected'**
  String get deleteSelected;

  /// No description provided for @zoomIn.
  ///
  /// In en, this message translates to:
  /// **'Zoom In'**
  String get zoomIn;

  /// No description provided for @zoomOut.
  ///
  /// In en, this message translates to:
  /// **'Zoom Out'**
  String get zoomOut;

  /// No description provided for @actualSize.
  ///
  /// In en, this message translates to:
  /// **'Actual Size'**
  String get actualSize;

  /// No description provided for @fitToScreen.
  ///
  /// In en, this message translates to:
  /// **'Fit to Screen'**
  String get fitToScreen;

  /// No description provided for @fullScreen.
  ///
  /// In en, this message translates to:
  /// **'Full Screen'**
  String get fullScreen;

  /// No description provided for @signatures.
  ///
  /// In en, this message translates to:
  /// **'Signatures'**
  String get signatures;

  /// No description provided for @stamps.
  ///
  /// In en, this message translates to:
  /// **'Stamps'**
  String get stamps;

  /// No description provided for @addSignature.
  ///
  /// In en, this message translates to:
  /// **'Add Signature'**
  String get addSignature;

  /// No description provided for @addStamp.
  ///
  /// In en, this message translates to:
  /// **'Add Stamp'**
  String get addStamp;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @editLabel.
  ///
  /// In en, this message translates to:
  /// **'Edit Label'**
  String get editLabel;

  /// No description provided for @deleteItem.
  ///
  /// In en, this message translates to:
  /// **'Delete Item'**
  String get deleteItem;

  /// No description provided for @rotate5Left.
  ///
  /// In en, this message translates to:
  /// **'Rotate 5° Left'**
  String get rotate5Left;

  /// No description provided for @rotate5Right.
  ///
  /// In en, this message translates to:
  /// **'Rotate 5° Right'**
  String get rotate5Right;

  /// No description provided for @rotate90.
  ///
  /// In en, this message translates to:
  /// **'Rotate 90°'**
  String get rotate90;

  /// No description provided for @scaleUp.
  ///
  /// In en, this message translates to:
  /// **'Scale +5%'**
  String get scaleUp;

  /// No description provided for @scaleDown.
  ///
  /// In en, this message translates to:
  /// **'Scale -5%'**
  String get scaleDown;

  /// No description provided for @bringToFront.
  ///
  /// In en, this message translates to:
  /// **'Bring to Front'**
  String get bringToFront;

  /// No description provided for @bringForward.
  ///
  /// In en, this message translates to:
  /// **'Bring Forward'**
  String get bringForward;

  /// No description provided for @sendBackward.
  ///
  /// In en, this message translates to:
  /// **'Send Backward'**
  String get sendBackward;

  /// No description provided for @sendToBack.
  ///
  /// In en, this message translates to:
  /// **'Send to Back'**
  String get sendToBack;

  /// Page indicator showing current and total pages
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String pageIndicator(int current, int total);

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password Required'**
  String get passwordRequired;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password to open this PDF'**
  String get enterPassword;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Number of password attempts remaining
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 attempt remaining} other{{count} attempts remaining}}'**
  String attemptsRemaining(int count);

  /// No description provided for @errorFileNotFound.
  ///
  /// In en, this message translates to:
  /// **'The selected file could not be found.'**
  String get errorFileNotFound;

  /// No description provided for @errorAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied. Please check file permissions.'**
  String get errorAccessDenied;

  /// No description provided for @errorInvalidFormat.
  ///
  /// In en, this message translates to:
  /// **'This file is not a valid PDF document.'**
  String get errorInvalidFormat;

  /// No description provided for @errorFileTooLarge.
  ///
  /// In en, this message translates to:
  /// **'Image size exceeds 100MB limit.'**
  String get errorFileTooLarge;

  /// No description provided for @errorResolutionTooHigh.
  ///
  /// In en, this message translates to:
  /// **'Image resolution exceeds 4096x4096 pixels.'**
  String get errorResolutionTooHigh;

  /// No description provided for @errorCorruptedPdf.
  ///
  /// In en, this message translates to:
  /// **'This PDF appears to be corrupted.'**
  String get errorCorruptedPdf;

  /// No description provided for @errorIncorrectPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get errorIncorrectPassword;

  /// No description provided for @errorWriteProtected.
  ///
  /// In en, this message translates to:
  /// **'This PDF is protected and cannot be modified.'**
  String get errorWriteProtected;

  /// No description provided for @errorSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save PDF.'**
  String get errorSaveFailed;

  /// No description provided for @errorInsufficientSpace.
  ///
  /// In en, this message translates to:
  /// **'Not enough disk space to save file.'**
  String get errorInsufficientSpace;

  /// No description provided for @errorReadOnlyLocation.
  ///
  /// In en, this message translates to:
  /// **'Cannot save to a read-only location.'**
  String get errorReadOnlyLocation;

  /// No description provided for @errorOutOfMemory.
  ///
  /// In en, this message translates to:
  /// **'Insufficient memory. Try closing other apps.'**
  String get errorOutOfMemory;

  /// No description provided for @errorDatabaseError.
  ///
  /// In en, this message translates to:
  /// **'Failed to access signature library.'**
  String get errorDatabaseError;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get errorUnknown;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this item?'**
  String get confirmDelete;

  /// No description provided for @confirmDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get confirmDeleteTitle;

  /// No description provided for @unsavedChanges.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved changes. Do you want to save before closing?'**
  String get unsavedChanges;

  /// No description provided for @unsavedChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Unsaved Changes'**
  String get unsavedChangesTitle;

  /// No description provided for @dontSave.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Save'**
  String get dontSave;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// Time since file was last opened
  ///
  /// In en, this message translates to:
  /// **'Opened {time} ago'**
  String openedAgo(String time);

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About PDFSign'**
  String get aboutApp;

  /// App version
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String version(String version);

  /// No description provided for @poweredBy.
  ///
  /// In en, this message translates to:
  /// **'Powered by Syncfusion Community License'**
  String get poweredBy;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @signatureAdded.
  ///
  /// In en, this message translates to:
  /// **'Signature added to library'**
  String get signatureAdded;

  /// No description provided for @stampAdded.
  ///
  /// In en, this message translates to:
  /// **'Stamp added to library'**
  String get stampAdded;

  /// No description provided for @itemDeleted.
  ///
  /// In en, this message translates to:
  /// **'Item deleted from library'**
  String get itemDeleted;

  /// No description provided for @pdfSaved.
  ///
  /// In en, this message translates to:
  /// **'PDF saved successfully'**
  String get pdfSaved;

  /// No description provided for @copyToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copy to Clipboard'**
  String get copyToClipboard;

  /// No description provided for @duplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get duplicate;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @clipboardEmpty.
  ///
  /// In en, this message translates to:
  /// **'Clipboard is empty'**
  String get clipboardEmpty;

  /// No description provided for @unsupportedImageFormat.
  ///
  /// In en, this message translates to:
  /// **'Unsupported image format'**
  String get unsupportedImageFormat;

  /// No description provided for @pasteImageTitle.
  ///
  /// In en, this message translates to:
  /// **'Paste Image'**
  String get pasteImageTitle;

  /// No description provided for @pasteImagePreview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get pasteImagePreview;

  /// No description provided for @pasteImageName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get pasteImageName;

  /// No description provided for @pasteImageNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter name for this image'**
  String get pasteImageNameHint;

  /// No description provided for @addToSignatures.
  ///
  /// In en, this message translates to:
  /// **'Add to Signatures'**
  String get addToSignatures;

  /// No description provided for @addToStamps.
  ///
  /// In en, this message translates to:
  /// **'Add to Stamps'**
  String get addToStamps;

  /// No description provided for @dontAddToLibrary.
  ///
  /// In en, this message translates to:
  /// **'Don\'t add to library'**
  String get dontAddToLibrary;

  /// No description provided for @dontAskAgain.
  ///
  /// In en, this message translates to:
  /// **'Don\'t ask again'**
  String get dontAskAgain;

  /// No description provided for @paste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// No description provided for @clipboardBehavior.
  ///
  /// In en, this message translates to:
  /// **'Clipboard Behavior'**
  String get clipboardBehavior;

  /// No description provided for @resetPastePreference.
  ///
  /// In en, this message translates to:
  /// **'Reset \"Don\'t ask again\" preference'**
  String get resetPastePreference;

  /// No description provided for @defaultPasteTarget.
  ///
  /// In en, this message translates to:
  /// **'Default paste target'**
  String get defaultPasteTarget;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
