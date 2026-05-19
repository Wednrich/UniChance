import 'package:flutter/material.dart';

class AppFooter extends StatefulWidget {
  const AppFooter({super.key});

  @override
  State<AppFooter> createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter> {
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
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      child: Container(
        width: double.infinity,
        color: const Color(0xFF05636A),
        child: SafeArea(
          top: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 56, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        final columns = [
                          const _FooterBrand(),
                          _FooterColumn(
                            title: 'Навигация',
                            items: const [
                              'Басты бет',
                              'Грант тексеру',
                              'ЖОО-лар',
                              'Мамандықтар',
                            ],
                            routes: const [
                              '/',
                              '/grant',
                              '/universities',
                              '/programs',
                            ],
                          ),
                          const _FooterColumn(
                            title: 'Байланыс',
                            items: [
                              'Instagram',
                              'Telegram',
                              'Email: info@unichance.kz',
                            ],
                          ),
                          const _FooterNote(),
                        ];

                        if (width < 620) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                columns.map((child) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 28),
                                    child: child,
                                  );
                                }).toList(),
                          );
                        }

                        if (width < 980) {
                          return Wrap(
                            spacing: 28,
                            runSpacing: 28,
                            children:
                                columns.map((child) {
                                  return SizedBox(
                                    width: (width - 28) / 2,
                                    child: child,
                                  );
                                }).toList(),
                          );
                        }

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              columns.map((child) {
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 24),
                                    child: child,
                                  ),
                                );
                              }).toList(),
                        );
                      },
                    ),
                    const SizedBox(height: 34),
                    Container(
                      height: 1,
                      color: Colors.white.withValues(alpha: 0.14),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '© 2026 UniChance. Барлық құқықтар қорғалған.',
                      style: TextStyle(
                        color: Color(0xFFD7F1F3),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterBrand extends StatelessWidget {
  const _FooterBrand();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.school_rounded, color: Color(0xFFFFD166), size: 30),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                'UniChance',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'UniChance — талапкерлерге ЖОО мен мамандық таңдауға және грант мүмкіндігін тексеруге көмектесетін платформа.',
          style: TextStyle(
            color: Color(0xFFD7F1F3),
            height: 1.55,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _FooterColumn extends StatelessWidget {
  const _FooterColumn({
    required this.title,
    required this.items,
    this.routes = const [],
  });

  final String title;
  final List<String> items;
  final List<String> routes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        ...items.asMap().entries.map((entry) {
          final route = entry.key < routes.length ? routes[entry.key] : null;
          return Padding(
            padding: const EdgeInsets.only(bottom: 11),
            child: InkWell(
              onTap:
                  route == null
                      ? null
                      : () => Navigator.pushNamed(context, route),
              child: Text(
                entry.value,
                style: const TextStyle(
                  color: Color(0xFFD7F1F3),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _FooterNote extends StatelessWidget {
  const _FooterNote();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ескерту',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Платформадағы нәтиже өткен жылдардағы деректерге негізделген болжам. Бұл нақты грантқа кепілдік бермейді.',
          style: TextStyle(
            color: Color(0xFFD7F1F3),
            height: 1.55,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
