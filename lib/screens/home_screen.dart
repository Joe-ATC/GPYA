import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _launchUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir el enlace.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              theme.colorScheme.surface.withAlpha(230),
              Colors.black,
            ],
            center: Alignment.topLeft,
            radius: 1.5,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroSection(context),
                const SizedBox(height: 40),

                _buildSectionTitle(context, 'Nuestra Esencia'),
                _buildInfoCard(
                  context,
                  icon: Icons.business_center,
                  title: 'Grupo Padilla y Aguilar',
                  content: 'Empresa mexicana con más de 9 años de experiencia, especializada en asesoría, capacitación y cumplimiento en seguridad industrial, eléctrica, vial, salud ocupacional y protección civil.',
                ),
                const SizedBox(height: 16),
                _buildInfoCard(
                  context,
                  icon: Icons.verified,
                  title: 'Certificación Oficial REPSE',
                  content: 'Avalados ante la STPS, garantizando una empresa confiable y en cumplimiento con las disposiciones laborales vigentes.',
                ),
                const SizedBox(height: 40),

                _buildSectionTitle(context, 'Nuestra Trayectoria'),
                _buildStatsGrid(context),
                const SizedBox(height: 40),

                _buildSectionTitle(context, 'Filosofía Institucional'),
                _buildPhilosophyCard(context, 'Misión', 'Brindar servicios de capacitación, consultoría y cumplimiento normativo que impulsen la productividad y el bienestar de nuestros clientes, con un enfoque humano, técnico y profesional.'),
                const SizedBox(height: 16),
                _buildPhilosophyCard(context, 'Visión', 'Ser reconocidos como líderes nacionales en servicios especializados, consolidando una red de clientes satisfechos que confían en nuestra experiencia y compromiso.'),
                const SizedBox(height: 40),

                _buildSectionTitle(context, 'Contáctanos'),
                _buildContactInfo(context),
              ].animate(interval: 100.ms).fadeIn(duration: 500.ms).slideY(begin: 0.2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset('assets/icon/icon.png', height: 80),
          const SizedBox(height: 20),
          Text(
            'ESTAMOS LISTOS PARA INICIAR TU PROYECTO',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary, 
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, {required IconData icon, required String title, required String content}) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainer.withAlpha(150),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
            const SizedBox(width: 16),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(content, style: Theme.of(context).textTheme.bodySmall),
              ],
            )),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatsGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.8,
      children: [
        _buildStatCard(context, '9+', 'Años de Experiencia', Icons.calendar_today),
        _buildStatCard(context, '300+', 'Capacitaciones', Icons.school),
        _buildStatCard(context, '10k+', 'Horas Seguras', Icons.shield),
        _buildStatCard(context, '100%', 'Cumplimiento STPS', Icons.gavel),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label, IconData icon) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainer.withAlpha(150),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildPhilosophyCard(BuildContext context, String title, String content) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainer.withAlpha(150),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title.toUpperCase(), style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            const SizedBox(height: 8),
            Text(content, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainer.withAlpha(150),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.location_on, color: Theme.of(context).colorScheme.primary),
              title: const Text('Violetas Mza Al, Lte 30, Col. Lomas de Tecámac, CP 55765'),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Theme.of(context).colorScheme.primary),
              title: const Text('55 8325 2920'),
              onTap: () => _launchUrl(context, 'tel:5583252920'),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Theme.of(context).colorScheme.primary),
              title: const Text('proyectos@grupopadillayaguilar.com.mx'),
              onTap: () => _launchUrl(context, 'mailto:proyectos@grupopadillayaguilar.com.mx'),
            ),
             ListTile(
              leading: Icon(Icons.alternate_email, color: Theme.of(context).colorScheme.primary),
              title: const Text('area.tecnica@grupopadillayaguilar.com.mx'),
              onTap: () => _launchUrl(context, 'mailto:area.tecnica@grupopadillayaguilar.com.mx'),
            ),
          ],
        ),
      ),
    );
  }
}
