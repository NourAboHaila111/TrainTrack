import '../../../model/InquiryModel.dart';

abstract class SearchInquiryState {}

class SearchInquiryInitial extends SearchInquiryState {}

class SearchInquiryLoading extends SearchInquiryState {}

class SearchInquirySuccess extends SearchInquiryState {
  final List<Inquiry> inquiries;
  SearchInquirySuccess(this.inquiries);
}

class SearchInquiryFailure extends SearchInquiryState {
  final String error;
  SearchInquiryFailure(this.error);
}
