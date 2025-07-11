// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
//
// import '../../../model/InquiryModel.dart';
// import '../../../shared/network/remote/dio_helper.dart';
// import 'HomeState.dart';
//
//
// class InquiriesCubit extends Cubit<InquiriesState> {
//   InquiriesCubit() : super(InquiriesInitial());
//
//
//   void fetchInquiries({required String token}) async {
//     emit(InquiriesLoading());
//
//     try {
//       final response = await DioHelper.getData(
//         url: '/inquiries',
//         token: token,
//       );
//
//       final List<Inquiry> inquiries = (response.data as List)
//           .map((item) => Inquiry.fromJson(item))
//           .toList();
//       print("............................................jjjjjjjjjjjjjjjjjuuuuuuuuuuuuuuuuuuuuuuu");
//       emit(InquiriesLoaded(inquiries: inquiries));
//     } catch (e) {
//       print("............................................jjjjjjjjjjjjjjjjj");
//       emit(InquiriesError(message: e.toString()));
//     }
//   }
//
//
// }
import 'package:bloc/bloc.dart';

import '../../../model/InquiryModel.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'HomeState.dart';
class InquiriesCubit extends Cubit<InquiriesState> {
  InquiriesCubit() : super(InquiriesInitial());

  List<Inquiry> allInquiries = [];
  List<Inquiry> filteredInquiries = [];

  void fetchInquiries({required String token}) async {
    emit(InquiriesLoading());
    try {
      final response = await DioHelper.getData(
        url: '/inquiries',
        token: token,
      );

      allInquiries = (response.data as List)
          .map((json) => Inquiry.fromJson(json))
          .toList();

      filteredInquiries = List.from(allInquiries);
      emit(InquiriesLoaded(inquiries: filteredInquiries));
    } catch (e) {
      emit(InquiriesError(message: e.toString()));
    }
  }

  void filterInquiries(String filter) {
    if (filter == 'All') {
      filteredInquiries = List.from(allInquiries);
    } else {
      filteredInquiries = allInquiries
          .where((inquiry) => inquiry.status.toLowerCase() == filter.toLowerCase())
          .toList();
    }
    emit(InquiriesLoaded(inquiries: filteredInquiries));
  }

}
