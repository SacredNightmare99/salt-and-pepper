import 'package:flutter/material.dart';
import 'package:salt_and_pepper/screens/profile_creation_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const bg = Color(0xFFFDF8F2);
  static const primary = Color(0xFFE94A35);
  static const accentYellow = Color(0xFFFFCC00);
  static const black = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LOGO
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(width: 4, color: black),
                  ),
                  child: const Icon(
                    Icons.soup_kitchen,
                    color: primary,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 24),

                // TITLE
                const Text(
                  'Welcome to the Kitchen 👋',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                    color: black,
                  ),
                ),

                const SizedBox(height: 16),

                // SUBTITLE
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(text: 'AI-powered recipes, '),
                      TextSpan(
                        text: 'zero fluff.',
                        style: TextStyle(
                          backgroundColor: accentYellow,
                          fontWeight: FontWeight.w900,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // GOOGLE LOGIN (DEMO NAVIGATION)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 4, color: black),
                      backgroundColor: Colors.white,
                    ),
                    icon: const Icon(
                      Icons.g_mobiledata,
                      size: 36,
                      color: Colors.deepOrange,
                    ),
                    label: const Text(
                      'Continue with Google',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: black,
                      ),
                    ),
                    onPressed: () {
                      // 🔥 DEMO NAVIGATION
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ChefProfileScreen(),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // OR DIVIDER
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 4, color: black)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: black,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(thickness: 4, color: black)),
                  ],
                ),

                const SizedBox(height: 24),

                // EMAIL LOGIN
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      elevation: 0,
                      side: const BorderSide(width: 4, color: black),
                    ),
                    icon: const Icon(Icons.mail, color: Colors.white),
                    label: const Text(
                      'Continue with Email',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      // TODO: email auth later
                    },
                  ),
                ),

                const SizedBox(height: 32),

                // FOOTER
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: black,
                    ),
                    children: [
                      TextSpan(text: 'New chef? '),
                      TextSpan(
                        text: 'Create an account',
                        style: TextStyle(
                          color: primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
