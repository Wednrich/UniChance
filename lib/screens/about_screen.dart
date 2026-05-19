import 'package:flutter/material.dart';

import '../widgets/app_footer.dart';
import '../widgets/app_header.dart';
import '../widgets/decorative_background.dart';
import '../widgets/page_container.dart';
import '../widgets/section_title.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFA),
      body: DecorativeBackground(
        child: CustomScrollView(
          slivers: [
            const AppHeader(currentRoute: '/about'),
            SliverToBoxAdapter(
              child: PageContainer(
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(
                        title: 'Біз туралы',
                        subtitle:
                            'UniChance талапкерлерге ЖОО мен мамандық таңдауға және грант мүмкіндігін тексеруге көмектеседі.',
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Платформадағы деректер талапкерге бірнеше оқу бағытын салыстырып, өзіне қолайлы шешім қабылдауға арналған. Нәтижелер болжам ретінде көрсетіледі және нақты грант нәтижесіне кепілдік бермейді.',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 17,
                          height: 1.6,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: AppFooter()),
          ],
        ),
      ),
    );
  }
}
