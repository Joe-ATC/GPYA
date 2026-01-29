import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51), // CORREGIDO: Opacidad válida
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: SafeArea(
        bottom: false, // No padding at the bottom of the SafeArea
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Usamos el logo en formato SVG para calidad perfecta
            SvgPicture.asset(
              'assets/images/logo.svg', 
              height: 40, 
              colorFilter: ColorFilter.mode(theme.colorScheme.primary, BlendMode.srcIn),
            ),
            const SizedBox(width: 12),
            // Nombre de la empresa
            Text(
              'Grupo Padilla y Aguilar',
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
