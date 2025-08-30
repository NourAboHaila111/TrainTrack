import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'SearchState.cubit.dart';
import '../../../model/InquiryModel.dart';
import '../../../shared/network/remote/dio_helper.dart';

class SearchInquiryCubit extends Cubit<SearchInquiryState> {
  SearchInquiryCubit() : super(SearchInquiryInitial());

  void searchInquiries({
    required String query,
    required String token,
  }) async {
    emit(SearchInquiryLoading());

    try {
      final response = await DioHelper.getData(
        url: '/inquiries/search',
        token: token,
        query: {'query': query},
      );

      final List data = response.data;
      final inquiries = data.map((e) => Inquiry.fromJson(e)).toList();

      emit(SearchInquirySuccess(inquiries));
    } catch (e) {
      print("Failure..................... ${e.toString()}");
      emit(SearchInquiryFailure('Failure ${e.toString()}'));
    }
  }
}
