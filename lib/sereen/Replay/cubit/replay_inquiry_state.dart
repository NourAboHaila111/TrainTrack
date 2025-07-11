import '../../../model/SectionModel.dart';

abstract class ReplayInquiryState {}

class ReplayInquiryInitial extends ReplayInquiryState {}

class ReplayInquiryLoading extends ReplayInquiryState {}

class ReplayInquirySuccess extends ReplayInquiryState {
  final String message;
  ReplayInquirySuccess({required this.message});
}

// class ReplayInquiryFailure extends ReplayInquiryState {
//   final String error;
//   ReplayInquiryFailure({required this.error});
// }

class ReplayInquirySectionsLoaded extends ReplayInquiryState {
  final List<SectionModel> sections;
  final SectionModel? selectedSection;
  final String selectedStatus;

  ReplayInquirySectionsLoaded({
    required this.sections,
    required this.selectedSection,
    required this.selectedStatus,
  });

  ReplayInquirySectionsLoaded copyWith({
    List<SectionModel>? sections,
    SectionModel? selectedSection,
    String? selectedStatus,
  }) {
    return ReplayInquirySectionsLoaded(
      sections: sections ?? this.sections,
      selectedSection: selectedSection ?? this.selectedSection,
      selectedStatus: selectedStatus ?? this.selectedStatus,
    );
  }
}


//
// class ReplayInquirySectionsLoaded extends ReplayInquiryState {
//   final List<SectionModel> sections;
//   ReplayInquirySectionsLoaded(this.sections);
// }


class ReplayInquiryFailure extends ReplayInquiryState {
  final String message;
  ReplayInquiryFailure({required this.message});
}
