// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tunnel Tech';

  @override
  String get homeTitle => 'Tunnel Tech';

  @override
  String get homeSubtitle => 'Metro Maintenance Assistant';

  @override
  String get categoryDoors => 'Doors';

  @override
  String get categoryTicketGates => 'Ticket Gates';

  @override
  String get categoryLiftsEscalators => 'Lifts & Escalators';

  @override
  String get categorySignalling => 'Signalling';

  @override
  String get categoryPower => 'Power';

  @override
  String get categoryNetworkComms => 'Network / Comms';

  @override
  String get categoryHvac => 'HVAC';

  @override
  String get categoryOther => 'Other';

  @override
  String get symptomsTitle => 'Symptoms';

  @override
  String get stepsTitle => 'Troubleshooting Steps';

  @override
  String get safetyWarning => 'SAFETY';

  @override
  String stepProgress(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get markFixed => 'Fixed';

  @override
  String get markNotFixed => 'Not Fixed';

  @override
  String get escalateCall => 'Call Control Room';

  @override
  String get escalateMessage =>
      'Could not resolve fault. Tap to call the control room for escalation.';

  @override
  String get shiftLogTitle => 'Shift Log';

  @override
  String get shiftLogEmpty => 'No faults logged today';

  @override
  String get statusFixed => 'Fixed';

  @override
  String get statusNotFixed => 'Not Fixed';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusSynced => 'Synced';

  @override
  String offlineChip(int count) {
    return 'Offline · $count pending';
  }

  @override
  String get onlineChip => 'Online · synced';

  @override
  String repeatFault(int count) {
    return 'Repeat fault: $count this week';
  }

  @override
  String get otherSearchHint => 'Describe the fault…';

  @override
  String get otherSearchResults => 'Possible matches';

  @override
  String get noMatchesFound => 'No matches found';

  @override
  String get assetLabelHint => 'Asset label (optional)';

  @override
  String get languageToggle => 'EN';

  @override
  String get languageToggleGu => 'ગુજ';

  @override
  String get progressComplete => 'All steps completed';

  @override
  String get tapToStart => 'Tap a fault to begin troubleshooting';
}
