import 'package:flutter/material.dart';
import 'package:myapp/widgets/app_header.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                    onPressed: () => context.go('/servicios'), 
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      'Explore Nuestros Servicios',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 48),
                  const _FeatureHighlight(),
                ],
              ),
            ),
          ],
        ),
      ),
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
