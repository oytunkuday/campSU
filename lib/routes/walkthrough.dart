import 'package:flutter/material.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/dimensions.dart';
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

  List<String> title = ['Welcome', 'ready to start', 'campSU'];

  List<String> heading = [];

  List<String> image = [];

  List<String> caption = [];

  void nextPage() {
    if (currentPage < lastPage) {
      setState(() {
        currentPage += 1;
        word = 'Previous';
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
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          title[currentPage].toUpperCase(),
          style: HeadingTextStyle,
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
                backgroundImage: AssetImage(image[currentPage]),
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
                        style: TextStyle(
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${currentPage + 1}/${lastPage + 1}',
                      style: TextStyle(
                        color: AppColors.textColor,
                      ),
                    ),
                    Spacer(),
                    OutlinedButton(
                      onPressed: nextPage,
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: AppColors.textColor,
                        ),
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
