import 'package:cryptotracker_app/models/news_model.dart';
import 'package:cryptotracker_app/shared/theme.dart';
import 'package:cryptotracker_app/ui/pages/news/detail_news_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsTile extends StatelessWidget {
  final Data news;
  const NewsTile({
    Key? key,
    required this.news,
  }) : super(key: key);

  // void _launchURL(String url) async {
  //   final uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //     print('clicked');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailNewsPage(
                  news: news,
                ),
              ),
            );
          },
          // onLongPress: () {
          //   _launchURL(news.url!);
          // },
          child: Container(
            margin: const EdgeInsets.only(
              top: 16,
              right: 16,
              left: 16,
            ),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(
                        news.thumb_2x ?? 'https://via.placeholder.com/150',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.title ?? 'No Title',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        news.updated_at != null
                            ? _convertTimestampToFormattedDate(news.updated_at!)
                            : 'No Date',
                        style: greyTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: light,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _convertTimestampToFormattedDate(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
    return formattedDate;
  }
}
