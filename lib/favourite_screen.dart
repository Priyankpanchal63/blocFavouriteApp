import 'package:blocapi/bloc/favourite_app/favourite_bloc.dart';
import 'package:blocapi/bloc/favourite_app/favourite_event.dart';
import 'package:blocapi/bloc/favourite_app/favourite_state.dart';
import 'package:blocapi/bloc/model/favourite_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FavouriteBloc>().add(FetchFavouriteList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite App'),
        actions: [
          BlocBuilder<FavouriteBloc, FavouriteItemState>(
              builder: (context, state) {
            return Visibility(
              visible: state.temFavouriteItemList.isNotEmpty?true:false,
              child: IconButton(
                  onPressed: () {
                    context.read<FavouriteBloc>().add(DeleteItem());
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            );
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: BlocBuilder<FavouriteBloc, FavouriteItemState>(
            builder: (context, state) {
          switch (state.listStatus) {
            case ListStatus.loading:
              return Center(child: CircularProgressIndicator());

            case ListStatus.sucess:
              return ListView.builder(
                  itemCount: state.favouriteItemList.length,
                  itemBuilder: (context, index) {
                    final item = state.favouriteItemList[index];
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                            value: state.temFavouriteItemList.contains(item)?true:false,
                            onChanged: (value) {
                              if (value!) {
                                context
                                    .read<FavouriteBloc>()
                                    .add(Selectitem(item: item));
                              } else {
                                context
                                    .read<FavouriteBloc>()
                                    .add(UnSelectitem(item: item));
                              }
                            }),
                        title: Text(item.value.toString()),
                        trailing: IconButton(
                            onPressed: () {
                              FavouriteItemModel itemModel = FavouriteItemModel(
                                  id: item.id,
                                  value: item.value,
                                  isFavourite: item.isFavourite ? false : true);
                              context
                                  .read<FavouriteBloc>()
                                  .add(Favouriteitem(item: itemModel));
                            },
                            icon: Icon(item.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border_outlined)),
                      ),
                    );
                  });

            case ListStatus.failure:
              return Text("Somthing went wrong");
          }
        }),
      ),
    );
  }
}
