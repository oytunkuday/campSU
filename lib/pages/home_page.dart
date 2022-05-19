import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campsu/data/post_json.dart';
import 'package:campsu/data/user_json.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(60)),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.headColor,
      title: Padding(
        padding: const EdgeInsets.only(left: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "CampSU",
              style: HeadingTextStyleBlack,
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.message_outlined,
                  color: Colors.black,
                  size: 32,
                ))
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: List.generate(postsList.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 332,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 15,
                                offset: Offset(0, 1))
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 332,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 48, color: AppColors.postColor)),
                      ),
                      Container(
                        width: double.infinity,
                        height: 288,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 15,
                                offset: Offset(0, 1))
                          ],
                          image: DecorationImage(
                              image: NetworkImage(postsList[index]['postImg']),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 339,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            postsList[index]['img']),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            postsList[index]['name'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            postsList[index]['time'],
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white
                                                    .withOpacity(0.8)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Icon(
                                    Icons.share,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(27),
                                        color: Colors.grey.withOpacity(0.35)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          CupertinoIcons.heart,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        Text(
                                          postsList[index]['like'],
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(27),
                                        color: Colors.grey.withOpacity(0.35)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.comment_outlined,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        Text(
                                          postsList[index]['comment'],
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(27),
                                        color: Colors.grey.withOpacity(0.35)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.save_alt_rounded,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        Text(
                                          postsList[index]['share'],
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
