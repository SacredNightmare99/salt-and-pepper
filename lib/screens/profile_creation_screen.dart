import 'package:flutter/material.dart';
import 'package:salt_and_pepper/screens/chat_screen.dart';

class ChefProfileScreen extends StatefulWidget {
  const ChefProfileScreen({super.key});

  @override
  State<ChefProfileScreen> createState() => _ChefProfileScreenState();
}

class _ChefProfileScreenState extends State<ChefProfileScreen> {
  String _diet = 'both';
  final _nameController = TextEditingController();

  static const Color bg = Color(0xFFF5F5F5);
  static const Color primary = Color(0xFFE94A35);
  static const Color black = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SET UP YOUR',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        height: 1.05,
                      ),
                    ),
                    const Text(
                      'CHEF PROFILE',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        color: primary,
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Let's personalize your kitchen experience.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 48),

                    const Text(
                      'WHAT SHOULD WE CALL YOU?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'e.g. Chef Ramsey',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide:
                              const BorderSide(width: 2, color: black),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    const Text(
                      'DIETARY STYLE',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        _DietOption(
                          label: 'VEG',
                          selected: _diet == 'veg',
                          onTap: () => setState(() => _diet = 'veg'),
                        ),
                        const SizedBox(width: 12),
                        _DietOption(
                          label: 'NON-VEG',
                          selected: _diet == 'non-veg',
                          onTap: () => setState(() => _diet = 'non-veg'),
                        ),
                        const SizedBox(width: 12),
                        _DietOption(
                          label: 'BOTH',
                          selected: _diet == 'both',
                          onTap: () => setState(() => _diet = 'both'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),

            // CTA
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    elevation: 0,
                    side: const BorderSide(width: 2, color: black),
                  ),
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  label: const Text(
                    'ENTER THE KITCHEN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    // 🔥 DEMO NAVIGATION
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ChatScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------- DIET OPTION ---------------- */

class _DietOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _DietOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor:
              selected ? _ChefProfileScreenState.primary : Colors.white,
          side: const BorderSide(width: 2, color: Colors.black),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

