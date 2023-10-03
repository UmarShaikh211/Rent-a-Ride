import 'package:flutter/material.dart';
import 'package:rentcartest/host/hlogin.dart';

class NewProfile extends StatefulWidget {
  const NewProfile({super.key});

  @override
  State<NewProfile> createState() => _NewProfileState();
}

class _NewProfileState extends State<NewProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Profile", style: TextStyle(color: Colors.black)),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 70,
                backgroundColor:
                    Colors.black, // Replace with your profile image
              ),
            ),
            ProfileCard(
              icon: Icons.person,
              title: 'My Account',
              onTap: () {
                // Handle My Account tap
              },
            ),
            ProfileCard(
              icon: Icons.ac_unit_outlined,
              title: 'Become a Host',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HostLogin()));
              },
            ),
            ProfileCard(
              icon: Icons.info,
              title: 'Terms & Conditions',
              onTap: () {
                // Handle Terms & Conditions tap
              },
            ),
            ProfileCard(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                // Handle Logout tap
              },
            ),
          ],
        ));
  }
}

class ProfileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  ProfileCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        color: Colors.deepPurple,
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: Icon(
            icon,
            color: Theme.of(context).primaryColor, // Customize the icon color
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
