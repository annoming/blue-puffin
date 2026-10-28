// 参考实现：可直接复制到 lib/shared/theme/（由 Frank 落地，不属于 design/ 自动生效代码）。
// 与 design/specs/01-foundations.md 一一对应；业务代码只允许引用语义 token。
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  final Color brand;
  final Color brandSoft;
  final Color accent;
  final Color bgBase;
  final Color bgSurface;
  final Color bgSunken;
  final Color borderSubtle;
  final Color borderDefault;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;
  final Color success;
  final Color successBg;
  final Color warning;
  final Color warningBg;
  final Color danger;
  final Color dangerBg;
  final Color info;
  final Color infoBg;
  final Color typeEasy;
  final Color typeTempo;
  final Color typeLong;
  final Color typeInterval;
  final Color typeRest;

  const AppTokens({
    required this.brand,
    required this.brandSoft,
    required this.accent,
    required this.bgBase,
    required this.bgSurface,
    required this.bgSunken,
    required this.borderSubtle,
    required this.borderDefault,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.success,
    required this.successBg,
    required this.warning,
    required this.warningBg,
    required this.danger,
    required this.dangerBg,
    required this.info,
    required this.infoBg,
    required this.typeEasy,
    required this.typeTempo,
    required this.typeLong,
    required this.typeInterval,
    required this.typeRest,
  });

  static const light = AppTokens(
    brand: Color(0xFF1463E6),
    brandSoft: Color(0xFFEAF1FE),
    accent: Color(0xFFE85D0B),
    bgBase: Color(0xFFF5F7FA),
    bgSurface: Color(0xFFFFFFFF),
    bgSunken: Color(0xFFEEF2F7),
    borderSubtle: Color(0xFFEDF0F4),
    borderDefault: Color(0xFFE3E8EF),
    textPrimary: Color(0xFF0F1A2A),
    textSecondary: Color(0xFF4A5A6E),
    textTertiary: Color(0xFF7C8B9E),
    textDisabled: Color(0xFFA9B4C0),
    success: Color(0xFF12A05C),
    successBg: Color(0xFFE7F7EF),
    warning: Color(0xFFB25E00),
    warningBg: Color(0xFFFFF4E0),
    danger: Color(0xFFD92D20),
    dangerBg: Color(0xFFFEECEB),
    info: Color(0xFF1463E6),
    infoBg: Color(0xFFEAF1FE),
    typeEasy: Color(0xFF0E8A4F),
    typeTempo: Color(0xFFB25E00),
    typeLong: Color(0xFFC11B17),
    typeInterval: Color(0xFF5B3DF5),
    typeRest: Color(0xFF5B6B7E),
  );

  static const dark = AppTokens(
    brand: Color(0xFF6FA6FF),
    brandSoft: Color(0xFF132943),
    accent: Color(0xFFFF8A3D),
    bgBase: Color(0xFF0B1118),
    bgSurface: Color(0xFF141C26),
    bgSunken: Color(0xFF1C2632),
    borderSubtle: Color(0xFF1F2A36),
    borderDefault: Color(0xFF263241),
    textPrimary: Color(0xFFF3F6FA),
    textSecondary: Color(0xFFA7B4C4),
    textTertiary: Color(0xFF7A8899),
    textDisabled: Color(0xFF4E5A68),
    success: Color(0xFF4ADE9B),
    successBg: Color(0xFF0F2E22),
    warning: Color(0xFFFFC46B),
    warningBg: Color(0xFF3A2A10),
    danger: Color(0xFFFF8A80),
    dangerBg: Color(0xFF3A1714),
    info: Color(0xFF8ABAFF),
    infoBg: Color(0xFF132943),
    typeEasy: Color(0xFF4ADE9B),
    typeTempo: Color(0xFFFFC46B),
    typeLong: Color(0xFFFF8A80),
    typeInterval: Color(0xFFB9A6FF),
    typeRest: Color(0xFFA7B4C4),
  );

  @override
  AppTokens copyWith({
    Color? brand,
    Color? brandSoft,
    Color? accent,
    Color? bgBase,
    Color? bgSurface,
    Color? bgSunken,
    Color? borderSubtle,
    Color? borderDefault,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textDisabled,
    Color? success,
    Color? successBg,
    Color? warning,
    Color? warningBg,
    Color? danger,
    Color? dangerBg,
    Color? info,
    Color? infoBg,
    Color? typeEasy,
    Color? typeTempo,
    Color? typeLong,
    Color? typeInterval,
    Color? typeRest,
  }) {
    return AppTokens(
      brand: brand ?? this.brand,
      brandSoft: brandSoft ?? this.brandSoft,
      accent: accent ?? this.accent,
      bgBase: bgBase ?? this.bgBase,
      bgSurface: bgSurface ?? this.bgSurface,
      bgSunken: bgSunken ?? this.bgSunken,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderDefault: borderDefault ?? this.borderDefault,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textDisabled: textDisabled ?? this.textDisabled,
      success: success ?? this.success,
      successBg: successBg ?? this.successBg,
      warning: warning ?? this.warning,
      warningBg: warningBg ?? this.warningBg,
      danger: danger ?? this.danger,
      dangerBg: dangerBg ?? this.dangerBg,
      info: info ?? this.info,
      infoBg: infoBg ?? this.infoBg,
      typeEasy: typeEasy ?? this.typeEasy,
      typeTempo: typeTempo ?? this.typeTempo,
      typeLong: typeLong ?? this.typeLong,
      typeInterval: typeInterval ?? this.typeInterval,
      typeRest: typeRest ?? this.typeRest,
    );
  }

  /// 主题切换插值：25 个颜色 token 全部参与，包含 5 类训练类型色
  /// （typeEasy / typeTempo / typeLong / typeInterval / typeRest）。
  /// 新增 token 时必须同步更新构造函数、copyWith 与本方法，避免切换主题时丢色。
  @override
  AppTokens lerp(AppTokens? other, double t) {
    if (other == null) return this;
    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppTokens(
      brand: c(brand, other.brand),
      brandSoft: c(brandSoft, other.brandSoft),
      accent: c(accent, other.accent),
      bgBase: c(bgBase, other.bgBase),
      bgSurface: c(bgSurface, other.bgSurface),
      bgSunken: c(bgSunken, other.bgSunken),
      borderSubtle: c(borderSubtle, other.borderSubtle),
      borderDefault: c(borderDefault, other.borderDefault),
      textPrimary: c(textPrimary, other.textPrimary),
      textSecondary: c(textSecondary, other.textSecondary),
      textTertiary: c(textTertiary, other.textTertiary),
      textDisabled: c(textDisabled, other.textDisabled),
      success: c(success, other.success),
      successBg: c(successBg, other.successBg),
      warning: c(warning, other.warning),
      warningBg: c(warningBg, other.warningBg),
      danger: c(danger, other.danger),
      dangerBg: c(dangerBg, other.dangerBg),
      info: c(info, other.info),
      infoBg: c(infoBg, other.infoBg),
      // 训练类型色：5 类全部插值，主题切换时类型标签不丢失
      typeEasy: c(typeEasy, other.typeEasy),
      typeTempo: c(typeTempo, other.typeTempo),
      typeLong: c(typeLong, other.typeLong),
      typeInterval: c(typeInterval, other.typeInterval),
      typeRest: c(typeRest, other.typeRest),
    );
  }
}

