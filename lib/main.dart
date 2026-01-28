import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:myapp/screens/splash_screen.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/dashboard_screen.dart';
import 'package:myapp/screens/services_screen.dart';
import 'package:myapp/screens/settings_screen.dart';

final GlobalKey<DashboardScreenState> _dashboardKey = GlobalKey<DashboardScreenState>();

final List<Widget> _widgetOptions = <Widget>[
  const HomeScreen(),
  DashboardScreen(key: _dashboardKey),
  const ServicesScreen(),
  SettingsScreen(dashboardKey: _dashboardKey),
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ifbmzqzxvogewkekapcv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlmYm16cXp4dm9nZXdrZWthcGN2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njk1MzAwMjQsImV4cCI6MjA4NTEwNjAyNH0.K3DZB5QmLs-HnkAz5dkokUkHODzXj-CUW2MN8gMHqgs',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBlack = Color(0xFF1A1A1A);
    const Color accentRed = Color(0xFFD32F2F);
    const Color textWhite = Color(0xFFEAEAEA);

    final TextTheme appTextTheme = TextTheme(
      displayLarge: GoogleFonts.montserrat(fontSize: 48, fontWeight: FontWeight.bold, color: textWhite),
      titleLarge: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w600, color: textWhite),
      bodyMedium: GoogleFonts.montserrat(fontSize: 14, color: textWhite.withAlpha(220)),
      labelLarge: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: textWhite),
    );

    return MaterialApp(
      title: 'Grupo Padilla y Aguilar',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: primaryBlack,
        colorScheme: const ColorScheme.dark(
          primary: accentRed,
          secondary: accentRed,
          surface: primaryBlack,
          surfaceContainer: Color(0xFF2C2C2C),
          onPrimary: textWhite,
          onSecondary: textWhite,
          onSurface: textWhite,
        ),
        textTheme: appTextTheme,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: primaryBlack,
          selectedItemColor: accentRed,
          unselectedItemColor: Colors.grey[600],
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_copy_rounded),
            label: 'Documentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.construction_rounded),
            label: 'Servicios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Ajustes',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
