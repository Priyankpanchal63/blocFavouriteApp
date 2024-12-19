import '../model/favourite_item_model.dart';

enum ListStatus { loading, sucess, failure }

class FavouriteItemState {
  final List<FavouriteItemModel> favouriteItemList;
  final List<FavouriteItemModel> temFavouriteItemList;
  final ListStatus listStatus;

  const FavouriteItemState(
      {this.favouriteItemList = const [],
      this.temFavouriteItemList = const [],
      this.listStatus = ListStatus.loading});

  FavouriteItemState copyWith(
      {List<FavouriteItemModel>? favouriteItemList,
      List<FavouriteItemModel>? temFavouriteItemList,
      ListStatus? listStatus}) {
    return FavouriteItemState(
        favouriteItemList: favouriteItemList ?? this.favouriteItemList,
        temFavouriteItemList: temFavouriteItemList ?? this.temFavouriteItemList,
        listStatus: listStatus ?? this.listStatus);
  }
}