class AppSpacing {
  static const double x1 = 4;
  static const double x2 = 8;
  static const double x3 = 12;
  static const double x4 = 16;
  static const double x6 = 24;
  static const double x8 = 32;
  static const double x10 = 40;
  static const double page = 16;
  static const double touch = 48;
}

class AppRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double pill = 999;
}

/// 字阶：字号 / 行高 / 字重 / 字距。数字使用 tabularFigures。
class AppTextStyles {
  static const displayXl = TextStyle(
    fontSize: 64,
    height: 68 / 64,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.0,
    fontFeatures: [FontFeature.tabularFigures()],
  );
  static const displayL = TextStyle(
    fontSize: 48,
    height: 52 / 48,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    fontFeatures: [FontFeature.tabularFigures()],
  );
  static const displayM = TextStyle(
    fontSize: 36,
    height: 42 / 36,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    fontFeatures: [FontFeature.tabularFigures()],
  );
  static const titleXl =
      TextStyle(fontSize: 28, height: 34 / 28, fontWeight: FontWeight.w700);
  static const titleL =
      TextStyle(fontSize: 22, height: 28 / 22, fontWeight: FontWeight.w600);
  static const titleM =
      TextStyle(fontSize: 18, height: 24 / 18, fontWeight: FontWeight.w600);
  static const bodyL = TextStyle(fontSize: 16, height: 24 / 16);
  static const bodyM = TextStyle(fontSize: 14, height: 22 / 14);
  static const labelL =
      TextStyle(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w600);
  static const caption =
      TextStyle(fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w500);
  static const micro =
      TextStyle(fontSize: 11, height: 14 / 11, fontWeight: FontWeight.w500);
}

class AppTheme {
  static ThemeData lightTheme() => _build(AppTokens.light, Brightness.light);
  static ThemeData darkTheme() => _build(AppTokens.dark, Brightness.dark);

