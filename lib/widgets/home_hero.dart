import 'package:flutter/material.dart';

import 'animated_dashboard_preview.dart';
import 'animated_primary_button.dart';

class HomeHero extends StatefulWidget {
  const HomeHero({super.key});

  @override
  State<HomeHero> createState() => _HomeHeroState();
}

class _HomeHeroState extends State<HomeHero> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final desktop = constraints.maxWidth >= 940;
        final content = _HeroText(visible: _visible);
        const preview = AnimatedDashboardPreview();

        if (desktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 10, child: content),
              const SizedBox(width: 48),
              const Expanded(flex: 9, child: preview),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [content, const SizedBox(height: 34), preview],
        );
      },
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText({required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: const Duration(milliseconds: 620),
      curve: Curves.easeOutCubic,
      child: AnimatedSlide(
        offset: visible ? Offset.zero : const Offset(0, 0.08),
        duration: const Duration(milliseconds: 620),
        curve: Curves.easeOutCubic,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F7F8),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0xFFBFECEF)),
              ),
              child: const Text(
                '2026 жылғы деректер бойынша',
                style: TextStyle(
                  color: Color(0xFF05636A),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'ҰБТ балыңды енгіз де, грантқа мүмкіндігіңді анықта',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: const Color(0xFF172033),
                fontWeight: FontWeight.w900,
                height: 1.04,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'UniChance саған университеттерді, мамандықтарды, оқу ақысын және грантқа түсу ықтималдығын бір жерден көруге көмектеседі.',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 18,
                height: 1.6,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 28),
            Wrap(
              spacing: 14,
              runSpacing: 12,
              children: [
                AnimatedPrimaryButton(
                  label: 'Грантты тексеру',
                  icon: Icons.analytics_rounded,
                  onPressed: () => Navigator.pushNamed(context, '/grant'),
                ),
                AnimatedPrimaryButton(
                  label: 'ЖОО тізімін көру',
                  icon: Icons.account_balance_rounded,
                  secondary: true,
                  onPressed:
                      () => Navigator.pushNamed(context, '/universities'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
