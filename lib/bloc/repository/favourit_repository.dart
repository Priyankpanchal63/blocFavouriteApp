import 'package:blocapi/bloc/model/favourite_item_model.dart';

class FavouriteRepository {
  Future<List<FavouriteItemModel>> fetchItem() async {
    await Future.delayed(const Duration(seconds: 3));
    return List.of(_generateItem(5));
  }

  List<FavouriteItemModel> _generateItem(int length) {
    return List.generate(
        length,
        (index) =>
            FavouriteItemModel(id: index.toString(), value: 'Item $index'));
  }
}
