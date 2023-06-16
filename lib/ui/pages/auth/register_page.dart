import 'package:cryptotracker_app/providers/auth_provider.dart';
import 'package:cryptotracker_app/shared/theme.dart';
import 'package:cryptotracker_app/ui/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController hobbyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          Container(
            width: 314,
            height: 54,
            margin: const EdgeInsets.only(
              top: 100,
              bottom: 100,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/logo_splash.png',
                ),
              ),
            ),
          ),
          Text(
            'Register &\nGrow Your Finance',
            style: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //NOTE: FULLNAME INPUT
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name',
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
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
                // NOTE: EMAIL INPUT
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Address',
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
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
                // NOTE: PASS INPUT
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
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
                      'Hobby',
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: hobbyController,
                      decoration: InputDecoration(
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

                SizedBox(
                  height: 30,
                ),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return Container(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          bool registered = await authProvider.register(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                            hobbyController.text,
                          );
                          if (registered) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Registration successful!'),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavbar()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Registration failed. Please try again.'),
                              ),
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: primaryNavbarColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(56),
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: blackTextStyle.copyWith(),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Login',
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
