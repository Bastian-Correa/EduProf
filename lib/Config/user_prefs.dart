import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Colores de marca
const Color kBrandRed = Color.fromARGB(255, 163, 31, 31); // Rojo UTalca
const Color kBrandPurple = Color(0xFF6C63FF); // Morado EduProf
const Color kBrandGreen = Color(0xFF2ECC71); // Verde suave
const Color kBrandBlue = Color(0xFF3498DB); // Azul pastel

/// Temas de color disponibles
enum AppBrandColor { red, purple, green, blue }

/// Tamaño de fuente
enum AppTextScale { normal, large }

/// Tipo de letra
enum AppFont { system, sans, serif, rounded }

class UserPrefsService {
  static const _kBrandKey = 'brand_color';
  static const _kTextScaleKey = 'text_scale';
  static const _kFontKey = 'font_family_v1';

  Future<void> saveBrand(AppBrandColor brand) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(_kBrandKey, brand.index);
  }

  Future<void> saveTextScale(AppTextScale scale) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(_kTextScaleKey, scale.index);
  }

  Future<void> saveFont(AppFont font) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(_kFontKey, font.index);
  }

  Future<(AppBrandColor, AppTextScale, AppFont)> loadAll() async {
    final sp = await SharedPreferences.getInstance();

    final brand = AppBrandColor
        .values[sp.getInt(_kBrandKey) ?? AppBrandColor.purple.index];

    final scale = AppTextScale
        .values[sp.getInt(_kTextScaleKey) ?? AppTextScale.normal.index];

    final font = AppFont.values[sp.getInt(_kFontKey) ?? AppFont.system.index];

    return (brand, scale, font);
  }
}

class ThemeController extends ChangeNotifier {
  final _service = UserPrefsService();

  AppBrandColor brand = AppBrandColor.purple;
  AppTextScale textScale = AppTextScale.normal;
  AppFont font = AppFont.system;

  Future<void> load() async {
    final (b, s, f) = await _service.loadAll();
    brand = b;
    textScale = s;
    font = f;
    notifyListeners();
  }

  Future<void> setBrand(AppBrandColor b) async {
    brand = b;
    await _service.saveBrand(b);
    notifyListeners();
  }

  Future<void> setTextScale(AppTextScale s) async {
    textScale = s;
    await _service.saveTextScale(s);
    notifyListeners();
  }

  Future<void> setFont(AppFont f) async {
    font = f;
    await _service.saveFont(f);
    notifyListeners();
  }

  /// Color seed según marca
  Color get seedColor {
    switch (brand) {
      case AppBrandColor.red:
        return kBrandRed;
      case AppBrandColor.purple:
        return kBrandPurple;
      case AppBrandColor.green:
        return kBrandGreen;
      case AppBrandColor.blue:
        return kBrandBlue;
    }
  }

  String? get appFontName {
    switch (font) {
      case AppFont.system:
        return null;
      case AppFont.sans:
        return 'EduSans';
      case AppFont.serif:
        return 'EduSerif';
      case AppFont.rounded:
        return 'EduRounded';
    }
  }

  ThemeData get appTheme {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
      useMaterial3: true,
    );

    final fontName = appFontName;

    final textTheme = fontName == null
        ? base.textTheme
        : base.textTheme.apply(fontFamily: fontName);

    final appBarTitleStyle = TextStyle(
      fontFamily: fontName,
      fontSize: 22,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    );

    return base.copyWith(
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: seedColor,
        foregroundColor: Colors.white,
        titleTextStyle: appBarTitleStyle,
      ),
    );
  }

  /// Escala de texto
  double get textScaleFactor => switch (textScale) {
    AppTextScale.normal => 1.0,
    AppTextScale.large => 1.15,
  };
}
