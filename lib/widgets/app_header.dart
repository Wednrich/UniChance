import 'package:flutter/material.dart';

import 'animated_primary_button.dart';

class AppHeader extends StatefulWidget {
  const AppHeader({super.key, required this.currentRoute});

  final String currentRoute;

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  bool _menuOpen = false;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _AppHeaderDelegate(
        currentRoute: widget.currentRoute,
        menuOpen: _menuOpen,
        onToggleMenu: () => setState(() => _menuOpen = !_menuOpen),
        onCloseMenu: () => setState(() => _menuOpen = false),
      ),
    );
  }
}

class _AppHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _AppHeaderDelegate({
    required this.currentRoute,
    required this.menuOpen,
    required this.onToggleMenu,
    required this.onCloseMenu,
  });

  final String currentRoute;
  final bool menuOpen;
  final VoidCallback onToggleMenu;
  final VoidCallback onCloseMenu;

  static const _items = [
    ('Басты бет', '/'),
    ('Грант тексеру', '/grant'),
    ('ЖОО-лар', '/universities'),
    ('Мамандықтар', '/programs'),
    ('Біз туралы', '/about'),
  ];

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final elevated = shrinkOffset > 0 || overlapsContent;

    return Material(
      color: Colors.white.withValues(alpha: 0.96),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.96),
          border: const Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
          boxShadow: [
            BoxShadow(
              color: const Color(
                0xFF172033,
              ).withValues(alpha: elevated ? 0.08 : 0),
              blurRadius: elevated ? 18 : 0,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 1080;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 72,
                          child: Row(
                            children: [
                              Flexible(
                                flex: 0,
                                child: _Logo(
                                  onTap: () => _navigate(context, '/', compact),
                                ),
                              ),
                              const Spacer(),
                              if (compact)
                                IconButton(
                                  tooltip: 'Мәзір',
                                  onPressed: onToggleMenu,
                                  icon: Icon(
                                    menuOpen
                                        ? Icons.close_rounded
                                        : Icons.menu_rounded,
                                    color: const Color(0xFF172033),
                                  ),
                                )
                              else
                                Flexible(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Flexible(
                                        child: _NavItems(
                                          items: _items,
                                          currentRoute: currentRoute,
                                          onNavigate:
                                              (route) => _navigate(
                                                context,
                                                route,
                                                compact,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      AnimatedPrimaryButton(
                                        compact: true,
                                        label: 'Тексеру',
                                        onPressed:
                                            () => _navigate(
                                              context,
                                              '/grant',
                                              compact,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (compact && menuOpen)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _NavItems(
                                  items: _items,
                                  currentRoute: currentRoute,
                                  vertical: true,
                                  onNavigate:
                                      (route) =>
                                          _navigate(context, route, compact),
                                ),
                                const SizedBox(height: 14),
                                AnimatedPrimaryButton(
                                  compact: true,
                                  label: 'Тексеру',
                                  onPressed:
                                      () =>
                                          _navigate(context, '/grant', compact),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context, String route, bool compact) {
    if (compact) onCloseMenu();
    if (ModalRoute.of(context)?.settings.name == route) return;
    Navigator.pushNamed(context, route);
  }

  @override
  double get maxExtent => menuOpen ? 390 : 76;

  @override
  double get minExtent => 76;

  @override
  bool shouldRebuild(covariant _AppHeaderDelegate oldDelegate) {
    return currentRoute != oldDelegate.currentRoute ||
        menuOpen != oldDelegate.menuOpen;
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFE6F7F8),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.school_rounded,
                color: Color(0xFF07848C),
                size: 24,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'UniChance',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFF172033),
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItems extends StatelessWidget {
  const _NavItems({
    required this.items,
    required this.currentRoute,
    required this.onNavigate,
    this.vertical = false,
  });

  final List<(String, String)> items;
  final String currentRoute;
  final ValueChanged<String> onNavigate;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final children =
        items.map((item) {
          return _NavItem(
            label: item.$1,
            active: currentRoute == item.$2,
            onTap: () => onNavigate(item.$2),
          );
        }).toList();

    if (vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      );
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerRight,
      child: Row(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final highlighted = widget.active || _hovered;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        decoration: BoxDecoration(
          color: widget.active ? const Color(0xFFE6F7F8) : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: TextButton(
          onPressed: widget.onTap,
          style: TextButton.styleFrom(
            foregroundColor:
                highlighted ? const Color(0xFF07848C) : const Color(0xFF172033),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          child: Text(widget.label, overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
