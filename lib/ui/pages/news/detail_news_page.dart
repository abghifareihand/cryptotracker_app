import 'package:cryptotracker_app/models/news_model.dart';
import 'package:cryptotracker_app/shared/theme.dart';
import 'package:flutter/material.dart';

class DetailNewsPage extends StatelessWidget {
  final Data news;
  const DetailNewsPage({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      news.thumb_2x ?? 'https://via.placeholder.com/150',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 300,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news.title ?? '',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            'Description :',
                            style: blackTextStyle.copyWith(
                              fontWeight: semiBold,
                            ),
                          ),
                          Text(
                            news.description ?? '',
                            style: blackTextStyle.copyWith(
                              fontWeight: light,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          Text(
                            'Author :',
                            style: blackTextStyle.copyWith(
                              fontWeight: semiBold,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              news.author ?? 'Unknown',
                              overflow: TextOverflow.ellipsis,
                              style: blackTextStyle.copyWith(
                                fontWeight: light,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        vertical: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
