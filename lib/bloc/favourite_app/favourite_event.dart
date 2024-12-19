import 'package:blocapi/bloc/model/favourite_item_model.dart';

abstract class FavouriteEvent{

}
class FetchFavouriteList extends FavouriteEvent{}

class Favouriteitem extends FavouriteEvent{
  final FavouriteItemModel item;
  Favouriteitem({required this.item});
}

class Selectitem extends FavouriteEvent{
  final FavouriteItemModel item;
  Selectitem({required this.item});
}


class UnSelectitem extends FavouriteEvent{
  final FavouriteItemModel item;
  UnSelectitem({required this.item});
}

class DeleteItem extends FavouriteEvent{}