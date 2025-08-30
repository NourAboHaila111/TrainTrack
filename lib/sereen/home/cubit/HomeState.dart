



import '../../../model/InquiryModel.dart';

abstract class InquiriesState {}

class InquiriesInitial extends InquiriesState {}

class InquiriesLoading extends InquiriesState {}

class InquiriesLoaded extends InquiriesState {
  final List<Inquiry> inquiries;

  InquiriesLoaded({required this.inquiries});
}

class InquiriesError extends InquiriesState {
  final String message;

  InquiriesError({required this.message});
}
