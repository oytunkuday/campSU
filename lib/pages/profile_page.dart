// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:campsu/data/me_post_json.dart';
import 'package:campsu/utils/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:campsu/routes/editProfile.dart';
import 'package:campsu/routes/settingsProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isPhoto = true;

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(meVideoList[0]['videoUrl']);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180), child: getAppBar()),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
        elevation: 2,
        backgroundColor: AppColors.headColor,
        flexibleSpace: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [SizedBox(height: 6)],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              SizedBox(width: 1),
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.black)),
                child: Center(
                  child: Container(
                    width: 73,
                    height: 73,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                            image: NetworkImage(
                                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
              Column(
                children: const [
                  Text(
                    "Posts",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "35",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "Friends",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "1,552",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsProfile()));
                        ;
                      },
                      icon: Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 32,
                      ))
                ],
              )
            ]),
            const SizedBox(
              height: 8,
            ),
            const Text(
              " Admin Bugsızkod",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(children: [
              const Text(
                " @noBugs",
                style: TextStyle(fontSize: 15, height: 1),
              ),
              SizedBox(width: 244),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
                  ;
                },
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    textStyle: TextStyle(height: 1)),
                child: const Text('Edit Profile'),
              )
            ]),
            const Text(
              " Software Engineer at Sabanci University",
              style: TextStyle(fontSize: 15),
            ),
          ],
        )));
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 254, 202, 134),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    color: const Color.fromARGB(255, 254, 202, 134),
                    textColor: Colors.black,
                    onPressed: () {
                      setState(() {
                        isPhoto = true;
                      });
                    },
                    child: const Text(
                      'All Posts',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  FlatButton(
                    color: const Color.fromARGB(255, 254, 202, 134),
                    textColor: Colors.black,
                    onPressed: () {
                      setState(() {
                        isPhoto = false;
                      });
                    },
                    child: const Text(
                      'Videos',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  FlatButton(
                    color: const Color.fromARGB(255, 254, 202, 134),
                    textColor: Colors.black,
                    onPressed: () {
                      setState(() {
                        isPhoto = true;
                      });
                    },
                    child: const Text(
                      'Reposts',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ]),
          ),
          const SizedBox(
            height: 30,
          ),
          isPhoto
              ? Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: List.generate(mePostList.length, (index) {
                    return Container(
                      width: (size.width - 60) / 2,
                      height: (size.width - 60) / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(mePostList[index]),
                              fit: BoxFit.cover)),
                    );
                  }),
                )
              : Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: List.generate(meVideoList.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        playVideo(context, meVideoList[index]['videoUrl']);
                      },
                      child: Container(
                        width: (size.width - 60) / 2,
                        height: (size.width - 60) / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: NetworkImage(meVideoList[index]['img']),
                                fit: BoxFit.cover)),
                        child: const Center(
                          child: Icon(
                            Icons.play_arrow,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
                )
        ],
      ),
    );
  }

  playVideo(BuildContext context, videoUrl) {
    _controller = VideoPlayerController.network(videoUrl);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )));
  }
}
