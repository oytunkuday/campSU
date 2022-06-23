import 'dart:io' show Platform;
import 'package:campsu/pages/profile_page.dart';
import 'package:campsu/routes/changeProfType.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campsu/utils/colors.dart';
import 'package:campsu/utils/dimensions.dart';
import 'package:campsu/utils/screenSizes.dart';
import 'package:campsu/utils/styles.dart';
import 'package:campsu/pages/root_app.dart';
import 'package:campsu/routes/welcome.dart';
import 'package:campsu/routes/changePass.dart';

class SettingsProfile extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();

  static const String routeName = '/settingsprofile';
}

class _settingsState extends State<SettingsProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Settings',
            style: kAppBarTitleTextStyle,
          ),
          backgroundColor: AppColors.headColor,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Padding(
            padding: Dimens.regularPadding,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 30),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePassword()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Change Password',
                        style: kButtonLightTextStyle,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.greyColor.withOpacity(0.8),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeProfType()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Account',
                        style: kButtonLightTextStyle,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.greyColor.withOpacity(0.8),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Privacy',
                        style: kButtonLightTextStyle,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.greyColor.withOpacity(0.8),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Notifications',
                        style: kButtonLightTextStyle,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.greyColor.withOpacity(0.8),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'About',
                        style: kButtonLightTextStyle,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.greyColor.withOpacity(0.8),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Report',
                        style: kButtonLightTextStyle,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.greyColor.withOpacity(0.8),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Security',
                        style: kButtonLightTextStyle,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.greyColor.withOpacity(0.8),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Welcome()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Log out',
                        style: kButtonLightTextStyle,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.greyColor.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 15)
                ],
              ),
            ),
          ),
        ));
  }
}
