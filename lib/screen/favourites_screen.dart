import 'package:crypto_app/models/crypto_data.dart';
import 'package:crypto_app/providers/market_provider.dart';
import 'package:crypto_app/widgets/crypto_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        List<CryptoData> favorites =
            marketProvider.marketList
                .where((element) => element.isFavourite == true)
                .toList();
        // ignore: prefer_is_empty
        if (favorites.length > 0) {
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              CryptoData currentCrypto = favorites[index];
              return CryptoListTile(currentCrypto: currentCrypto);
            },
          );
        } else {
          return Center(child: Text('No Favorites Yet'));
        }
      },
    );
  }
}
