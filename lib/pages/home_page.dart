import 'package:flutter/material.dart';
import 'package:campsu/data/post_json.dart';
import 'package:campsu/data/user_json.dart';
import 'package:campsu/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(60)),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Social UI KIT",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_a_photo,
                  color: Colors.black,
                  size: 25,
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
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Feed",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                // story profile
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [
                              Color(0xFFFFE0DF),
                              Color(0xFFE1F6F4)
                            ])),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 28,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: List.generate(usersList.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(usersList[index]['img']),
                                      fit: BoxFit.cover)),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                )
              ],
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
                                image:
                                    NetworkImage(postsList[index]['postImg']),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                          width: double.infinity,
                          height: 288,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withOpacity(0.25))),
                      Container(
                        width: double.infinity,
                        height: 288,
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
                                    Icons.add_a_photo,
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
                                        color:
                                            Color(0xFFE5E5E5).withOpacity(0.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
                                          color: Colors.white,
                                          size: 14,
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
                                        color:
                                            Color(0xFFE5E5E5).withOpacity(0.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
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
                                        color:
                                            Color(0xFFE5E5E5).withOpacity(0.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
                                          color: Colors.white,
                                          size: 14,
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
