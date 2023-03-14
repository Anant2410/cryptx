import 'package:crypto/models/cryptocurrency.dart';
import 'package:crypto/providers/market_provider.dart';
import 'package:crypto/widgets/CryptoListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        List<CryptoCurrency> favourites = marketProvider.markets
            .where((element) => element.isFavorite == true)
            .toList();
        if (favourites.length > 0) {
          return ListView.builder(
            itemCount: favourites.length,
            itemBuilder: (context, index) {
              CryptoCurrency currentCrypto = favourites[index];
              return CryptoListTile(currentCrypto: currentCrypto);
            },
          );
        } else {
          return const Center(
            child: Text(
              "No favourites yet",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 25,
              ),
            ),
          );
        }
      },
    );
  }
}
