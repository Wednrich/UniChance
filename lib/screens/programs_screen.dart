import 'package:flutter/material.dart';

import '../data/programs_data.dart';
import '../models/program.dart';
import '../widgets/app_footer.dart';
import '../widgets/app_header.dart';
import '../widgets/decorative_background.dart';
import '../widgets/filter_dropdown.dart';
import '../widgets/page_container.dart';
import '../widgets/program_list_card.dart';
import '../widgets/search_input.dart';
import '../widgets/section_title.dart';

class ProgramsScreen extends StatefulWidget {
  const ProgramsScreen({super.key});

  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  String _subjects = 'Барлық пәндер';
  String _group = 'Барлық бағыттар';
  String _query = '';
  bool _visible = true;

  List<String> get _subjectOptions {
    final values =
        programs.map((item) => item.subjectsLabel).toSet().toList()..sort();
    return ['Барлық пәндер', ...values];
  }

  List<String> get _groups {
    final values =
        programs.map((item) => item.groupCode).toSet().toList()..sort();
    return ['Барлық бағыттар', ...values];
  }

  List<Program> get _filtered {
    return programs.where((item) {
      final subjectMatch =
          _subjects == 'Барлық пәндер' || item.subjectsLabel == _subjects;
      final groupMatch =
          _group == 'Барлық бағыттар' || item.groupCode == _group;
      final query = _query.trim().toLowerCase();
      final queryMatch =
          query.isEmpty ||
          item.name.toLowerCase().contains(query) ||
          item.code.toLowerCase().contains(query) ||
          item.groupCode.toLowerCase().contains(query);
      return subjectMatch && groupMatch && queryMatch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFA),
      body: DecorativeBackground(
        child: AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 360),
          child: CustomScrollView(
            slivers: [
              const AppHeader(currentRoute: '/programs'),
              SliverToBoxAdapter(
                child: PageContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(
                        title: 'Мамандықтар',
                        subtitle:
                            'Мамандықтарды таңдау пәндері, код немесе атауы бойынша іздеңіз.',
                      ),
                      const SizedBox(height: 24),
                      _FilterPanel(
                        subjects: _subjects,
                        subjectOptions: _subjectOptions,
                        group: _group,
                        groups: _groups,
                        onSubjectChanged:
                            (value) => setState(() => _subjects = value),
                        onGroupChanged:
                            (value) => setState(() => _group = value),
                        onQueryChanged:
                            (value) => setState(() => _query = value),
                      ),
                      const SizedBox(height: 22),
                      ..._filtered.asMap().entries.map((entry) {
                        return ProgramListCard(
                          program: entry.value,
                          delay: Duration(milliseconds: entry.key * 65),
                        );
                      }),
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

class _FilterPanel extends StatelessWidget {
  const _FilterPanel({
    required this.subjects,
    required this.subjectOptions,
    required this.group,
    required this.groups,
    required this.onSubjectChanged,
    required this.onGroupChanged,
    required this.onQueryChanged,
  });

  final String subjects;
  final List<String> subjectOptions;
  final String group;
  final List<String> groups;
  final ValueChanged<String> onSubjectChanged;
  final ValueChanged<String> onGroupChanged;
  final ValueChanged<String> onQueryChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 900;
          final search = SearchInput(
            hint: 'Мамандық атауы немесе коды бойынша іздеу',
            onChanged: onQueryChanged,
          );
          final subjectFilter = FilterDropdown(
            value: subjects,
            items: subjectOptions,
            onChanged: onSubjectChanged,
          );
          final groupFilter = FilterDropdown(
            value: group,
            items: groups,
            onChanged: onGroupChanged,
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                search,
                const SizedBox(height: 12),
                subjectFilter,
                const SizedBox(height: 12),
                groupFilter,
              ],
            );
          }

          return Row(
            children: [
              Expanded(flex: 5, child: search),
              const SizedBox(width: 12),
              Expanded(flex: 2, child: subjectFilter),
              const SizedBox(width: 12),
              Expanded(flex: 2, child: groupFilter),
            ],
          );
        },
      ),
    );
  }
}
