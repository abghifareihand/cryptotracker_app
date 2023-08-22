import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptotracker_app/shared/theme.dart';
import 'package:cryptotracker_app/ui/pages/account/edit_profile_page.dart';
import 'package:cryptotracker_app/ui/pages/account/widgets/dialog_info.dart';
import 'package:cryptotracker_app/ui/pages/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  //String? _imageUrl;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadUserPhoto();
  // }

  // void _loadUserPhoto() async {
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   Reference ref =
  //       FirebaseStorage.instance.ref().child('photo_profile/$uid/profile.jpg');
  //   try {
  //     String? url = await ref.getDownloadURL();
  //     setState(() {
  //       _imageUrl = url;
  //     });
  //   } catch (e) {
  //     print('Foto tidak ditemukan');
  //     setState(() {
  //       _imageUrl = null;
  //     });
  //   }
  // }

  // void _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.getImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     String uid = FirebaseAuth.instance.currentUser!.uid;
  //     Reference ref = FirebaseStorage.instance
  //         .ref()
  //         .child('photo_profile/$uid/profile.jpg');
  //     await ref.putFile(File(pickedImage.path));
  //     _loadUserPhoto();
  //   }
  // }

  Future<void> _logoutUser() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confirmation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 16),
                Text('Are you sure you want to logout?'),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Menutup dialog
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: whiteColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: primaryNavbarColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'No',
                        style: TextStyle(
                          color: primaryNavbarColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('isLoggedIn', false);

                        await FirebaseAuth.instance.signOut();

                        Fluttertoast.showToast(
                          msg: "Logout Successful",
                          gravity: ToastGravity.TOP,
                          backgroundColor: Colors.red,
                        );
                        await Future.delayed(Duration(seconds: 1));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryNavbarColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Yes'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogInfo(
          title: 'Settings',
          content:
              'Coming soon',
        );
      },
    );
  }

  void _showHelpSupportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogInfo(
          title: 'Help and Support',
          content:
              'Coming soon',
        );
      },
    );
  }

  void _showPrivacyPolicyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogInfo(
          title: 'Privacy Policy',
          content:
              'Coming soon',
        );
      },
    );
  }

  void _showAboutAppDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogInfo(
          title: 'About App',
          content:
              'Coming soon',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF6F8FB),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: blackColor),
        title: Text(
          'Account',
          style: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String name = snapshot.data!.get('name');
                  String email = snapshot.data!.get('email');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        child: Stack(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/avatar.png'),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryNavbarColor,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        name,
                        style: blackTextStyle.copyWith(
                          fontSize: 22,
                          fontWeight: bold,
                        ),
                      ),
                      Text(
                        email,
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.person_2_rounded,
                        color: blackColor,
                      ),
                      title: Text(
                        'Edit Profile',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: blackColor,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: blackColor,
                      ),
                      title: Text(
                        'Settings',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: blackColor,
                      ),
                      onTap: _showSettingsDialog,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.support_agent_outlined,
                        color: blackColor,
                      ),
                      title: Text(
                        'Help and Support',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: blackColor,
                      ),
                      onTap: _showHelpSupportDialog,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.privacy_tip_outlined,
                        color: blackColor,
                      ),
                      title: Text(
                        'Privacy Policy',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: blackColor,
                      ),
                      onTap: _showPrivacyPolicyDialog,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.perm_device_information_outlined,
                        color: blackColor,
                      ),
                      title: Text(
                        'About App',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: blackColor,
                      ),
                      onTap: _showAboutAppDialog,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.logout_rounded,
                        color: blackColor,
                      ),
                      title: Text(
                        'Logout',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: blackColor,
                      ),
                      onTap: _logoutUser,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
