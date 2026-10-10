/// App constants — control room number, categories, theme seeds.
library;

/// Control room phone number for escalation.
const String kControlRoomNumber = 'tel:+911234567890';

/// Category identifiers matching manual.json.
enum FaultCategory {
  doors('Doors'),
  ticketGates('Ticket Gates'),
  liftsEscalators('Lifts & Escalators'),
  signalling('Signalling'),
  power('Power'),
  networkComms('Network/Comms'),
  hvac('HVAC'),
  other('Other');

  const FaultCategory(this.jsonKey);

  /// The value used in manual.json `category` field.
  final String jsonKey;
}
