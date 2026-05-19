import 'package:flutter/material.dart';

class AnimatedDashboardPreview extends StatelessWidget {
  const AnimatedDashboardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 24 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF172033).withValues(alpha: 0.10),
                  blurRadius: 42,
                  offset: const Offset(0, 24),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F7F8),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.dashboard_customize_rounded,
                        color: Color(0xFF07848C),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'UniChance бақылау панелі',
                        style: TextStyle(
                          color: Color(0xFF172033),
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                const Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _MetricCard(
                      label: 'Грант шансы',
                      value: '85%',
                      icon: Icons.trending_up_rounded,
                    ),
                    _MetricCard(
                      label: 'ЖОО саны',
                      value: '100+',
                      icon: Icons.account_balance_rounded,
                    ),
                    _MetricCard(
                      label: 'Мамандықтар',
                      value: '500+',
                      icon: Icons.menu_book_rounded,
                    ),
                    _MetricCard(
                      label: 'ҰБТ балы',
                      value: '118',
                      icon: Icons.stacked_bar_chart_rounded,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const _ProgressLine(
                  label: 'Ақпараттық технологиялар',
                  value: 0.86,
                ),
                const SizedBox(height: 14),
                const _ProgressLine(label: 'Педагогикалық бағыт', value: 0.72),
                const SizedBox(height: 14),
                const _ProgressLine(label: 'Инженерлік бағыт', value: 0.58),
              ],
            ),
          ),
          const Positioned(
            right: -12,
            top: -16,
            child: _FloatingChip(
              text: '2026 дерек',
              icon: Icons.verified_rounded,
            ),
          ),
          const Positioned(
            left: -18,
            bottom: 28,
            child: _FloatingChip(
              text: 'Грант болжамы',
              icon: Icons.workspace_premium_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 154,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF7FAFA),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF07848C), size: 22),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF172033),
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressLine extends StatelessWidget {
  const _ProgressLine({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF172033),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(
              '${(value * 100).round()}%',
              style: const TextStyle(
                color: Color(0xFF07848C),
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: value),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutCubic,
          builder: (context, animated, _) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: 9,
                value: animated,
                backgroundColor: const Color(0xFFE6F7F8),
                valueColor: const AlwaysStoppedAnimation(Color(0xFF07848C)),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _FloatingChip extends StatelessWidget {
  const _FloatingChip({required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -1, end: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.translate(offset: Offset(0, value * 5), child: child);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF172033).withValues(alpha: 0.09),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFF07848C), size: 18),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFF172033),
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
