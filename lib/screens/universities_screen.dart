import 'package:flutter/material.dart';

import '../data/universities_data.dart';
import '../models/university.dart';
import '../widgets/app_footer.dart';
import '../widgets/app_header.dart';
import '../widgets/decorative_background.dart';
import '../widgets/filter_dropdown.dart';
import '../widgets/page_container.dart';
import '../widgets/search_input.dart';
import '../widgets/section_title.dart';
import '../widgets/university_list_card.dart';

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({super.key});

  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  String _region = 'Барлық аймақ';
  String _type = 'Барлық түрі';
  String _query = '';
  bool _visible = true;

  List<String> get _regions {
    final values =
        universities.map((item) => item.city).toSet().toList()..sort();
    return ['Барлық аймақ', ...values];
  }

  List<String> get _types {
    final values =
        universities.map((item) => item.type).toSet().toList()..sort();
    return ['Барлық түрі', ...values];
  }

  List<University> get _filtered {
    return universities.where((item) {
      final regionMatch = _region == 'Барлық аймақ' || item.city == _region;
      final typeMatch = _type == 'Барлық түрі' || item.type == _type;
      final query = _query.trim().toLowerCase();
      final queryMatch =
          query.isEmpty ||
          item.name.toLowerCase().contains(query) ||
          item.id.toLowerCase().contains(query);
      return regionMatch && typeMatch && queryMatch;
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
              const AppHeader(currentRoute: '/universities'),
              SliverToBoxAdapter(
                child: PageContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(
                        title: 'Қазақстан ЖОО-лары',
                        subtitle:
                            'Қазақстандағы университеттер тізімін қарап, код немесе атауы бойынша іздеңіз.',
                      ),
                      const SizedBox(height: 24),
                      _FilterPanel(
                        region: _region,
                        regions: _regions,
                        type: _type,
                        types: _types,
                        onRegionChanged:
                            (value) => setState(() => _region = value),
                        onTypeChanged: (value) => setState(() => _type = value),
                        onQueryChanged:
                            (value) => setState(() => _query = value),
                      ),
                      const SizedBox(height: 22),
                      ..._filtered.asMap().entries.map((entry) {
                        return UniversityListCard(
                          university: entry.value,
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
    required this.region,
    required this.regions,
    required this.type,
    required this.types,
    required this.onRegionChanged,
    required this.onTypeChanged,
    required this.onQueryChanged,
  });

  final String region;
  final List<String> regions;
  final String type;
  final List<String> types;
  final ValueChanged<String> onRegionChanged;
  final ValueChanged<String> onTypeChanged;
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
            hint: 'ЖОО атауы немесе коды бойынша іздеу',
            onChanged: onQueryChanged,
          );
          final regionFilter = FilterDropdown(
            value: region,
            items: regions,
            onChanged: onRegionChanged,
          );
          final typeFilter = FilterDropdown(
            value: type,
            items: types,
            onChanged: onTypeChanged,
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                search,
                const SizedBox(height: 12),
                regionFilter,
                const SizedBox(height: 12),
                typeFilter,
              ],
            );
          }

          return Row(
            children: [
              Expanded(flex: 5, child: search),
              const SizedBox(width: 12),
              Expanded(flex: 2, child: regionFilter),
              const SizedBox(width: 12),
              Expanded(flex: 2, child: typeFilter),
            ],
          );
        },
      ),
    );
  }
}
