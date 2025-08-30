import 'package:file_picker/file_picker.dart';

abstract class ReplayInquiryState {}

class ReplayInquiryInitial extends ReplayInquiryState {}

class ReplayInquiryLoading extends ReplayInquiryState {}

class ReplayInquirySuccess extends ReplayInquiryState {
  final String message;
  ReplayInquirySuccess(this.message);
}

class ReplayInquiryError extends ReplayInquiryState {
  final String message;
  ReplayInquiryError(this.message);
}

class ReplayInquiryAttachmentsAdded extends ReplayInquiryState {
  final List<PlatformFile> attachments;
  ReplayInquiryAttachmentsAdded(this.attachments);
}
class ReplayInquiryUpdated extends ReplayInquiryState {}