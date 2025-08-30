import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/FavouriteModel.dart';
import '../../../shared/network/local/Cach_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'FavouriteState.dart';


class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  List<Favourite> favourites = [];

  /// Get all favourites from API
  Future<void> getFavourites() async {
    emit(FavouriteLoading());
    try {
      final token = CachHelper.getData(key: "token");
      final response = await DioHelper.getData(
        url: "/myFavourites",
        token: token,
      );

      final data = response.data as List;
      favourites = data.map((e) => Favourite.fromJson(e)).toList();

      emit(FavouriteLoaded(favourites));
    } catch (e) {
      emit(FavouriteError("Failed to load favourites: $e"));
    }
  }

  /// Add inquiry to favourites
  Future<void> addToFavourite(int inquiryId) async {
    try {
      final token = CachHelper.getData(key: "token");
      await DioHelper.postData(
        url: "/favourites",
        data: {"inquiry_id": inquiryId},
        token: token,
      );
      await getFavourites();
    } catch (e) {
      emit(FavouriteError("Failed to add favourite: $e"));
    }
  }

  /// Remove from favourites
  Future<void> removeFromFavourite(int favId) async {
    try {
      final token = CachHelper.getData(key: "token");
      await DioHelper.deleteData(
        url: "/favourites/$favId",
        token: token,
      );
      await getFavourites();
    } catch (e) {
      emit(FavouriteError("Failed to remove favourite: $e"));
    }
  }

  /// check if inquiry is in favourites
  bool isFavourite(int inquiryId) {
    return favourites.any((f) => f.inquiryId == inquiryId);
  }
}
