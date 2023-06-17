import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptotracker_app/shared/theme.dart';
import 'package:cryptotracker_app/ui/pages/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final _isLoading = ValueNotifier<bool>(false);

  Future<void> _logoutUser() async {
    _isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    await FirebaseAuth.instance.signOut();

    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Berhasil Logout'),
      ),
    );
    _isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryNavbarColor, // Atur latar belakang putih
        elevation: 0, // Atur elevasi ke 0 untuk menghilangkan bayangan
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Account',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: whiteColor, // Atur warna teks menjadi putih
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text('Data not found'));
                }

                Map<String, dynamic>? userData =
                    snapshot.data!.data() as Map<String, dynamic>?;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Data',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              'Name',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                            subtitle: Text(
                              "${userData?['name'] ?? ''}",
                              style: greyTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: light,
                              ),
                            ),
                            shape: Border(
                              bottom: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Email',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                            subtitle: Text(
                              "${userData?['email'] ?? ''}",
                              style: greyTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: light,
                              ),
                            ),
                            shape: Border(
                              bottom: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Phone',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                            subtitle: Text(
                              "${userData?['phone'] ?? ''}",
                              style: greyTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: light,
                              ),
                            ),
                            shape: Border(
                              bottom: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'About App',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(Icons.settings),
                            title: Text(
                              'Settings',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () {},
                            shape: Border(
                              bottom: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.book),
                            title: Text(
                              'Terms and Conditions',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () {},
                            shape: Border(
                              bottom: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.privacy_tip_outlined),
                            title: Text(
                              'Privacy Policy',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () {},
                            shape: Border(
                              bottom: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          ListTile(
                            leading:
                                Icon(Icons.perm_device_information_rounded),
                            title: Text(
                              'About',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () {},
                            shape: Border(
                              bottom: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isLoading,
                      builder: (context, value, child) {
                        return SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _logoutUser,
                            child: _isLoading.value
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: whiteColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Loading...',
                                        style: whiteTextStyle.copyWith(
                                          fontWeight: semiBold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  )
                                : Text(
                                    'Logout',
                                    style: whiteTextStyle.copyWith(
                                      fontWeight: semiBold,
                                      fontSize: 16,
                                    ),
                                  ),
                            style: TextButton.styleFrom(
                              backgroundColor: primaryNavbarColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
