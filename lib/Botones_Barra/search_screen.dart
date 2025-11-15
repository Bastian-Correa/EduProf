import 'package:flutter/material.dart';
import 'package:EduProf/Base de datos/academico.dart';
import 'package:EduProf/Semestre/ramo_detalle.dart';
import 'package:EduProf/Profesores/profesor_detalle.dart';
import 'package:EduProf/Botones_Barra/botones_barra_baja.dart';

String _fold(String s) {
  // Normaliza a minúsculas y elimina tildes/acentos comunes
  const withAccents = 'áàäâãåéèëêíìïîóòöôõúùüûñçÁÀÄÂÃÅÉÈËÊÍÌÏÎÓÒÖÔÕÚÙÜÛÑÇ';
  const without = 'aaaaaaeeeeiiiiooooouuuuncAAAAAAEEEEIIIIOOOOOUUUUNC';
  final map = <int, String>{};
  for (var i = 0; i < withAccents.length; i++) {
    map[withAccents.codeUnitAt(i)] = without[i];
  }
  final sb = StringBuffer();
  for (final rune in s.runes) {
    final ch = String.fromCharCode(rune);
    sb.write(map[rune] ?? ch);
  }
  return sb.toString().toLowerCase();
}

bool _matchNombre(String nombre, String query) {
  if (query.trim().isEmpty) return true;
  return _fold(nombre).contains(_fold(query));
}

// UI
class _SearchResult {
  final String tipo; // Ramo y Profesor
  final String titulo;
  final VoidCallback onTap;
  _SearchResult({
    required this.tipo,
    required this.titulo,
    required this.onTap,
  });
}

enum _FiltroTipo { todo, ramos, profesores }

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final _focus = FocusNode();

  List<_SearchResult> _results = [];
  _FiltroTipo _filtro = _FiltroTipo.todo;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onQueryChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onQueryChanged);
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _onQueryChanged() => _doSearch(_controller.text.trim());

  // Búsqueda
  void _doSearch(String query) {
    final res = <_SearchResult>[];

    final wantsRamos =
        _filtro == _FiltroTipo.todo || _filtro == _FiltroTipo.ramos;
    final wantsProf =
        _filtro == _FiltroTipo.todo || _filtro == _FiltroTipo.profesores;

    if (wantsRamos) {
      final allRamos = ramosPorSemestre.values.expand((e) => e);
      for (final r in allRamos) {
        if (_matchNombre(r.nombre, query)) {
          res.add(
            _SearchResult(
              tipo: 'Ramo',
              titulo: r.nombre,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RamoDetalle(ramo: r)),
                );
              },
            ),
          );
        }
      }
    }

    if (wantsProf) {
      for (final p in profesores) {
        if (_matchNombre(p.nombre, query)) {
          res.add(
            _SearchResult(
              tipo: 'Profesor',
              titulo: p.nombre,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfesorDetalle(profesor: p),
                  ),
                );
              },
            ),
          );
        }
      }
    }

    // Orden, Ramos primero, luego Profesores
    res.sort((a, b) {
      final t = a.tipo.compareTo(b.tipo);
      return t != 0 ? t : a.titulo.compareTo(b.titulo);
    });

    setState(() => _results = res);
  }

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        title: const Text('Buscar', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: _SearchField(
              controller: _controller,
              focusNode: _focus,
              hint: 'Buscar ramo o profesor',
              onClear: () {
                _controller.clear();
                _doSearch('');
                _focus.requestFocus();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: _FiltroChips(
              value: _filtro,
              onChanged: (v) {
                setState(() => _filtro = v);
                _doSearch(_controller.text.trim());
              },
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: _results.isEmpty
                ? _EmptyState(query: _controller.text)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    itemBuilder: (_, i) => _ResultTile(result: _results[i]),
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemCount: _results.length,
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }
}

// Widget
class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final VoidCallback onClear;
  const _SearchField({
    required this.controller,
    required this.focusNode,
    required this.hint,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final hasText = controller.text.isNotEmpty;
    return Material(
      borderRadius: BorderRadius.circular(14),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            const Icon(Icons.search_rounded, color: Colors.black45),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                ),
                textInputAction: TextInputAction.search,
              ),
            ),
            if (hasText)
              IconButton(
                tooltip: 'Limpiar',
                onPressed: onClear,
                icon: const Icon(Icons.close_rounded),
              ),
          ],
        ),
      ),
    );
  }
}

class _FiltroChips extends StatelessWidget {
  final _FiltroTipo value;
  final ValueChanged<_FiltroTipo> onChanged;
  const _FiltroChips({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).colorScheme.primary;

    ChoiceChip chip(String text, _FiltroTipo v) => ChoiceChip(
      label: Text(text),
      selected: value == v,
      onSelected: (_) => onChanged(v),
      selectedColor: brand.withOpacity(.12),
      labelStyle: TextStyle(
        color: value == v ? brand : null,
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide(color: value == v ? brand : Colors.black26),
    );

    return Wrap(
      spacing: 8,
      children: [
        chip('Todo', _FiltroTipo.todo),
        chip('Ramos', _FiltroTipo.ramos),
        chip('Profesores', _FiltroTipo.profesores),
      ],
    );
  }
}

class _ResultTile extends StatelessWidget {
  final _SearchResult result;
  const _ResultTile({required this.result});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).colorScheme.primary;

    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        onTap: result.onTap,
        leading: CircleAvatar(
          backgroundColor: brand.withOpacity(.10),
          child: Icon(
            result.tipo == 'Ramo'
                ? Icons.menu_book_rounded
                : Icons.person_rounded,
            color: brand,
          ),
        ),
        title: Text(
          result.titulo,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Colors.black38,
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String query;
  const _EmptyState({required this.query});

  @override
  Widget build(BuildContext context) {
    final isEmpty = query.trim().isEmpty;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 48,
              color: Colors.black26,
            ),
            const SizedBox(height: 12),
            Text(
              isEmpty
                  ? 'Empieza a escribir para buscar'
                  : 'Sin resultados para "$query"',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
