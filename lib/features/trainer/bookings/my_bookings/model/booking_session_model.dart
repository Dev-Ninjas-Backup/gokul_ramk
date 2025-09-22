enum SessionStatus { upcoming, completed, cancelled }

class BookingSessionModel {
  final String name;
  final String imageUrl;
  final String sessionType;
  final DateTime dateTime;
  final SessionStatus status;

  BookingSessionModel({
    required this.name,
    required this.imageUrl,
    required this.sessionType,
    required this.dateTime,
    required this.status,
  });

  String get formattedDate {
    return "${dateTime.month}/${dateTime.day}, ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour >= 12 ? 'PM' : 'AM'}";
  }
}
