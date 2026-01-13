import 'package:flutter/material.dart';

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
  // static const BorderSide border = BorderSide(color: Colors.black, width: 2);

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _BackButton(),
                  const SizedBox(width: 48),
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
                    // TITLE
                    const Text(
                      'SET UP YOUR',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        height: 1.05,
                      ),
                    ),
                    Text(
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

                    // NAME INPUT
                    const Text(
                      'WHAT SHOULD WE CALL YOU?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _NameInput(controller: _nameController),

                    const SizedBox(height: 40),

                    // DIET
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
              child: _CTAButton(
                label: 'ENTER THE KITCHEN',
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------- COMPONENTS ---------------- */

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.arrow_back, size: 28),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  final TextEditingController controller;
  const _NameInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: Builder(
        builder: (context) {
          final focused = Focus.of(context).hasFocus;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 2,
                color: focused ? _ChefProfileScreenState.primary : Colors.black,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'e.g. Chef Ramsey',
                    ),
                  ),
                ),
                const Icon(Icons.edit, color: Colors.black38),
              ],
            ),
          );
        },
      ),
    );
  }
}

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
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 64,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected
                ? _ChefProfileScreenState.primary
                : Colors.white,
            border: Border.all(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class _CTAButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _CTAButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {},
      onTap: onTap,
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: _ChefProfileScreenState.primary,
          border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'ENTER THE KITCHEN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            Icon(Icons.arrow_forward, color: Colors.white, size: 28),
          ],
        ),
      ),
    );
  }
}
