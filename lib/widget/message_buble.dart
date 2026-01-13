import 'package:flutter/material.dart';

const double kBorder = 2.5;

const Color black = Colors.black;
const Color red = Color(0xFFFF4D2D);
const Color white = Colors.white;
const Color errorBg = Color(0xFFFFB4B4);

class NeubrutalistBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isError;
  final DateTime timestamp;

  const NeubrutalistBubble({
    super.key,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isError
        ? errorBg
        : isUser
            ? red
            : white;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: black, width: kBorder),
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              text.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
                color: isUser ? white : black,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _formatTime(timestamp),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
