import 'package:flutter/material.dart';

import '../models/program.dart';

class ProgramListCard extends StatefulWidget {
  const ProgramListCard({
    super.key,
    required this.program,
    this.delay = Duration.zero,
  });

  final Program program;
  final Duration delay;

  @override
  State<ProgramListCard> createState() => _ProgramListCardState();
}

class _ProgramListCardState extends State<ProgramListCard> {
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
                final code = _CodeBadge(code: widget.program.code);
                final info = _ProgramInfo(program: widget.program);
                final chips = _ProgramChips(program: widget.program);

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
      width: 104,
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

class _ProgramInfo extends StatelessWidget {
  const _ProgramInfo({required this.program});

  final Program program;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          program.name,
          style: const TextStyle(
            color: Color(0xFF172033),
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'ГОП коды: ${program.groupCode}',
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _ProgramChips extends StatelessWidget {
  const _ProgramChips({required this.program});

  final Program program;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.end,
      children: [
        _Chip(icon: Icons.tune_rounded, text: program.subjectsLabel),
        _Chip(icon: Icons.category_rounded, text: program.groupCode),
        _Chip(
          icon: Icons.payments_rounded,
          text: '${_formatPrice(program.tuitionFee)} ₸/жыл',
        ),
      ],
    );
  }

  String _formatPrice(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]} ',
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
