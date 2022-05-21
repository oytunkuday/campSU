import 'package:flutter/material.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/styles.dart';

class Walkthrough extends StatefulWidget {
  const Walkthrough({Key? key}) : super(key: key);

  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  String word = 'Skip';
  int currentPage = 0;
  int lastPage = 3;

  List<String> title = [
    'Welcome',
    'Easily Get Stated',
    'Stay In Touch',
    'campSU'
  ];

  List<String> heading = [
    'campSU',
    'Sign Up Effortlessly',
    'News About Everything Going On About Your Friends and The Campus',
    'Everything Composed In a Single Application'
  ];

  List<String> image = [
    'https://www.happierhuman.com/wp-content/uploads/2019/03/Happiness-Podcasts-to-Listen-To.jpg',
    'https://images.squarespace-cdn.com/content/v1/50581344e4b093884eeaa66d/1384199536602-RB6FTJN05ZVLHHXJQ5OR/customize+button+small.jpg',
    'https://www.thealdennetwork.com/wp-content/uploads/sites/63/2020/04/Alden-blog-2-April-600x511.png',
    'https://cityofgood.sg/wp-content/uploads/2020/11/Success-3-scaled.jpg',
  ];

  List<String> caption = [
    'Get connected with the campus.',
    'Create and customize your profile...',
    'Everything about your friends and the campus.',
    'Become a part of the community, stay updated about the campus news!'
  ];

  void nextPage() {
    if (currentPage < lastPage) {
      setState(() {
        currentPage += 1;
        word = 'Prev';
      });
    } else if (currentPage == lastPage) {
      setState(() {
        Navigator.pushNamed(context, '/welcome');
      });
    }
  }

  void prevPage() {
    if (currentPage == 0) {
      setState(() {
        Navigator.pushNamed(context, '/welcome');
      });
    } else if (currentPage > 0) {
      setState(() {
        currentPage -= 1;
        if (currentPage == 0) {
          setState(() {
            word = 'Skip';
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.headColor,
        title: Text(
          title[currentPage].toUpperCase(),
          style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  heading[currentPage],
                  style: HeadingTextStyle,
                ),
              ),
            ),
            Container(
              height: 350,
              child: CircleAvatar(
                backgroundColor: AppColors.backgroundColor,
                radius: 175,
                child: ClipOval(
                  child: Image.network(
                    image[currentPage],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                caption[currentPage],
                style: HeadingTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                height: 100,
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: prevPage,
                      child: Text(
                        word,
                        style: kBoldLabelStyle,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${currentPage + 1}/${lastPage + 1}',
                      style: kBoldLabelStyle,
                    ),
                    Spacer(),
                    OutlinedButton(
                      onPressed: nextPage,
                      child: Text(
                        'Next',
                        style: kBoldLabelStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
