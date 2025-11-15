import 'package:flutter/material.dart';
import 'package:EduProf/Semestre/principal_semestres.dart';
import 'package:EduProf/Profesores/principal_profesores.dart';
import 'package:EduProf/Botones_Barra/botones_barra_baja.dart';
import 'package:EduProf/Config/user_prefs.dart';
import 'package:EduProf/Config/preferences_screen.dart';
import 'package:EduProf/Botones_Barra/favoritos_screen.dart';
import 'package:EduProf/Config/about_screen.dart';

class MyHomePage extends StatelessWidget {
  final ThemeController themeCtrl;
  final String title;

  const MyHomePage({super.key, required this.title, required this.themeCtrl});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF0F4FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: themeCtrl.seedColor,
        title: const Text(
          'EduProf',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          // Acerca de EduProf
          IconButton(
            tooltip: 'Acerca de EduProf',
            icon: const Icon(Icons.info_outline_rounded, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AboutScreen(controller: themeCtrl),
                ),
              );
            },
          ),

          //Preferencias
          IconButton(
            tooltip: 'Preferencias',
            icon: const Icon(Icons.settings_rounded, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PreferencesScreen(controller: themeCtrl),
                ),
              );
            },
          ),
        ],
      ),

      body: SafeArea(child: _HomeHeroTabs(themeCtrl: themeCtrl)),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _HomeHeroTabs extends StatefulWidget {
  final ThemeController themeCtrl;
  const _HomeHeroTabs({required this.themeCtrl});

  @override
  State<_HomeHeroTabs> createState() => _HomeHeroTabsState();
}

class _HomeHeroTabsState extends State<_HomeHeroTabs> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final seed = widget.themeCtrl.seedColor;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TopGreeting(seed: seed),
          const SizedBox(height: 10),
          _HeroBanner(seed: seed),

          const SizedBox(height: 18),

          _TabSelector(
            index: _tabIndex,
            onChanged: (i) => setState(() => _tabIndex = i),
            seed: seed,
          ),

          const SizedBox(height: 14),

          if (_tabIndex == 0)
            _TabRamos(seed: seed)
          else
            _TabProfesores(seed: seed),

          const SizedBox(height: 22),

          const _SectionTitle('Malla curricular'),
          const SizedBox(height: 8),
          _MallaCard(
            onFull: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MallaFullScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TabSelector extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  final Color seed;

  const _TabSelector({
    required this.index,
    required this.onChanged,
    required this.seed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _Segment(
            label: 'Ramos',
            selected: index == 0,
            seed: seed,
            onTap: () => onChanged(0),
          ),
          _Segment(
            label: 'Profesores',
            selected: index == 1,
            seed: seed,
            onTap: () => onChanged(1),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color seed;

  const _Segment({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.seed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? seed : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

class _TabRamos extends StatelessWidget {
  final Color seed;
  const _TabRamos({required this.seed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ListCard(
          icon: Icons.school_rounded,
          title: 'Explorar por semestres',
          subtitle: 'Revisa todos los ramos organizados por año.',
          seed: seed,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PrincipalSemestres()),
            );
          },
        ),
        const SizedBox(height: 10),
        _ListCard(
          icon: Icons.star_border_rounded,
          title: 'Mis ramos favoritos',
          subtitle: 'Accede rápido a los que más te interesan.',
          seed: seed,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const FavoritosScreen(initialTab: FavoritosTab.ramos),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _TabProfesores extends StatelessWidget {
  final Color seed;
  const _TabProfesores({required this.seed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ListCard(
          icon: Icons.person_search_rounded,
          title: 'Listado de profesores',
          subtitle: 'Conoce quién hace clases en la carrera.',
          seed: seed,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PrincipalProfesores()),
            );
          },
        ),
        const SizedBox(height: 10),
        _ListCard(
          icon: Icons.favorite_border_rounded,
          title: 'Profesores favoritos',
          subtitle: 'Guarda los docentes que más te interesan.',
          seed: seed,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const FavoritosScreen(initialTab: FavoritosTab.profesores),
              ),
            );
          },
        ),
      ],
    );
  }
}

//widgets usados en el home

class _TopGreeting extends StatelessWidget {
  final Color seed;
  const _TopGreeting({required this.seed});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hola, estudiante 👋',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: seed.withOpacity(.9),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final Color seed;
  const _HeroBanner({required this.seed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [seed, seed.withOpacity(.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tu carrera, organizada',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Cambia de pestaña para ver ramos o profesores rápidamente.',
            style: TextStyle(color: Color(0xFFECECFF), fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _ListCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color seed;
  final VoidCallback onTap;

  const _ListCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.seed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: seed.withOpacity(.12),
                child: Icon(icon, size: 20, color: seed),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.black38),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
    );
  }
}

class _MallaCard extends StatelessWidget {
  final VoidCallback onFull;
  const _MallaCard({required this.onFull});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'malla-hero',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              const AspectRatio(
                aspectRatio: 13 / 9,
                child: Image(
                  image: AssetImage('assets/Malla.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.45),
                  ),
                  icon: const Icon(Icons.fullscreen, color: Colors.white),
                  onPressed: onFull,
                  tooltip: 'Ver malla completa',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MallaFullScreen extends StatelessWidget {
  const MallaFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Malla Curricular',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Hero(
        tag: 'malla-hero',
        child: InteractiveViewer(
          panEnabled: true,
          boundaryMargin: const EdgeInsets.all(80),
          minScale: 1.0,
          maxScale: 4.0,
          child: const Center(
            child: Image(
              image: AssetImage('assets/Malla.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
