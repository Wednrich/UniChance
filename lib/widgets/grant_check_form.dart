import 'package:flutter/material.dart';

import '../data/universities_data.dart';
import 'animated_primary_button.dart';

class GrantCheckForm extends StatefulWidget {
  const GrantCheckForm({super.key, required this.onSearch});

  final void Function({
    required int score,
    required String subjects,
    required String quota,
    required String city,
  })
  onSearch;

  @override
  State<GrantCheckForm> createState() => _GrantCheckFormState();
}

class _GrantCheckFormState extends State<GrantCheckForm> {
  final _scoreController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _subjects = 'Математика + Информатика';
  String _quota = 'Жалпы конкурс';
  String _city = 'Барлық қала';
  bool _confirmed = false;
  bool _visible = false;
  bool _hovered = false;

  static const subjects = [
    'Математика + Информатика',
    'Математика + Физика',
    'Биология + Химия',
    'География + Математика',
    'Шығармашылық',
  ];

  static const quotas = [
    'Жалпы конкурс',
    'Ауыл квотасы',
    'Көпбалалы отбасы',
    'Серпін',
    'Жетім балалар',
    'Мүгедектігі бар адамдар',
  ];

  List<String> get _cities {
    final values =
        universities.map((item) => item.city).toSet().toList()..sort();
    return ['Барлық қала', ...values];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  void dispose() {
    _scoreController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (!_confirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Деректерді дұрыс енгізгеніңізді растаңыз.'),
        ),
      );
      return;
    }

    widget.onSearch(
      score: int.parse(_scoreController.text.trim()),
      subjects: _subjects,
      quota: _quota,
      city: _city,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeOutCubic,
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0.06, 0),
        duration: const Duration(milliseconds: 520),
        curve: Curves.easeOutCubic,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: const Color(
                    0xFF172033,
                  ).withValues(alpha: _hovered ? 0.11 : 0.07),
                  blurRadius: _hovered ? 34 : 24,
                  offset: Offset(0, _hovered ? 18 : 12),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Грант мүмкіндігін тексеру',
                    style: TextStyle(
                      color: Color(0xFF172033),
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'ҰБТ балыңызды, таңдау пәндеріңізді және конкурс түрін енгізіңіз.',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  DropdownButtonFormField<String>(
                    value: _subjects,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Таңдау пәндері',
                    ),
                    items:
                        subjects.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item, overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                    onChanged:
                        (value) =>
                            setState(() => _subjects = value ?? subjects.first),
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    value: _quota,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Конкурс түрі',
                    ),
                    items:
                        quotas.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item, overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                    onChanged:
                        (value) =>
                            setState(() => _quota = value ?? quotas.first),
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    value: _city,
                    isExpanded: true,
                    decoration: const InputDecoration(labelText: 'Қала'),
                    items:
                        _cities.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item, overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                    onChanged:
                        (value) =>
                            setState(() => _city = value ?? _cities.first),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _scoreController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'ҰБТ балы',
                      hintText: 'Мысалы: 112',
                      prefixIcon: Icon(Icons.stacked_bar_chart_rounded),
                    ),
                    validator: (value) {
                      final score = int.tryParse((value ?? '').trim());
                      if (score == null) return 'ҰБТ балын енгізіңіз.';
                      if (score < 0 || score > 140) {
                        return 'Балл 0 мен 140 аралығында болуы керек.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  CheckboxListTile(
                    value: _confirmed,
                    onChanged:
                        (value) => setState(() => _confirmed = value ?? false),
                    activeColor: const Color(0xFF07848C),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Деректерді дұрыс енгіздім',
                      style: TextStyle(
                        color: Color(0xFF172033),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedPrimaryButton(
                    onPressed: _submit,
                    label: 'Нәтижені көру',
                    icon: Icons.analytics_rounded,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
