// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appTitle => 'ટનલ ટેક';

  @override
  String get homeTitle => 'ટનલ ટેક';

  @override
  String get homeSubtitle => 'મેટ્રો જાળવણી સહાયક';

  @override
  String get categoryDoors => 'દરવાજા';

  @override
  String get categoryTicketGates => 'ટિકિટ ગેટ';

  @override
  String get categoryLiftsEscalators => 'લિફ્ટ અને એસ્કેલેટર';

  @override
  String get categorySignalling => 'સિગ્નલિંગ';

  @override
  String get categoryPower => 'પાવર';

  @override
  String get categoryNetworkComms => 'નેટવર્ક / કોમ્સ';

  @override
  String get categoryHvac => 'એચવીએસી';

  @override
  String get categoryOther => 'અન્ય';

  @override
  String get symptomsTitle => 'લક્ષણો';

  @override
  String get stepsTitle => 'ટ્રબલશૂટિંગ સ્ટેપ્સ';

  @override
  String get safetyWarning => 'સુરક્ષા';

  @override
  String stepProgress(int current, int total) {
    return 'સ્ટેપ $current માંથી $total';
  }

  @override
  String get markFixed => 'ઠીક થયું';

  @override
  String get markNotFixed => 'ઠીક ન થયું';

  @override
  String get escalateCall => 'કંટ્રોલ રૂમ કૉલ કરો';

  @override
  String get escalateMessage =>
      'ખામી ઠીક ન થઈ. એસ્કેલેશન માટે કંટ્રોલ રૂમને કૉલ કરો.';

  @override
  String get shiftLogTitle => 'શિફ્ટ લોગ';

  @override
  String get shiftLogEmpty => 'આજે કોઈ ખામી નોંધાઈ નથી';

  @override
  String get statusFixed => 'ઠીક થયું';

  @override
  String get statusNotFixed => 'ઠીક ન થયું';

  @override
  String get statusPending => 'બાકી';

  @override
  String get statusSynced => 'સિંક થયું';

  @override
  String offlineChip(int count) {
    return 'ઑફલાઇન · $count બાકી';
  }

  @override
  String get onlineChip => 'ઑનલાઇન · સિંક થયું';

  @override
  String repeatFault(int count) {
    return 'પુનરાવર્તિત ખામી: આ અઠવાડિયે $count';
  }

  @override
  String get otherSearchHint => 'ખામીનું વર્ણન કરો…';

  @override
  String get otherSearchResults => 'સંભવિત મેળ';

  @override
  String get noMatchesFound => 'કોઈ મેળ મળ્યો નથી';

  @override
  String get assetLabelHint => 'એસેટ લેબલ (વૈકલ્પિક)';

  @override
  String get languageToggle => 'EN';

  @override
  String get languageToggleGu => 'ગુજ';

  @override
  String get progressComplete => 'બધા સ્ટેપ્સ પૂર્ણ';

  @override
  String get tapToStart => 'ટ્રબલશૂટિંગ શરૂ કરવા ખામી પર ટેપ કરો';
}
