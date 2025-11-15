import 'package:flutter/material.dart';
import 'package:EduProf/Botones_Barra/botones_barra_baja.dart';
import 'package:EduProf/Botones_Barra/favorites_manager.dart';
import 'package:EduProf/Base de datos/academico.dart';
import 'package:EduProf/Modelos/ramo.dart';
import 'package:EduProf/Modelos/profesor.dart';
import 'package:EduProf/Semestre/ramo_detalle.dart';
import 'package:EduProf/Profesores/profesor_detalle.dart';

enum FavoritosTab { ramos, profesores }

class FavoritosScreen extends StatefulWidget {
  final FavoritosTab initialTab;

  const FavoritosScreen({super.key, this.initialTab = FavoritosTab.ramos});

  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab == FavoritosTab.ramos ? 0 : 1,
    );

    FavoritesManager.i.addListener(_onFavsChanged);
  }

  void _onFavsChanged() => setState(() {});

  @override
  void dispose() {
    FavoritesManager.i.removeListener(_onFavsChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;
    final ramoIds = FavoritesManager.i.ramoKeys;
    final profIds = FavoritesManager.i.profKeys;

    final ramos = ramoIds
        .map((k) => ramoById(k.replaceFirst('ramo:', '')))
        .whereType<Ramo>()
        .toList();

    final profes = profIds
        .map((k) => profesorById(k.replaceFirst('prof:', '')))
        .whereType<Profesor>()
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.black12),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: seed,
                borderRadius: BorderRadius.circular(999),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black87,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: 'Ramos'),
                Tab(text: 'Profesores'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _FavoritosRamosList(ramos: ramos),
                _FavoritosProfesList(profesores: profes),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    );
  }
}

// Lista de ramos favoritos

class _FavoritosRamosList extends StatelessWidget {
  final List<Ramo> ramos;
  const _FavoritosRamosList({required this.ramos});

  @override
  Widget build(BuildContext context) {
    if (ramos.isEmpty) {
      return const Center(
        child: Text(
          'Aún no tienes ramos en favoritos.',
          style: TextStyle(color: Colors.black54),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: ramos.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final r = ramos[index];
        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RamoDetalle(ramo: r)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              child: Row(
                children: [
                  const Icon(Icons.menu_book_rounded),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      r.nombre,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.black38,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FavoritosProfesList extends StatelessWidget {
  final List<Profesor> profesores;
  const _FavoritosProfesList({required this.profesores});

  @override
  Widget build(BuildContext context) {
    if (profesores.isEmpty) {
      return const Center(
        child: Text(
          'Aún no tienes profesores en favoritos.',
          style: TextStyle(color: Colors.black54),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: profesores.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final p = profesores[index];
        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfesorDetalle(profesor: p)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              child: Row(
                children: [
                  const Icon(Icons.person_rounded),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      p.nombre,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.black38,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
