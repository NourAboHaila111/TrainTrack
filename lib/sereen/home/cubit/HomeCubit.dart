//
// import 'package:bloc/bloc.dart';
//
// import '../../../model/InquiryModel.dart';
// import '../../../shared/network/remote/dio_helper.dart';
// import 'HomeState.dart';
// class InquiriesCubit extends Cubit<InquiriesState> {
//   InquiriesCubit() : super(InquiriesInitial());
//
//   List<Inquiry> allInquiries = [];
//   List<Inquiry> filteredInquiries = [];
//
//   void fetchInquiries({required String token}) async {
//     emit(InquiriesLoading());
//     try {
//       final response = await DioHelper.getData(
//         url: '/inquiries',
//         token: token,
//       );
//
//       allInquiries = (response.data as List)
//           .map((json) => Inquiry.fromJson(json))
//           .toList();
//
//       filteredInquiries = List.from(allInquiries);
//       emit(InquiriesLoaded(inquiries: filteredInquiries));
//     } catch (e) {
//       emit(InquiriesError(message: e.toString()));
//     }
//   }
//
//   void filterInquiries(String filter) {
//     if (filter == 'All') {
//       filteredInquiries = List.from(allInquiries);
//     } else {
//       filteredInquiries = allInquiries
//           .where((inquiry) => inquiry.status.toLowerCase() == filter.toLowerCase())
//           .toList();
//     }
//     emit(InquiriesLoaded(inquiries: filteredInquiries));
//   }
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
      print ("allInquiries.................................${allInquiries}");
    } catch (e) {
      emit(InquiriesError(message: e.toString()));
    }
  }

  void filterInquiries(String filter) {
    if (filter == 'All') {
      filteredInquiries = List.from(allInquiries);
    } else if (filter == 'Favorites') {
      filteredInquiries =
          allInquiries.where((inquiry) => inquiry.isFavourite).toList();
    } else {
      filteredInquiries = allInquiries
          .where((inquiry) =>
      inquiry.statusName.toLowerCase() == filter.toLowerCase())
          .toList();
    }
    emit(InquiriesLoaded(inquiries: filteredInquiries));
    print("Filtered inquiries (${filter}):");
    for (var inquiry in filteredInquiries) {
      print("ID: ${inquiry.id}, Title: ${inquiry.title}, Status: ${inquiry.statusName}, isFavourite: ${inquiry.isFavourite}");
    }

  }

  void toggleFavorite(int id) {
    final inquiry = allInquiries.firstWhere((inq) => inq.id == id);
    inquiry.isFavourite = !inquiry.isFavourite;

    emit(InquiriesLoaded(inquiries: filteredInquiries));
  }
}
