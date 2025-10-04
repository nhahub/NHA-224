import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
  });

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        gradient: _isPressed
            ? const LinearGradient(
                colors: [Color(0xFF6A5AE0), Color(0xFF8A7DF0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [Color(0xFFEFEFEF), Color(0xFFFFFFFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: _isPressed
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  offset: const Offset(2, 3),
                  blurRadius: 6,
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapCancel: () => setState(() => _isPressed = false),
          onTapUp: (_) {
            setState(() => _isPressed = false);
            widget.onTap();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon,
                    size: 18,
                    color: _isPressed
                        ? Colors.white
                        : const Color(0xFF6A5AE0)),
                const SizedBox(width: 6),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color:
                        _isPressed ? Colors.white : const Color(0xFF333333),
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
