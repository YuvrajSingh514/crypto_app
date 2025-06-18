import 'package:crypto_app/models/crypto_data.dart';
import 'package:crypto_app/providers/market_provider.dart';

import 'package:crypto_app/widgets/crypto_list_tile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketList extends StatefulWidget {
  const MarketList({super.key});

  @override
  State<MarketList> createState() => _MarketListState();
}

class _MarketListState extends State<MarketList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading == true) {
          return Center(child: CircularProgressIndicator());
          // ignore: prefer_is_empty
        } else if (marketProvider.marketList.length > 0) {
          return RefreshIndicator(
            onRefresh: () async {
              await marketProvider.fetchData();
            },
            child: ListView.builder(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),

              itemCount: marketProvider.marketList.length,
              itemBuilder: (context, index) {
                CryptoData currentCrypto = marketProvider.marketList[index];

                return CryptoListTile(currentCrypto: currentCrypto);
              },
            ),
          );
        } else {
          return Text('Data Not Found');
        }
      },
    );
  }
}
