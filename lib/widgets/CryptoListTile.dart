import 'package:crypto/models/cryptocurrency.dart';
import 'package:crypto/pages/detailspage.dart';
import 'package:crypto/providers/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoListTile extends StatelessWidget {
  final CryptoCurrency currentCrypto;

  const CryptoListTile({Key? key, required this.currentCrypto})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              id: currentCrypto.id!,
            ),
          ),
        );
      },
      contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentCrypto.image!),
      ),
      title: Row(
        children: [
          Flexible(
              child: Text(
            currentCrypto.name!,
            overflow: TextOverflow.ellipsis,
          )),
          const SizedBox(
            width: 10,
          ),
          (currentCrypto.isFavorite == false)
              ? GestureDetector(
                  onTap: () {
                    marketProvider.addFavourite(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.heart,
                    size: 25,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    marketProvider.removeFavourite(currentCrypto);
                  },
                  child:const Icon(
                    CupertinoIcons.heart_fill,
                    size: 25,
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
            "₹ " + currentCrypto.currentPrice!.toStringAsFixed(4),
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
          Builder(
            builder: (context) {
              double priceChange = currentCrypto.priceChange24!;
              double priceChangePercentage =
                  currentCrypto.priceChangePercentage24!;

              if (priceChange < 0) {
                return Flexible(
                  child: Text(
                    "${priceChangePercentage.toStringAsFixed(4)}% (${priceChange.toStringAsFixed(4)})",
                    style: const TextStyle(color: Colors.red),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              } else {
                return Flexible(
                  child: Text(
                    "+${priceChangePercentage.toStringAsFixed(4)}% (+${priceChange.toStringAsFixed(4)})",
                    style:const TextStyle(color: Colors.green),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
