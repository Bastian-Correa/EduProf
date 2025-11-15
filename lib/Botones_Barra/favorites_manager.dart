import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesManager extends ChangeNotifier {
  FavoritesManager._() {
    _load();
  }
  static final FavoritesManager i = FavoritesManager._();

  static const _storageKey = 'favorites_keys_v1';

  final Set<String> _keys = <String>{};
  bool _loaded = false;

  bool get isLoaded => _loaded;
  List<String> get all => _keys.toList(growable: false);
  List<String> get ramoKeys =>
      _keys.where((k) => k.startsWith('ramo:')).toList(growable: false);
  List<String> get profKeys =>
      _keys.where((k) => k.startsWith('prof:')).toList(growable: false);

  bool isFav(String key) => _keys.contains(key);

  bool toggle(String key) {
    final nowFav = !_keys.contains(key);
    if (nowFav) {
      _keys.add(key);
    } else {
      _keys.remove(key);
    }
    _save();
    notifyListeners();
    return nowFav;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_storageKey) ?? const <String>[];
    _keys
      ..clear()
      ..addAll(list);
    _loaded = true;
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_storageKey, _keys.toList(growable: false));
  }
}
