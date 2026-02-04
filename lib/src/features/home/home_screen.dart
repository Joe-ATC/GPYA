import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    final whatsappUrl =
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child:
                  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Hero Section
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  theme.colorScheme.primary,
                                  Color(
                                    0xFFB71C1C,
                                  ), // Un tono más oscuro de rojo
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'En casa nos esperan',
                                  style: theme.textTheme.headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Navegue el complejo panorama legal y regulatorio de México con un aliado estratégico a su lado. En Padilla y Aguilar, garantizamos la seguridad, cumplimiento y continuidad de su negocio.',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () => context.go('/dashboard'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor:
                                          theme.colorScheme.primary,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      'Acceder a la Documentación',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                      )
                      .animate()
                      .fade(duration: 500.ms)
                      .slideY(
                        begin: 0.1,
                        duration: 500.ms,
                        curve: Curves.easeOutQuart,
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
        child: Image.asset('assets/icon/logo-wp.png')
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.1, 1.1),
              duration: 2.seconds,
            ),
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
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.contact_support_outlined,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Contacto',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Ubicación
        _ContactCard(
          icon: Icons.location_on_rounded,
          title: 'Ubicación',
          content: 'Lomas de Tecamac, 55765 Santo Tomás Chiconautla, Mex',
          subtitle: 'Vicente Suárez Manzana 025...',
          onTap: () => launchUrl(
            'https://maps.google.com/?q=GRUPO+PADILLA+Y+AGUILAR+Lomas+de+Tecamac',
          ),
          accentColor: Colors.orange,
        ),
        const SizedBox(height: 16),

        // Teléfono
        _ContactCard(
          icon: Icons.phone_in_talk_rounded,
          title: 'Llámanos',
          content: '55 8325 2920',
          onTap: () => launchUrl('tel:525583252920'),
          accentColor: Colors.green,
        ),
        const SizedBox(height: 16),

        // Horarios
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.access_time_filled_rounded,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Horario de Atención',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'L-V: 09:00 - 17:00',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Sab: 09:00 - 13:00',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Correos
        Row(
          children: [
            Expanded(
              child: _ContactCard(
                icon: Icons.email_rounded,
                title: 'Proyectos',
                content: 'proyectos@...',
                onTap: () =>
                    launchUrl('mailto:proyectos@grupopadillayaguilar.com.mx'),
                accentColor: Colors.purple,
                isSmall: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ContactCard(
                icon: Icons.build_rounded,
                title: 'Área Técnica',
                content: 'tecnica@...',
                onTap: () => launchUrl(
                  'mailto:area.tecnica@grupopadillayaguilar.com.mx',
                ),
                accentColor: Colors.teal,
                isSmall: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final String? subtitle;
  final VoidCallback onTap;
  final Color accentColor;
  final bool isSmall;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.content,
    this.subtitle,
    required this.onTap,
    this.accentColor = Colors.blue,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accentColor, size: isSmall ? 20 : 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            if (!isSmall)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.grey[400],
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
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
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
    return Column(
      children: [
        const _FeatureItem(
          icon: Icons.shield_outlined,
          title: 'Cumplimiento',
          description:
              'En un entorno que evoluciona rápidamente, la capacitación continua no solo es un aspecto deseable, sino una necesidad crítica.',
        ),
        const SizedBox(height: 24),
        const _FeatureItem(
          icon: Icons.gavel_rounded,
          title: 'Asesoría',
          description:
              'Planes de cumplimiento integral para tu empresa o institución.',
        ),
        const SizedBox(height: 24),
        const _FeatureItem(
          icon: Icons.health_and_safety_outlined,
          title: 'Consultoría',
          description:
              'Solución integral a las necesidades de tu empresa en materia de estudios de ambiente laboral y normas oficiales mexicanas.',
        ),
      ].animate(interval: 200.ms).fade().slideX(begin: 0.2),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Efecto 3D removido por solicitud
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 30),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(description, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
