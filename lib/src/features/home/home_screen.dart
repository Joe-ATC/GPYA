import 'package:flutter/material.dart';
import 'package:myapp/widgets/app_header.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Función para lanzar URLs
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('No se pudo lanzar $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const phoneNumber = "525583252920";
    const message = "Hola quiero más información sobre...";
    final whatsappUrl = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const AppHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Consultoría Integral para Empresas',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Navegue el complejo panorama legal y regulatorio de México con un aliado estratégico a su lado. En Padilla y Aguilar, garantizamos la seguridad, cumplimiento y continuidad de su negocio.',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => context.go('/dashboard'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      'Acceder a la Documentación',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 48),
                  const _FeatureHighlight(),
                  const SizedBox(height: 48),
                  const _ComingSoon(),
                  const SizedBox(height: 48),
                  _ContactInfo(launchUrl: _launchUrl),
                  const SizedBox(height: 32), // Espacio al final
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _launchUrl(whatsappUrl),
        backgroundColor: Colors.transparent, // Fondo transparente
        elevation: 0,
        tooltip: 'Contactar por WhatsApp',
        child: Image.asset('assets/icon/logo-wp.png'), // Usa la nueva imagen
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  final Future<void> Function(String) launchUrl;
  const _ContactInfo({required this.launchUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contacto',
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _ContactItem(
          icon: Icons.phone_outlined,
          text: '55 1234 5678',
          onTap: () => launchUrl('tel:525512345678'),
        ),
        const SizedBox(height: 12),
        _ContactItem(
          icon: Icons.email_outlined,
          text: 'contacto@gpya.com.mx',
          onTap: () => launchUrl('mailto:contacto@gpya.com.mx'),
        ),
        const SizedBox(height: 12),
        _ContactItem(
          icon: Icons.location_on_outlined,
          text: 'Av. Paseo de la Reforma 222, CDMX, México',
          onTap: () => launchUrl('https://maps.google.com/?q=Paseo+de+la+Reforma+222+CDMX'),
        ),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _ContactItem({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.secondary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(text, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComingSoon extends StatelessWidget {
  const _ComingSoon();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Próximamente',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        const Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _Bubble(text: 'Capacitaciones'),
            _Bubble(text: 'Noticias y Alertas'),
            _Bubble(text: 'Gestión de Trámites'),
          ],
        ),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  final String text;
  const _Bubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      labelStyle: Theme.of(context).textTheme.bodyMedium,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}

class _FeatureHighlight extends StatelessWidget {
  const _FeatureHighlight();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _FeatureItem(
          icon: Icons.shield_outlined,
          title: 'Cumplimiento Garantizado',
          description: 'Expertos en normativas para mantener su empresa segura y en regla.',
        ),
        SizedBox(height: 24),
        _FeatureItem(
          icon: Icons.gavel_rounded,
          title: 'Asesoría Legal Estratégica',
          description: 'Soluciones legales que protegen sus intereses y fomentan el crecimiento.',
        ),
        SizedBox(height: 24),
        _FeatureItem(
          icon: Icons.health_and_safety_outlined,
          title: 'Planes de Protección Civil',
          description: 'Certificación y tranquilidad ante cualquier eventualidad.',
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: theme.colorScheme.secondary, size: 30),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(description, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
