import 'package:flutter/material.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.delay = Duration.zero,
  });

  final IconData icon;
  final String title;
  final String description;
  final Duration delay;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool _visible = false;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 420),
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0, 0.08),
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color:
                    _hovered
                        ? const Color(0xFF07848C)
                        : const Color(0xFFE2E8F0),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(
                    0xFF172033,
                  ).withValues(alpha: _hovered ? 0.10 : 0.05),
                  blurRadius: _hovered ? 28 : 18,
                  offset: Offset(0, _hovered ? 16 : 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F7F8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(widget.icon, color: const Color(0xFF07848C)),
                ),
                const SizedBox(height: 18),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Color(0xFF172033),
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.description,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    height: 1.5,
                    fontWeight: FontWeight.w600,
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
