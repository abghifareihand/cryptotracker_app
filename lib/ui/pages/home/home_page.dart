import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptotracker_app/providers/coin_provider.dart';
import 'package:cryptotracker_app/shared/theme.dart';
import 'package:cryptotracker_app/ui/pages/home/widgets/coin_card.dart';
import 'package:cryptotracker_app/ui/pages/home/widgets/shimmer/coin_card_shimmer.dart';
import 'package:cryptotracker_app/ui/pages/home/widgets/coin_tile.dart';
import 'package:cryptotracker_app/ui/pages/home/widgets/shimmer/coin_tile_shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  //String? _imageUrl;

  @override
  void initState() {
    super.initState();
    // _getImageUrl();
    Provider.of<CoinProvider>(context, listen: false).getAllCoins();
  }

  Future<void> _refreshData() async {
    await Provider.of<CoinProvider>(context, listen: false)
      ..getAllCoins();
  }

  // void _getImageUrl() async {
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   Reference ref =
  //       FirebaseStorage.instance.ref().child('photo_profile/$uid/profile.jpg');
  //   try {
  //     String? url = await ref.getDownloadURL();
  //     setState(() {
  //       _imageUrl = url;
  //     });
  //   } catch (e) {
  //     print('Foto tidak ditemukan');
  //     setState(() {
  //       _imageUrl = null;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // HEADER
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 30,
              ),
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String name = snapshot.data!.get('name');
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Halo,",
                                style: greyTextStyle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                name,
                                style: blackTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: semiBold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/avatar.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),

            // COIN CARD
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                top: 40,
              ),
              child: Text(
                'Top 5 Coin',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),

            Container(
              height: 120,
              margin: const EdgeInsets.only(
                top: 14,
              ),
              child: Consumer<CoinProvider>(
                builder: (context, provider, child) {
                  final data = provider.coins;
                  if (provider.state == ResultState.loading) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return CoinCardShimmer();
                        },
                      ),
                    );
                  } else if (provider.state == ResultState.error) {
                    return Center(
                      child: Text('Data gagal diambil'),
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return CoinCard(coin: data[index]);
                      },
                    );
                  }
                },
              ),
            ),

            Container(
              margin: const EdgeInsets.only(
                left: 16,
                top: 24,
              ),
              child: Text(
                'All Coin',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),

            Consumer<CoinProvider>(
              builder: (context, provider, child) {
                final data = provider.coins;
                if (provider.state == ResultState.loading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return CoinTileShimmer();
                      },
                    ),
                  );
                } else if (provider.state == ResultState.error) {
                  return Center(
                    child: Text('Data gagal diambil'),
                  );
                } else {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return CoinTile(coin: data[index]);
                    },
                  );
                }
              },
            ),
            SizedBox(
              height: deviceHeight(context) * 0.15,
            ),
          ],
        ),
      ),
    );
  }
}
