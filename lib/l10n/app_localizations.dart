import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_gu.dart';

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
    Locale('gu'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Tunnel Tech'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Tunnel Tech'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Metro Maintenance Assistant'**
  String get homeSubtitle;

  /// No description provided for @categoryDoors.
  ///
  /// In en, this message translates to:
  /// **'Doors'**
  String get categoryDoors;

  /// No description provided for @categoryTicketGates.
  ///
  /// In en, this message translates to:
  /// **'Ticket Gates'**
  String get categoryTicketGates;

  /// No description provided for @categoryLiftsEscalators.
  ///
  /// In en, this message translates to:
  /// **'Lifts & Escalators'**
  String get categoryLiftsEscalators;

  /// No description provided for @categorySignalling.
  ///
  /// In en, this message translates to:
  /// **'Signalling'**
  String get categorySignalling;

  /// No description provided for @categoryPower.
  ///
  /// In en, this message translates to:
  /// **'Power'**
  String get categoryPower;

  /// No description provided for @categoryNetworkComms.
  ///
  /// In en, this message translates to:
  /// **'Network / Comms'**
  String get categoryNetworkComms;

  /// No description provided for @categoryHvac.
  ///
  /// In en, this message translates to:
  /// **'HVAC'**
  String get categoryHvac;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @symptomsTitle.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get symptomsTitle;

  /// No description provided for @stepsTitle.
  ///
  /// In en, this message translates to:
  /// **'Troubleshooting Steps'**
  String get stepsTitle;

  /// No description provided for @safetyWarning.
  ///
  /// In en, this message translates to:
  /// **'SAFETY'**
  String get safetyWarning;

  /// No description provided for @stepProgress.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String stepProgress(int current, int total);

  /// No description provided for @markFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get markFixed;

  /// No description provided for @markNotFixed.
  ///
  /// In en, this message translates to:
  /// **'Not Fixed'**
  String get markNotFixed;

  /// No description provided for @escalateCall.
  ///
  /// In en, this message translates to:
  /// **'Call Control Room'**
  String get escalateCall;

  /// No description provided for @escalateMessage.
  ///
  /// In en, this message translates to:
  /// **'Could not resolve fault. Tap to call the control room for escalation.'**
  String get escalateMessage;

  /// No description provided for @shiftLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Shift Log'**
  String get shiftLogTitle;

  /// No description provided for @shiftLogEmpty.
  ///
  /// In en, this message translates to:
  /// **'No faults logged today'**
  String get shiftLogEmpty;

  /// No description provided for @statusFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get statusFixed;

  /// No description provided for @statusNotFixed.
  ///
  /// In en, this message translates to:
  /// **'Not Fixed'**
  String get statusNotFixed;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusSynced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get statusSynced;

  /// No description provided for @offlineChip.
  ///
  /// In en, this message translates to:
  /// **'Offline · {count} pending'**
  String offlineChip(int count);

  /// No description provided for @onlineChip.
  ///
  /// In en, this message translates to:
  /// **'Online · synced'**
  String get onlineChip;

  /// No description provided for @repeatFault.
  ///
  /// In en, this message translates to:
  /// **'Repeat fault: {count} this week'**
  String repeatFault(int count);

  /// No description provided for @otherSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the fault…'**
  String get otherSearchHint;

  /// No description provided for @otherSearchResults.
  ///
  /// In en, this message translates to:
  /// **'Possible matches'**
  String get otherSearchResults;

  /// No description provided for @noMatchesFound.
  ///
  /// In en, this message translates to:
  /// **'No matches found'**
  String get noMatchesFound;

  /// No description provided for @assetLabelHint.
  ///
  /// In en, this message translates to:
  /// **'Asset label (optional)'**
  String get assetLabelHint;

  /// No description provided for @languageToggle.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get languageToggle;

  /// No description provided for @languageToggleGu.
  ///
  /// In en, this message translates to:
  /// **'ગુજ'**
  String get languageToggleGu;

  /// No description provided for @progressComplete.
  ///
  /// In en, this message translates to:
  /// **'All steps completed'**
  String get progressComplete;

  /// No description provided for @tapToStart.
  ///
  /// In en, this message translates to:
  /// **'Tap a fault to begin troubleshooting'**
  String get tapToStart;
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
      <String>['en', 'gu'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'gu':
      return AppLocalizationsGu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
