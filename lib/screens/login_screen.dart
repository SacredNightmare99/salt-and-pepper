import 'package:flutter/material.dart';

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
        child: Stack(
          children: [
            // Background decorations
            Positioned(
              top: 40,
              left: -20,
              child: Opacity(
                opacity: 0.2,
                child: Icon(
                  Icons.soup_kitchen,
                  size: 120,
                  color: black,
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              right: -20,
              child: Opacity(
                opacity: 0.2,
                child: Icon(
                  Icons.egg_alt,
                  size: 120,
                  color: black,
                ),
              ),
            ),

            // Main content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
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

                    // Title
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Text(
                          'Welcome to the Kitchen 👋',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                            color: Colors.black,
                          ),
                        ),
                        Positioned(
                          top: -20,
                          right: -20,
                          child: Icon(
                            Icons.star,
                            size: 48,
                            color: accentYellow,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Subtitle
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          const TextSpan(text: 'AI-powered recipes, '),
                          WidgetSpan(
                            child: Transform.rotate(
                              angle: -0.05,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: accentYellow,
                                  border: Border.all(width: 2, color: black),
                                ),
                                child: const Text(
                                  'zero fluff.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Google button
                    _Pressable(
                      child: Container(
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 4, color: black),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.g_mobiledata, size: 40, color: Colors.deepOrange,),
                            SizedBox(width: 12),
                            Text(
                              'Continue with Google',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Divider
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(thickness: 4, color: black),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: accentYellow,
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: black),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'OR',
                            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
                          ),
                        ),
                        const Expanded(
                          child: Divider(thickness: 4, color: black),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Email button
                    _Pressable(
                      child: Container(
                        height: 64,
                        decoration: BoxDecoration(
                          color: primary,
                          border: Border.all(width: 4, color: black),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.mail, color: Colors.white),
                            SizedBox(width: 12),
                            Text(
                              'Continue with Email',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Footer
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: black,
                        ),
                        children: [
                          const TextSpan(text: 'New chef? '),
                          TextSpan(
                            text: 'Create an account',
                            style: const TextStyle(
                              color: primary,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.wavy,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------- PRESSABLE (HTML :active equivalent) ---------- */

class _Pressable extends StatefulWidget {
  final Widget child;
  const _Pressable({required this.child});

  @override
  State<_Pressable> createState() => _PressableState();
}

class _PressableState extends State<_Pressable> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        transform: _pressed
            ? (Matrix4.identity()..translate(4.0, 4.0))
            : Matrix4.identity(),
        child: widget.child,
      ),
    );
  }
}