  static ThemeData _build(AppTokens t, Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF1463E6),
      brightness: brightness,
    ).copyWith(
      primary: t.brand,
      onPrimary: Colors.white,
      surface: t.bgSurface,
      onSurface: t.textPrimary,
      error: t.danger,
      outline: t.borderDefault,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: t.bgBase,
      fontFamilyFallback: const ['PingFang SC', 'Noto Sans SC'],
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.titleXl.copyWith(color: t.textPrimary),
        headlineMedium: AppTextStyles.titleL.copyWith(color: t.textPrimary),
        titleMedium: AppTextStyles.titleM.copyWith(color: t.textPrimary),
        bodyLarge: AppTextStyles.bodyL.copyWith(color: t.textPrimary),
        bodyMedium: AppTextStyles.bodyM.copyWith(color: t.textSecondary),
        labelLarge: AppTextStyles.labelL.copyWith(color: t.textPrimary),
        bodySmall: AppTextStyles.caption.copyWith(color: t.textTertiary),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          textStyle: AppTextStyles.labelL,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          side: BorderSide(color: t.borderDefault),
          foregroundColor: t.brand,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          textStyle: AppTextStyles.labelL,
        ),
      ),
      dividerTheme: DividerThemeData(color: t.borderSubtle, thickness: 1),
      extensions: [t],
    );
  }
}

/// 运动模式专用 token：对应 `01-foundations.md` 的 `run/*`，恒定深色。
@immutable
class RunTokens extends ThemeExtension<RunTokens> {
  final Color bg;
  final Color mapScrim;
  final Color text;
  final Color textSecondary;
  final Color divider;
  final Color pause;
  final Color stop;
  final Color gpsGood;
  final Color gpsWeak;
  final Color gpsLost;

  const RunTokens({
    required this.bg,
    required this.mapScrim,
    required this.text,
    required this.textSecondary,
    required this.divider,
    required this.pause,
    required this.stop,
    required this.gpsGood,
    required this.gpsWeak,
    required this.gpsLost,
  });

  static const dark = RunTokens(
    bg: Color(0xFF071019),
    mapScrim: Color(0x8C071019),
    text: Color(0xFFFFFFFF),
    textSecondary: Color(0xFF9EB0C4),
    divider: Color(0x1FFFFFFF),
    pause: Color(0xFFFFC46B),
    stop: Color(0xFFFF6B60),
    gpsGood: Color(0xFF4ADE9B),
    gpsWeak: Color(0xFFFFC46B),
    gpsLost: Color(0xFFFF6B60),
  );

  @override
  RunTokens copyWith({
    Color? bg,
    Color? mapScrim,
    Color? text,
    Color? textSecondary,
    Color? divider,
    Color? pause,
    Color? stop,
    Color? gpsGood,
    Color? gpsWeak,
    Color? gpsLost,
  }) {
    return RunTokens(
      bg: bg ?? this.bg,
      mapScrim: mapScrim ?? this.mapScrim,
      text: text ?? this.text,
      textSecondary: textSecondary ?? this.textSecondary,
      divider: divider ?? this.divider,
      pause: pause ?? this.pause,
      stop: stop ?? this.stop,
      gpsGood: gpsGood ?? this.gpsGood,
      gpsWeak: gpsWeak ?? this.gpsWeak,
      gpsLost: gpsLost ?? this.gpsLost,
    );
  }

  @override
  RunTokens lerp(RunTokens? other, double t) {
    if (other == null) return this;
    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    return RunTokens(
      bg: c(bg, other.bg),
      mapScrim: c(mapScrim, other.mapScrim),
      text: c(text, other.text),
      textSecondary: c(textSecondary, other.textSecondary),
      divider: c(divider, other.divider),
      pause: c(pause, other.pause),
      stop: c(stop, other.stop),
      gpsGood: c(gpsGood, other.gpsGood),
      gpsWeak: c(gpsWeak, other.gpsWeak),
      gpsLost: c(gpsLost, other.gpsLost),
    );
  }
}

/// 运动模式：恒暗，不随系统切换。
///
/// 用法：
/// ```dart
/// Theme(data: RunTheme.data, child: const RunScreen());
/// RunTheme.applySystemUi(); // 进入跑步页首帧
/// ```
class RunTheme {
  static const tokens = RunTokens.dark;

  /// 跑步页状态栏/导航栏：浅色图标（深色背景），透明状态栏。
  static const overlayStyle = SystemUiOverlayStyle.light;

  static const bg = Color(0xFF071019);
  static const text = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF9EB0C4);
  static const divider = Color(0x1FFFFFFF);
  static const pause = Color(0xFFFFC46B);
  static const stop = Color(0xFFFF6B60);
  static const gpsGood = Color(0xFF4ADE9B);
  static const gpsWeak = Color(0xFFFFC46B);
  static const gpsLost = Color(0xFFFF6B60);

  static void applySystemUi() {
    SystemChrome.setSystemUIOverlayStyle(
      overlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: bg,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  static ThemeData get data => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF6B1A),
          surface: bg,
          onSurface: text,
        ),
        fontFamilyFallback: const ['PingFang SC', 'Noto Sans SC'],
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          displayLarge: AppTextStyles.displayXl,
          headlineLarge: AppTextStyles.titleXl,
          bodyLarge: AppTextStyles.bodyL,
          bodyMedium: AppTextStyles.bodyM,
        ),
        extensions: const [RunTokens.dark],
      );
}
