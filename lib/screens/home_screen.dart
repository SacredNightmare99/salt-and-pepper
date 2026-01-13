import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const bg = Color(0xFFFFF4E8);
  static const paper = Colors.white;
  static const charcoal = Color(0xFF1B0F0E);
  static const primary = Color(0xFFE94A35);
  static const mustard = Color(0xFFF4B400);
  static const border = BorderSide(width: 4, color: charcoal);

  final TextEditingController _manualController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _TopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Headline(),
                        const SizedBox(height: 24),
                        _ScanCard(),
                        const SizedBox(height: 24),
                        _DividerDots(),
                        const SizedBox(height: 24),
                        _ManualInputCard(controller: _manualController),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------- TOP BAR ---------------- */

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Transform.rotate(
            angle: -0.05,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 4, color: Color(0xFF1B0F0E)),
              ),
              child: const Text(
                'SALT&PEPPER',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                  color: _HomeScreenState.charcoal,
                ),
              ),
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 4, color: Color(0xFF1B0F0E)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}

/* ---------------- HEADLINE ---------------- */

class _Headline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "WHAT’S IN",
          style: TextStyle(
            fontSize: 38,
            height: 0.95,
            fontWeight: FontWeight.w900,
            color: _HomeScreenState.charcoal,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          color: Color(0xFFFBE5B8),
          child: Text(
            "YOUR KITCHEN",
            style: TextStyle(
              fontSize: 38,
              height: 0.95,
              color: Colors.deepOrange,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Text(
          "TODAY?",
          style: TextStyle(
            fontSize: 38,
            height: 0.95,
            fontWeight: FontWeight.w900,
            color: _HomeScreenState.charcoal,
          ),
        ),
      ],
    );
  }
}

/* ---------------- SCAN CARD ---------------- */

class _ScanCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 4, color: Color(0xFF1B0F0E)),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: Color(0xFFF4B400),
                  border: Border.all(width: 4, color: Color(0xFF1B0F0E)),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 4, color: Color(0xFF1B0F0E)),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.photo_camera, size: 36),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'SCAN FRIDGE',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: _HomeScreenState.charcoal),
          ),
          const SizedBox(height: 8),
          const Text(
            'Use your camera to identify ingredients instantly.',
            style: TextStyle(color: _HomeScreenState.charcoal),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _PrimaryButton(label: 'OPEN CAMERA', icon: Icons.center_focus_weak),
        ],
      ),
    );
  }
}

/* ---------------- DIVIDER ---------------- */

class _DividerDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (_) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 4,
          decoration: BoxDecoration(
            color: Color(0xFF1B0F0E),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

/* ---------------- MANUAL INPUT ---------------- */

class _ManualInputCard extends StatelessWidget {
  final TextEditingController controller;

  const _ManualInputCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 4, color: Color(0xFF1B0F0E)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'OR TYPE IT OUT',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 16),
              Container(
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF4E8),
                  border: Border.all(width: 4, color: Color(0xFF1B0F0E)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'chicken, potato...',
                  ),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              _SecondaryButton(
                label: 'FIND RECIPES',
                icon: Icons.arrow_forward,
              ),
            ],
          ),
        ),
        Positioned(
          top: -12,
          left: 20,
          child: Transform.rotate(
            angle: 0.05,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFF4B400),
                border: Border.all(width: 4, color: Color(0xFF1B0F0E)),
              ),
              child: const Text(
                'MANUAL INPUT',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/* ---------------- BUTTONS ---------------- */

class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _PrimaryButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Color(0xFFE94A35),
        border: Border.all(width: 4, color: Color(0xFF1B0F0E)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SecondaryButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 4, color: Color(0xFF1B0F0E)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w900)),
          const SizedBox(width: 8),
          Icon(icon),
        ],
      ),
    );
  }
}
