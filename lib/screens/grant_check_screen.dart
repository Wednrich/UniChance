import 'package:flutter/material.dart';

import '../data/programs_data.dart';
import '../data/universities_data.dart';
import '../models/program.dart';
import '../widgets/app_footer.dart';
import '../widgets/app_header.dart';
import '../widgets/decorative_background.dart';
import '../widgets/grant_check_form.dart';
import '../widgets/page_container.dart';
import '../widgets/result_card.dart';
import '../widgets/section_title.dart';

class GrantCheckScreen extends StatefulWidget {
  const GrantCheckScreen({super.key});

  @override
  State<GrantCheckScreen> createState() => _GrantCheckScreenState();
}

class _GrantCheckScreenState extends State<GrantCheckScreen> {
  int? _userScore;
  String _selectedSubjects = '';
  String _selectedCity = 'Барлық қала';
  List<Program> _results = [];
  bool _searched = false;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _visible = true);
    });
  }

  void _handleSearch({
    required int score,
    required String subjects,
    required String quota,
    required String city,
  }) {
    final filtered =
        programs.where((program) {
          final subjectMatch = program.subjectsLabel == subjects;
          final university = universities.firstWhere(
            (item) => item.id == program.universityId,
          );
          final cityMatch = city == 'Барлық қала' || university.city == city;
          return subjectMatch && cityMatch;
        }).toList();

    setState(() {
      _userScore = score;
      _selectedSubjects = subjects;
      _selectedCity = city;
      _results = filtered;
      _searched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFA),
      body: DecorativeBackground(
        child: AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 420),
          child: CustomScrollView(
            slivers: [
              const AppHeader(currentRoute: '/grant'),
              SliverToBoxAdapter(
                child: PageContainer(
                  padding: const EdgeInsets.fromLTRB(20, 46, 20, 64),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(
                        title: 'Грант мүмкіндігін тексеру',
                        subtitle:
                            'ҰБТ балыңызды, таңдау пәндеріңізді және конкурс түрін енгізіңіз.',
                      ),
                      const SizedBox(height: 28),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final desktop = constraints.maxWidth >= 980;
                          final form = GrantCheckForm(onSearch: _handleSearch);
                          final side = const _GrantTipsCard();

                          if (desktop) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 7, child: form),
                                const SizedBox(width: 24),
                                Expanded(flex: 5, child: side),
                              ],
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [form, const SizedBox(height: 20), side],
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      _ResultsSection(
                        searched: _searched,
                        selectedSubjects: _selectedSubjects,
                        selectedCity: _selectedCity,
                        userScore: _userScore,
                        results: _results,
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: AppFooter()),
            ],
          ),
        ),
      ),
    );
  }
}

class _GrantTipsCard extends StatelessWidget {
  const _GrantTipsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: const Color(0xFF05636A),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF05636A).withValues(alpha: 0.20),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.tips_and_updates_rounded,
            color: Color(0xFFFFD166),
            size: 34,
          ),
          SizedBox(height: 18),
          Text(
            'Нәтижені қалай оқу керек?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Болжам өткен жылдардағы шекті балдарға сүйенеді. Нақты конкурс жыл сайын өзгеруі мүмкін, сондықтан бірнеше ЖОО мен мамандықты қатар қарастырған дұрыс.',
            style: TextStyle(
              color: Color(0xFFCDEDEF),
              height: 1.6,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 22),
          _TipLine(text: '+15 балл және жоғары — өте жоғары мүмкіндік'),
          _TipLine(text: '0 балл айырма — шекаралық жағдай'),
          _TipLine(text: 'Теріс айырма — қосымша нұсқаларды қараңыз'),
        ],
      ),
    );
  }
}

class _TipLine extends StatelessWidget {
  const _TipLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: Color(0xFF22C55E),
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultsSection extends StatelessWidget {
  const _ResultsSection({
    required this.searched,
    required this.selectedSubjects,
    required this.selectedCity,
    required this.userScore,
    required this.results,
  });

  final bool searched;
  final String selectedSubjects;
  final String selectedCity;
  final int? userScore;
  final List<Program> results;

  @override
  Widget build(BuildContext context) {
    if (!searched) {
      return const _Disclaimer();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Disclaimer(),
        const SizedBox(height: 26),
        Text(
          'Нәтижелер',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: const Color(0xFF172033),
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$selectedSubjects, $selectedCity бойынша ${results.length} бағдарлама табылды.',
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 18),
        if (results.isEmpty)
          const Text(
            'Бұл параметрлер бойынша тесттік деректерде бағдарлама табылмады.',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w700,
            ),
          )
        else
          ...results.asMap().entries.map((entry) {
            final program = entry.value;
            final university = universities.firstWhere(
              (item) => item.id == program.universityId,
            );
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ResultCard(
                program: program,
                university: university,
                userScore: userScore ?? 0,
                animationDelay: Duration(milliseconds: entry.key * 70),
              ),
            );
          }),
      ],
    );
  }
}

class _Disclaimer extends StatelessWidget {
  const _Disclaimer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: const Text(
        'Бұл нәтиже өткен жылдардағы деректерге негізделген болжам. Нақты грант нәтижесіне конкурс, квота және жыл сайынғы өзгерістер әсер етеді.',
        style: TextStyle(
          color: Color(0xFF6B7280),
          fontWeight: FontWeight.w700,
          height: 1.45,
        ),
      ),
    );
  }
}
