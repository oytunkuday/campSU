import 'package:campsu/notifications/notificationPage.dart';
import 'package:campsu/pages/upload_page.dart';
import 'package:flutter/material.dart';
import "package:campsu/pages/chat_page.dart";
import 'package:campsu/pages/home_page.dart';
import 'package:campsu/pages/profile_page.dart';
import 'package:campsu/pages/saved_page.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/pages/searchpage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key, this.analytics, this.observer}) : super(key: key);
  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;
  @override
  _RootAppState createState() => _RootAppState();

  static const String routeName = '/rootapp';
}

class _RootAppState extends State<RootApp> {
  int activeTab = 0;
  String _message = '';
  void setMessage(String msg) {
    setState(() {
      _message = msg;
    });
  }

  Future<void> _setCurrentScreen() async {
    await widget.analytics?.setCurrentScreen(
      screenName: 'HomePage',
      screenClassOverride: 'root_app',
    );
  }

  Future<void> _setCurrentScreen1() async {
    await widget.analytics?.setCurrentScreen(
      screenName: 'Notifications',
      screenClassOverride: 'Notif_page',
    );
  }

  Future<void> _setCurrentScreen2() async {
    await widget.analytics?.setCurrentScreen(
      screenName: 'SearchPage',
      screenClassOverride: 'Search_app',
    );
  }

  Future<void> _setCurrentScreen3() async {
    await widget.analytics?.setCurrentScreen(
      screenName: 'ProfilePage',
      screenClassOverride: 'profile_app',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getFooter(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: getFloatingButton(),
      body: getBody(),
    );
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        ?.logEvent(name: 'CS310_Test', parameters: <String, dynamic>{
      'string': 'string',
      'int': 310,
      'long': 1234567890123,
      'double': 310.202002,
      'bool': true,
    });
    setMessage('Custom event log succeeded');
  }

  Widget getBody() {
    return IndexedStack(
      index: activeTab,
      children: [
        HomePage(),
        searchScreen(),
        Upload(),
        /*
          class _MyAppState extends State<MyApp> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_image!.path);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
    try {
      await firebaseStorageRef.putFile(File(_image!.path));
      print("Upload complete");
      setState(() {
        _image = null;
      });
    } on FirebaseException catch(e) {
      print('ERROR: ${e.code} - ${e.message}');
    } catch (e) {
      print(e.toString());
    }
  }
*/

        NotificationPage(),
        //ChatPage(),
        ProfilePage()
      ],
    );
  }

  Widget getFooter() {
    return Container(
      width: double.infinity,
      height: 59,
      decoration: BoxDecoration(
        color: AppColors.headColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      activeTab = 0;
                      _setCurrentScreen();
                    });
                  },
                  child: Icon(
                    Icons.home,
                    size: 35,
                    color: activeTab == 0 ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  width: 55,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      activeTab = 1;
                      _setCurrentScreen2();
                    });
                  },
                  child: Icon(
                    Icons.search,
                    size: 35,
                    color: activeTab == 1 ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      activeTab = 3;
                      _setCurrentScreen1();
                    });
                  },
                  child: Icon(
                    Icons.notifications,
                    size: 35,
                    color: activeTab == 3 ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  width: 55,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      activeTab = 4;
                      _setCurrentScreen3();
                    });
                  },
                  child: Icon(
                    Icons.person,
                    size: 35,
                    color: activeTab == 4 ? Colors.white : Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getFloatingButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          activeTab = 2;
        });
      },
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 15,
              offset: Offset(0, 1)),
        ], color: Colors.black, borderRadius: BorderRadius.circular(23)),
        child: Center(
          child: Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 26,
          ),
        ),
      ),
    );
  }
}
