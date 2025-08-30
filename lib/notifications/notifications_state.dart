part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {

  List<dynamic> data = [];

  NotificationsLoaded(this.data);
}

class NotificationsError extends NotificationsState {
  final String message;

  NotificationsError(this.message);
}
