import 'package:flutter/material.dart';
import 'package:rentcartest/host/host_license.dart';

import '../../../host/hlogin.dart';
import '../../../host/host_login.dart';
import '../../../host/host_navbar.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
              text: "Host",
              icon: "assets/icons/User Icon.svg",
              press: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HostLogin())),
                  }),
          ProfileMenu(
            text: "Terms & Conditions",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
