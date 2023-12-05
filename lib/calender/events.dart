
class Event {
  final String title;
  final DateTime dateEvent;
  bool checkEvent;

  Event({
    required this.title,
    required this.dateEvent,
    required this.checkEvent,
  });

  @override
  String toString() {
    return 'Event: title=$title, date=$dateEvent, check=$checkEvent';
  }
}