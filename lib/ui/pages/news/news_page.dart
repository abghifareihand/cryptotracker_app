import 'package:cryptotracker_app/providers/news_provider.dart';
import 'package:cryptotracker_app/shared/theme.dart';
import 'package:cryptotracker_app/ui/pages/news/widgets/news_tile.dart';
import 'package:cryptotracker_app/ui/pages/news/widgets/shimmer/news_tile_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).getAllNews();
  }

  Future<void> _refreshData() async {
    await Provider.of<NewsProvider>(context, listen: false)
      ..getAllNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                top: 24,
              ),
              child: Text(
                'News About Coins',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
            Consumer<NewsProvider>(
              builder: (context, provider, child) {
                final data = provider.news;
                if (provider.state == ResultState.loading || data.isEmpty) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return NewsTileShimmer();
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
                      return NewsTile(news: data[index]);
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
