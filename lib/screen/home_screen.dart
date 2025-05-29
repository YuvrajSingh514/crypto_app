import 'package:crypto_app/screen/favourites_screen.dart';
import 'package:crypto_app/screen/market_list.dart';
import 'package:crypto_app/widgets/theme_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController viewController;

  @override
  void initState() {
    super.initState();
    viewController = TabController(length: 2, vsync: this);
  }

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

              SizedBox(height: 10),

              TabBar(
                controller: viewController,
                tabs: [
                  Tab(child: Text('Market')),
                  Tab(child: Text('Favourites')),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  controller: viewController,
                  children: [MarketList(), FavouritesScreen()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
