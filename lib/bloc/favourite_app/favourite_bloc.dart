import 'package:bloc/bloc.dart';
import 'package:blocapi/bloc/favourite_app/favourite_event.dart';
import 'package:blocapi/bloc/favourite_app/favourite_state.dart';
import 'package:blocapi/bloc/model/favourite_item_model.dart';
import 'package:blocapi/bloc/repository/favourit_repository.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteItemState> {
  FavouriteRepository favouriteRepository;

  List<FavouriteItemModel> favouriteList = [];
  List<FavouriteItemModel> temFavouriteList = [];

  FavouriteBloc(this.favouriteRepository) : super(const FavouriteItemState()) {
    on<FetchFavouriteList>(_fetchList);
    on<Favouriteitem>(_addFavouriteItem);
    on<Selectitem>(_selectItem);
    on<UnSelectitem>(_unselectItem);
    on<DeleteItem>(_deleteItem);
  }

  void _fetchList(event, emit) async {
    favouriteList = await favouriteRepository.fetchItem();
    emit(state.copyWith(
        favouriteItemList: List.from(favouriteList),
        listStatus: ListStatus.sucess));
  }

  void _addFavouriteItem(
      Favouriteitem event, Emitter<FavouriteItemState> emit) async {
    final index =
        favouriteList.indexWhere((element) => element.id == event.item.id);
    if (event.item.isFavourite) {
      if (temFavouriteList.contains(favouriteList[index])) {
        temFavouriteList.remove(favouriteList[index]);
        temFavouriteList.add(event.item);
      }
    } else {
      if (temFavouriteList.contains(favouriteList[index])) {
        temFavouriteList.remove(favouriteList[index]);
        temFavouriteList.add(event.item);
      }
    }
    favouriteList[index] = event.item;
    emit(state.copyWith(
        favouriteItemList: List.from(favouriteList),
        temFavouriteItemList: List.from(temFavouriteList)));
  }

  void _selectItem(event, emit) async {
    temFavouriteList.add(event.item);
    emit(state.copyWith(temFavouriteItemList: List.from(temFavouriteList)));
  }

  void _unselectItem(event, emit) async {
    temFavouriteList.remove(event.item);
    emit(state.copyWith(temFavouriteItemList: List.from(temFavouriteList)));
  }

  void _deleteItem(DeleteItem event, Emitter<FavouriteItemState> emit) async {
    print("Deleting items: ${state.temFavouriteItemList}");
    for (final item in state.temFavouriteItemList) {
      favouriteList.remove(item);
    }
    temFavouriteList.clear();

    emit(state.copyWith(
      favouriteItemList: List.from(favouriteList),
      temFavouriteItemList: List.from(temFavouriteList),
    ));
  }
}
