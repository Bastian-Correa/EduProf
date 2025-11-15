import 'package:flutter/material.dart';
import 'package:EduProf/Semestre/semestre_tab.dart';
import 'package:EduProf/Botones_Barra/Botones_barra_baja.dart';

class AnoDetalleScreen extends StatelessWidget {
  final int ano;
  const AnoDetalleScreen({super.key, required this.ano});

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;

    final bool hasSecondSemester = ano < 5;
    final int tabCount = hasSecondSemester ? 2 : 1;

    return DefaultTabController(
      length: tabCount,
      child: Scaffold(
        appBar: AppBar(title: Text('Año $ano')),
        body: Column(
          children: [
            const SizedBox(height: 8),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.black12),
              ),
              child: TabBar(
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                labelColor: seed,
                unselectedLabelColor: Colors.black45,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3, color: seed),
                  insets: const EdgeInsets.fromLTRB(24, 0, 24, 4),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: hasSecondSemester
                    ? const [Tab(text: 'Semestre 1'), Tab(text: 'Semestre 2')]
                    : const [Tab(text: 'Semestre 1')],
              ),
            ),

            const SizedBox(height: 8),
            const Divider(height: 1),

            // Contenido deslizable
            Expanded(
              child: TabBarView(
                children: hasSecondSemester
                    ? [
                        SemestreTab(ano: ano, semestre: 1),
                        SemestreTab(ano: ano, semestre: 2),
                      ]
                    : [SemestreTab(ano: ano, semestre: 1)],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const AppBottomNav(currentIndex: 0), // ⬅️ NUEVO
      ),
    );
  }
}
