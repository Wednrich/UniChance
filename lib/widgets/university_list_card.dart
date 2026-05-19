import 'package:flutter/material.dart';

import '../models/university.dart';

class UniversityListCard extends StatefulWidget {
  const UniversityListCard({
    super.key,
    required this.university,
    this.delay = Duration.zero,
  });

  final University university;
  final Duration delay;

  @override
  State<UniversityListCard> createState() => _UniversityListCardState();
}

class _UniversityListCardState extends State<UniversityListCard> {
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
      duration: const Duration(milliseconds: 360),
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0, 0.08),
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeOutCubic,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _hovered ? const Color(0xFFFBFEFE) : Colors.white,
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
                  ).withValues(alpha: _hovered ? 0.10 : 0.04),
                  blurRadius: _hovered ? 26 : 14,
                  offset: Offset(0, _hovered ? 14 : 8),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 720;
                final code = _CodeBadge(
                  code: widget.university.id.toUpperCase(),
                );
                final info = _UniversityInfo(university: widget.university);
                final chips = _UniversityChips(university: widget.university);

                if (compact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      code,
                      const SizedBox(height: 14),
                      info,
                      const SizedBox(height: 16),
                      chips,
                    ],
                  );
                }

                return Row(
                  children: [
                    code,
                    const SizedBox(width: 18),
                    Expanded(child: info),
                    const SizedBox(width: 18),
                    chips,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CodeBadge extends StatelessWidget {
  const _CodeBadge({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 86,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F7F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        code,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF05636A),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _UniversityInfo extends StatelessWidget {
  const _UniversityInfo({required this.university});

  final University university;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          university.name,
          style: const TextStyle(
            color: Color(0xFF172033),
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          university.type,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _UniversityChips extends StatelessWidget {
  const _UniversityChips({required this.university});

  final University university;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.end,
      children: [
        _Chip(icon: Icons.location_on_rounded, text: university.city),
        _Chip(icon: Icons.map_rounded, text: university.city),
        _Chip(icon: Icons.category_rounded, text: university.type),
        _Chip(
          icon: Icons.shield_rounded,
          text:
              university.hasMilitaryDepartment
                  ? 'Әскери кафедра бар'
                  : 'Әскери кафедра жоқ',
        ),
        _Chip(
          icon: Icons.bed_rounded,
          text: university.hasDormitory ? 'Жатақхана бар' : 'Жатақхана жоқ',
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFA),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: const Color(0xFF07848C)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF172033),
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
