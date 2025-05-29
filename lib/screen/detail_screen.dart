// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:crypto_app/models/crypto_data.dart';
import 'package:crypto_app/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail screen'),),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Consumer<MarketProvider>(
            builder: (context, marketProvider, child) {
              CryptoData cryptoById = marketProvider.fetchCryptoById(widget.id);
              return ListView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(cryptoById.image!),
                    ),
                    title: Text(
                      cryptoById.name! +
                          "(${cryptoById.symbol!.toUpperCase()}) ",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      '₹ ' + cryptoById.currentPrice!.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PriceChange(24H)',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          double priceChange = cryptoById.priceChange24h!;
                          double priceChangePercentage =
                              cryptoById.priceChangePercentage24h!;
                          if (priceChange < 0) {
                            //negative
                            return Text(
                              '${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(2)})',
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            );
                          } else {
                            //positive
                            return Text(
                              '+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(2)})',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Market Cap',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹ " + cryptoById.marketCap!.toStringAsFixed(2),
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Market Cap Rank',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "#" + cryptoById.marketCapRank!.toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'High 24h',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹ " + cryptoById.high24h!.toStringAsFixed(2),
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Low 24h',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹ " + cryptoById.low24h!.toStringAsFixed(2),
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Circulating Supply',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹ " + cryptoById.circulatingSupply!.toStringAsFixed(2),
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'All Time High',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹ " + cryptoById.ath!.toStringAsFixed(2),
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'All Time Low',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹ " + cryptoById.atl!.toStringAsFixed(2),
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
