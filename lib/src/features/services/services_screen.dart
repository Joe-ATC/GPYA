import 'package:flutter/material.dart';
import 'package:myapp/widgets/app_header.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Nuestros Servicios',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Soluciones legales y de cumplimiento a la medida de su empresa.',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 32),
                  const _ServiceCard(
                    icon: Icons.gavel_rounded,
                    title: 'Asesoría Legal Corporativa',
                    description: 'Ofrecemos un soporte legal integral que abarca desde la constitución de sociedades hasta la gestión de contratos y la resolución de disputas comerciales.',
                  ),
                  const SizedBox(height: 16),
                  const _ServiceCard(
                    icon: Icons.shield_outlined,
                    title: 'Cumplimiento Normativo (Compliance)',
                    description: 'Ayudamos a su empresa a navegar el complejo entorno regulatorio, asegurando el cumplimiento de las normativas aplicables y minimizando riesgos.',
                  ),
                  const SizedBox(height: 16),
                  const _ServiceCard(
                    icon: Icons.health_and_safety_outlined,
                    title: 'Protección Civil',
                    description: 'Preparamos a su empresa para responder eficazmente ante emergencias. Diseñamos planes internos, capacitamos a brigadas y realizamos simulacros con certificación oficial.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
