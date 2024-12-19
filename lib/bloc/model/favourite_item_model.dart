class FavouriteItemModel {
  final String id;
  final String value;
  final bool isDeleting;
  final bool isFavourite;

  const FavouriteItemModel({
    required this.id,
    required this.value,
    this.isDeleting = false,
    this.isFavourite = false,
  });

  FavouriteItemModel copyWith(
      {String? id, String? value, bool? isDeleting, bool? isFavurite}) {
    return FavouriteItemModel(
        id: id ?? this.id,
        value: value ?? this.value,
        isDeleting: isDeleting ?? this.isDeleting,
        isFavourite: isFavurite ?? this.isFavourite);
  }
}
