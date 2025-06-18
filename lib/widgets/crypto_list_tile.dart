import 'package:crypto_app/models/crypto_data.dart';
import 'package:crypto_app/providers/market_provider.dart';
import 'package:crypto_app/screen/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoListTile extends StatelessWidget {
  

  final CryptoData currentCrypto;

  const CryptoListTile({super.key, required this.currentCrypto});

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider = Provider.of<MarketProvider>(
      context,
      listen: false,
    );
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(id: currentCrypto.id!),
          ),
        );
      },
      contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(currentCrypto.image ?? ''),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(currentCrypto.name!, overflow: TextOverflow.ellipsis),
          ),
          SizedBox(width: 10),

          //if else on gesture detector
          (currentCrypto.isFavourite == false)
              ? GestureDetector(
                onTap: () {
                  marketProvider.addFavorites(currentCrypto);
                },
                child: Icon(CupertinoIcons.heart, size: 22),
              )
              : GestureDetector(
                onTap: () {
                  marketProvider.removeFavorites(currentCrypto);
                },
                child: Icon(
                  CupertinoIcons.heart_fill,
                  size: 22,
                  color: Colors.red,
                ),
              ),
        ],
      ),
      subtitle: Text(currentCrypto.symbol!.toUpperCase()),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,

        children: [
          Text(
            // ignore: prefer_interpolation_to_compose_strings
            '₹ ' + currentCrypto.currentPrice!.toStringAsFixed(2),
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Builder(
            builder: (context) {
              double priceChange = currentCrypto.priceChange24h!;
              double priceChangePercentage =
                  currentCrypto.priceChangePercentage24h!;
              if (priceChange < 0) {
                //negative
                return Text(
                  '${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(2)})',
                  style: TextStyle(fontSize: 13, color: Colors.red),
                );
              } else {
                //positive
                return Text(
                  '+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(2)})',
                  style: TextStyle(fontSize: 13, color: Colors.green),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
