import 'package:crypto_app/models/crypto_data.dart';
import 'package:crypto_app/providers/market_provider.dart';
import 'package:crypto_app/screen/detail_screen.dart';
import 'package:crypto_app/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Crypto Today',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  ThemeButton(),
                ],
              ),

              SizedBox(height: 20),

              Expanded(
                child: Consumer<MarketProvider>(
                  builder: (context, marketProvider, child) {
                    if (marketProvider.isLoading == true) {
                      return Center(child: CircularProgressIndicator());
                      // ignore: prefer_is_empty
                    } else if (marketProvider.marketList.length > 0) {
                      return RefreshIndicator(
                        onRefresh: () async{
                         await marketProvider.fetchData();
                        },
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),

                          itemCount: marketProvider.marketList.length,
                          itemBuilder: (context, index) {
                            CryptoData currentCrypto =
                                marketProvider.marketList[index];

                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            DetailScreen(id: currentCrypto.id!),
                                  ),
                                );
                              },
                              contentPadding: EdgeInsets.all(0),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  currentCrypto.image ?? '',
                                ),
                              ),
                              title: Text(currentCrypto.name ?? ''),
                              subtitle: Text(
                                currentCrypto.symbol!.toUpperCase(),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,

                                children: [
                                  Text(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    '₹ ' +
                                        currentCrypto.currentPrice!
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      double priceChange =
                                          currentCrypto.priceChange24h!;
                                      double priceChangePercentage =
                                          currentCrypto
                                              .priceChangePercentage24h!;
                                      if (priceChange < 0) {
                                        //negative
                                        return Text(
                                          '${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(2)})',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.red,
                                          ),
                                        );
                                      } else {
                                        //positive
                                        return Text(
                                          '+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(2)})',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.green,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Text('Data Not Found');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
