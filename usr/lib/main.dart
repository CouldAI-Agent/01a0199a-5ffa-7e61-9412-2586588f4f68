import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ResumeApp());
}

class ResumeApp extends StatelessWidget {
  const ResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Resume',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ResumeScreen(),
      },
    );
  }
}

class ResumeScreen extends StatelessWidget {
  const ResumeScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: isMobile
                      ? _buildMobileLayout(context)
                      : _buildDesktopLayout(context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSidebar(context, isMobile: true),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: _buildMainContent(context),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: _buildSidebar(context, isMobile: false),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: _buildMainContent(context),
          ),
        ),
      ],
    );
  }

  Widget _buildSidebar(BuildContext context, {required bool isMobile}) {
    return Container(
      color: const Color(0xFF1E293B),
      padding: EdgeInsets.all(isMobile ? 32 : 40),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, size: 80, color: Colors.white),
          ),
          const SizedBox(height: 24),
          Text(
            'John Doe',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Senior Flutter Developer',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue[300],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _buildContactInfo(
            icon: Icons.email_outlined,
            text: 'john.doe@example.com',
            onTap: () => _launchUrl('mailto:john.doe@example.com'),
          ),
          _buildContactInfo(
            icon: Icons.phone_outlined,
            text: '+91 98765 43210',
            onTap: () => _launchUrl('tel:+919876543210'),
          ),
          _buildContactInfo(
            icon: Icons.location_on_outlined,
            text: 'New Delhi, India',
            onTap: null,
          ),
          const SizedBox(height: 32),
          _buildSectionTitle('SKILLS', isDark: true),
          const SizedBox(height: 16),
          _buildSkillChip('Flutter & Dart'),
          _buildSkillChip('Firebase & Supabase'),
          _buildSkillChip('REST APIs'),
          _buildSkillChip('State Management'),
          _buildSkillChip('UI/UX Design'),
        ],
      ),
    );
  }

  Widget _buildContactInfo({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white70, size: 20),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        skill,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('ABOUT ME', isDark: false),
        const SizedBox(height: 16),
        Text(
          'Passionate Flutter Developer with 4+ years of experience building high-quality, scalable, and visually appealing cross-platform applications. Strong expertise in UI/UX principles, state management, and API integrations.',
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 40),
        _buildSectionTitle('EXPERIENCE', isDark: false),
        const SizedBox(height: 24),
        _buildExperienceItem(
          title: 'Senior Mobile Developer',
          company: 'Tech Solutions Inc.',
          duration: 'Jan 2021 - Present',
          description:
              'Led a team of 4 developers to build a comprehensive e-commerce app in Flutter. Reduced app startup time by 40% and improved crash-free sessions to 99.9%.',
        ),
        const SizedBox(height: 24),
        _buildExperienceItem(
          title: 'Flutter Developer',
          company: 'Creative App Studio',
          duration: 'Mar 2019 - Dec 2020',
          description:
              'Developed and maintained 5+ apps published on App Store and Play Store. Implemented complex animations and custom UI components.',
        ),
        const SizedBox(height: 40),
        _buildSectionTitle('EDUCATION', isDark: false),
        const SizedBox(height: 24),
        _buildExperienceItem(
          title: 'Bachelor of Technology in Computer Science',
          company: 'XYZ University',
          duration: '2015 - 2019',
          description: 'Graduated with First Class Honors. Specialization in Mobile Computing.',
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, {required bool isDark}) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
        color: isDark ? Colors.white : const Color(0xFF1E293B),
      ),
    );
  }

  Widget _buildExperienceItem({
    required String title,
    required String company,
    required String duration,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2563EB),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              company,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              duration,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
