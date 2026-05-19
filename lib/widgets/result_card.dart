import 'package:flutter/material.dart';

import '../models/program.dart';
import '../models/university.dart';
import '../utils/chance_calculator.dart';

class ResultCard extends StatefulWidget {
  const ResultCard({
    super.key,
    required this.program,
    required this.university,
    required this.userScore,
    this.animationDelay = Duration.zero,
  });

  final Program program;
  final University university;
  final int userScore;
  final Duration animationDelay;

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  bool _visible = false;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.animationDelay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final chance = calculateGrantChance(
      userScore: widget.userScore,
      grantPassingScore: widget.program.grantPassingScore,
    );

    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0, 0.08),
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
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
                  ).withValues(alpha: _hovered ? 0.12 : 0.06),
                  blurRadius: _hovered ? 34 : 22,
                  offset: Offset(0, _hovered ? 18 : 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _Tag(
                      text: widget.university.city,
                      color: const Color(0xFFE6F7F8),
                    ),
                    _Tag(
                      text: widget.program.groupCode,
                      color: const Color(0xFFFFF6D7),
                    ),
                    _Tag(
                      text: chance.label,
                      color: _chanceColor(chance.percent),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  widget.university.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF172033),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  widget.program.name,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                    height: 1.18,
                    color: Color(0xFF172033),
                  ),
                ),
                const SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 760;
                    final children = [
                      _Info(
                        'Қала',
                        widget.university.city,
                        Icons.location_on_rounded,
                      ),
                      _Info(
                        'Бағдарлама коды',
                        widget.program.code,
                        Icons.tag_rounded,
                      ),
                      _Info(
                        'ГОП коды',
                        widget.program.groupCode,
                        Icons.category_rounded,
                      ),
                      _Info(
                        'Таңдау пәндері',
                        widget.program.subjectsLabel,
                        Icons.tune_rounded,
                      ),
                      _Info(
                        'Сіздің балл',
                        '${widget.userScore}',
                        Icons.stacked_bar_chart_rounded,
                      ),
                      _Info(
                        'Грант шекті балы',
                        widget.program.grantPassingScore?.toString() ??
                            'Дерек әлі енгізілмеген',
                        Icons.flag_rounded,
                      ),
                      _Info(
                        'Грант мүмкіндігі',
                        chance.percent == null
                            ? chance.label
                            : '${chance.percent}% · ${chance.label}',
                        Icons.trending_up_rounded,
                      ),
                      _Info(
                        'Ақылы оқу шегі',
                        '${widget.program.paidMinimumScore}',
                        Icons.school_rounded,
                      ),
                      _Info(
                        'Оқу ақысы',
                        '${_formatPrice(widget.program.tuitionFee)} ₸/жыл',
                        Icons.payments_rounded,
                      ),
                      _Info(
                        'Жатақхана',
                        widget.university.hasDormitory ? 'Бар' : 'Жоқ',
                        Icons.bed_rounded,
                      ),
                      _Info(
                        'Әскери кафедра',
                        widget.university.hasMilitaryDepartment ? 'Бар' : 'Жоқ',
                        Icons.shield_rounded,
                      ),
                      _Info(
                        'Дерек жылы',
                        '${widget.program.dataYear}',
                        Icons.event_rounded,
                      ),
                      _Info(
                        'Дерек көзі',
                        widget.program.source,
                        Icons.source_rounded,
                      ),
                      _Info(
                        'Ресми сайт',
                        widget.university.website,
                        Icons.open_in_new_rounded,
                      ),
                    ];

                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: isWide ? 2 : 1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: isWide ? 4.2 : 5.2,
                      children: children,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _chanceColor(int? percent) {
    if (percent == null) return const Color(0xFFF1F5F9);
    if (percent >= 70) return const Color(0xFFDCFCE7);
    if (percent >= 40) return const Color(0xFFFFF6D7);
    return const Color(0xFFFEE2E2);
  }

  String _formatPrice(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]} ',
    );
  }
}

class _Info extends StatelessWidget {
  const _Info(this.label, this.value, this.icon);

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF07848C), size: 20),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF172033),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          color: Color(0xFF172033),
        ),
      ),
    );
  }
}
