

import '../../../model/FavouriteModel.dart';

abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  final List<Favourite> favourites;
  FavouriteLoaded(this.favourites);
}

class FavouriteError extends FavouriteState {
  final String message;
  FavouriteError(this.message);
}
