import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:triantrak/sereen/Replay/cubit/replay_inquiry_state.dart';

import '../../../model/SectionModel.dart';
import '../../../shared/network/remote/End_point.dart' show FOLLOWUP;
import '../../../shared/network/remote/dio_helper.dart';

class ReplayInquiryCubit extends Cubit<ReplayInquiryState> {
  ReplayInquiryCubit()
      : super(ReplayInquirySectionsLoaded(
    sections: [],
    selectedSection: null,
    selectedStatus: 'Open',
  ));

  void fetchSections(String token) {
    emit(ReplayInquiryLoading());

    DioHelper.getData(
      url: '/sections',
      token: token,
    ).then((response) {
      final List data = response.data;
      final sections = data.map((e) => SectionModel.fromJson(e)).toList();

      emit(ReplayInquirySectionsLoaded(
        sections: sections,
        selectedSection: null,
        selectedStatus: 'Open',
      ));
    }).catchError((error) {
      if (error is DioError) {
        final response = error.response;
        final message = response?.data['message'] ?? 'خطأ أثناء إنشاء المتابعة';
        emit(ReplayInquiryFailure(message: message));
      } else {
        emit(ReplayInquiryFailure(message: error.toString()));
      }
    });
  }


  void createFollowUp({
    required int inquiryId,
    required int sectionId,
    required String token, required String answer, required String status,
  }) {
    emit(ReplayInquiryLoading());

    DioHelper.postData(
      url: FOLLOWUP,
      token: token,
      data: {
        'inquiry_id': inquiryId,
        'status': 1,
        'section_id': sectionId,
      },
    ).then((response) {
      emit(ReplayInquirySuccess(message: response.data['message']));
    }).catchError((error) {
      if (error is DioError) {
        final response = error.response;
        final message = response?.data['message'] ?? 'خطأ أثناء إنشاء المتابعة';
        emit(ReplayInquiryFailure(message: message));
      } else {
        emit(ReplayInquiryFailure(message: error.toString()));
      }
    });
  }
  void deleteFollowUp({
    required int followUpId,
    required String token,
  }) {
    emit(ReplayInquiryLoading());

    DioHelper.deleteData(
      url: '/followups/$followUpId',
      token: token,
    ).then((response) {
      final message = response.data['message'] ?? 'Follow-up deleted';
      emit(ReplayInquirySuccess(message: message));
    }).catchError((error) {
      if (error is DioError) {
        final response = error.response;
        final message = response?.data['message'] ?? 'فشل حذف المتابعة';
        emit(ReplayInquiryFailure(message: message));
      } else {
        emit(ReplayInquiryFailure(message: error.toString()));
      }
    });
  }
  List<SectionModel> sections = [];




  void selectSection(SectionModel section) {
    if (state is ReplayInquirySectionsLoaded) {
      final current = state as ReplayInquirySectionsLoaded;
      emit(current.copyWith(selectedSection: section));
    }
  }

  void emitStatus(String status) {
    if (state is ReplayInquirySectionsLoaded) {
      final current = state as ReplayInquirySectionsLoaded;
      emit(current.copyWith(selectedStatus: status));
    }
  }
}
