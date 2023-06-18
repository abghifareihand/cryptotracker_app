import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptotracker_app/shared/theme.dart';
import 'package:cryptotracker_app/ui/widgets/bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = user?.displayName ?? '';
  }

  Future<void> _updateProfile() async {
    try {
      // Update nama di Firebase Auth
      await user?.updateDisplayName(_nameController.text);

      // Update nama di Firestore
      FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        'name': _nameController.text,
      });

      Fluttertoast.showToast(
        msg: "Profile updated successfully",
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
      );

      await Future.delayed(Duration(seconds: 1));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavbar(),
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to update profile. Please try again.",
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF6F8FB),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: blackColor),
        title: Text(
          'Edit Profile',
          style: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
          ),
        ),
      ),
      backgroundColor: Color(0xffF6F8FB),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          SizedBox(
            height: 30,
          ),
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryNavbarColor,
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(child: Text('Data not found'));
              }

              Map<String, dynamic>? userData =
                  snapshot.data!.data() as Map<String, dynamic>?;

              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: "${userData?['name'] ?? ''}",
                            hintStyle: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: "${userData?['email'] ?? ''}",
                            hintStyle: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: "${userData?['phone'] ?? ''}",
                            hintStyle: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _updateProfile,
                        child: Text(
                          'Update Profile',
                          style: whiteTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 16,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: primaryNavbarColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(56),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
