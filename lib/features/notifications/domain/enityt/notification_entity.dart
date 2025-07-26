import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String body;
  final DateTime dateTime;
  final bool isReminder;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.dateTime,
    required this.isReminder,
  });

  @override
  List<Object?> get props => [id, title, body, dateTime, isReminder];
}
