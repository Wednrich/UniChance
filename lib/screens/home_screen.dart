import 'package:flutter/material.dart';

import '../widgets/animated_primary_button.dart';
import '../widgets/app_footer.dart';
import '../widgets/app_header.dart';
import '../widgets/decorative_background.dart';
import '../widgets/home_hero.dart';
import '../widgets/info_card.dart';
import '../widgets/page_container.dart';
import '../widgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _visible = true;

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
          duration: const Duration(milliseconds: 420),
          child: CustomScrollView(
            slivers: [
              const AppHeader(currentRoute: '/'),
              const SliverToBoxAdapter(
                child: PageContainer(
                  padding: EdgeInsets.fromLTRB(20, 58, 20, 74),
                  child: HomeHero(),
                ),
              ),
              const SliverToBoxAdapter(child: _PlatformCardsSection()),
              const SliverToBoxAdapter(child: _UntInfoSection()),
              const SliverToBoxAdapter(child: _ProjectSection()),
              const SliverToBoxAdapter(child: _HomeCtaSection()),
              const SliverToBoxAdapter(child: AppFooter()),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlatformCardsSection extends StatelessWidget {
  const _PlatformCardsSection();

  @override
  Widget build(BuildContext context) {
    const cards = [
      InfoCard(
        icon: Icons.analytics_rounded,
        title: 'Грант мүмкіндігін тексеру',
        description:
            'ҰБТ балың мен таңдау пәндерің арқылы грантқа түсу ықтималдығын көр.',
      ),
      InfoCard(
        icon: Icons.compare_arrows_rounded,
        title: 'ЖОО-ларды салыстыру',
        description:
            'Қала, жатақхана, әскери кафедра және оқу бағыты бойынша университеттерді қара.',
      ),
      InfoCard(
        icon: Icons.manage_search_rounded,
        title: 'Мамандықтарды пән бойынша іздеу',
        description:
            'Таңдау пәндеріңе сәйкес келетін бағдарламаларды тез тауып ал.',
      ),
      InfoCard(
        icon: Icons.payments_rounded,
        title: 'Оқу ақысы мен талаптарды көру',
        description:
            'Ақылы оқу шегі, оқу ақысы және дерек жылы секілді маңызды ақпаратты бір жерден көр.',
      ),
    ];

    return PageContainer(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Платформа мүмкіндіктері',
            subtitle:
                'Талапкерге керек негізгі шешімдерді жеңіл әрі түсінікті форматта жинадық.',
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final count =
                  width > 1020
                      ? 4
                      : width > 700
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cards.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: count == 1 ? 1.85 : 1.08,
                ),
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return InfoCard(
                    icon: card.icon,
                    title: card.title,
                    description: card.description,
                    delay: Duration(milliseconds: index * 80),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _UntInfoSection extends StatelessWidget {
  const _UntInfoSection();

  @override
  Widget build(BuildContext context) {
    const cards = [
      InfoCard(
        icon: Icons.quiz_rounded,
        title: 'ҰБТ деген не?',
        description:
            'ҰБТ — жоғары оқу орнына түсу үшін тапсырылатын негізгі емтихан.',
      ),
      InfoCard(
        icon: Icons.tune_rounded,
        title: 'Таңдау пәндері не үшін керек?',
        description:
            'Таңдау пәндері сен тапсыра алатын мамандықтар тобын анықтайды.',
      ),
      InfoCard(
        icon: Icons.workspace_premium_rounded,
        title: 'Грант конкурсы қалай жүреді?',
        description:
            'Гранттар балл, пән бағыты, квота және конкурс нәтижесіне қарай бөлінеді.',
      ),
      InfoCard(
        icon: Icons.flag_rounded,
        title: 'Шекті балл не білдіреді?',
        description:
            'Шекті балл — белгілі бір бағдарламаға қатысуға қажет ең төменгі деңгей.',
      ),
    ];

    return PageContainer(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 72),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.82),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: 'ҰБТ туралы ақпарат',
              subtitle:
                  'Грантқа дайындалғанда жиі кездесетін ұғымдарды қысқа әрі нақты түсіндіреміз.',
            ),
            const SizedBox(height: 26),
            LayoutBuilder(
              builder: (context, constraints) {
                final count = constraints.maxWidth > 760 ? 2 : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cards.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: count,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    childAspectRatio: count == 1 ? 2.05 : 1.95,
                  ),
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    return InfoCard(
                      icon: card.icon,
                      title: card.title,
                      description: card.description,
                      delay: Duration(milliseconds: index * 70),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectSection extends StatelessWidget {
  const _ProjectSection();

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 72),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final desktop = constraints.maxWidth >= 860;
          final text = Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(title: 'Жоба туралы'),
                SizedBox(height: 18),
                Text(
                  'UniChance — талапкерлерге университет пен мамандық таңдауды жеңілдету үшін жасалған жоба. Мұнда оқушы өз балын енгізіп, грантқа түсу мүмкіндігін, ЖОО тізімін және мамандықтарды көре алады.',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 17,
                    height: 1.65,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );

          const founder = _FounderCard();

          if (desktop) {
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 7, child: text),
                  const SizedBox(width: 22),
                  const Expanded(flex: 4, child: founder),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [text, const SizedBox(height: 18), founder],
          );
        },
      ),
    );
  }
}

class _FounderCard extends StatelessWidget {
  const _FounderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF05636A),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF05636A).withValues(alpha: 0.22),
            blurRadius: 28,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: Color(0xFFE6F7F8),
            child: Icon(
              Icons.person_rounded,
              color: Color(0xFF07848C),
              size: 36,
            ),
          ),
          SizedBox(height: 22),
          Text(
            'Жобаны жасаушы',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Талапкерлерге пайдалы әрі түсінікті сервис жасау мақсатында құрылған.',
            style: TextStyle(
              color: Color(0xFFCDEDEF),
              height: 1.55,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeCtaSection extends StatelessWidget {
  const _HomeCtaSection();

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 82),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(34),
        decoration: BoxDecoration(
          color: const Color(0xFF07848C),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF07848C).withValues(alpha: 0.20),
              blurRadius: 32,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Wrap(
          spacing: 22,
          runSpacing: 18,
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const SizedBox(
              width: 680,
              child: Text(
                'Қай университетке түсе алатыныңды қазір тексер',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  height: 1.15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            AnimatedPrimaryButton(
              label: 'Мүмкіндікті анықтау',
              icon: Icons.arrow_forward_rounded,
              secondary: true,
              onPressed: () => Navigator.pushNamed(context, '/grant'),
            ),
          ],
        ),
      ),
    );
  }
}
