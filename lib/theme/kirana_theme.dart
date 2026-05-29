import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

ThemeData kiranaTheme() {
  return ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      background: AppColors.background,
      onBackground: AppColors.onBackground,
      surface: AppColors.cardBackground,
      onSurface: AppColors.textPrimary,
      error: AppColors.error,
      onError: AppColors.onPrimary,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.display,
      headlineLarge: AppTextStyles.pageHeading,
      headlineMedium: AppTextStyles.sectionHeading,
      titleLarge: AppTextStyles.cardHeading,
      bodyLarge: AppTextStyles.body,
      labelSmall: AppTextStyles.caption,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: AppTextStyles.pageHeading.copyWith(
        color: AppColors.onPrimary,
      ),
      iconTheme: IconThemeData(color: AppColors.onPrimary),
      centerTitle: true,
      elevation: 2,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.caramel,
        foregroundColor: AppColors.onPrimary,
        textStyle: AppTextStyles.body,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardBackground,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
    dataTableTheme: DataTableThemeData(
      headingRowColor: MaterialStateProperty.all(AppColors.coffee),
      headingTextStyle: AppTextStyles.cardHeading.copyWith(
        color: AppColors.onPrimary,
      ),
      dataTextStyle: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
      dataRowColor: MaterialStateProperty.resolveWith(
        (states) => AppColors.cardBackground,
      ),
    ),
  );
}

BoxDecoration kiranaListTileDecoration({
  Color accentColor = AppColors.caramel,
}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: AppColors.cardBackground,
    boxShadow: [
      BoxShadow(color: AppColors.espresso.withOpacity(0.06), blurRadius: 6),
    ],
  );
}

Color kiranaTableRowColor(int index) =>
    index.isEven ? AppColors.cardBackground : AppColors.cream;

BoxDecoration kiranaStatusBadgeDecoration(String status) {
  switch (status.toLowerCase()) {
    case 'open':
      return BoxDecoration(
        color: AppColors.honey.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.honey),
      );
    case 'closed':
      return BoxDecoration(
        color: AppColors.success.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.success),
      );
    default:
      return BoxDecoration(
        color: AppColors.biscuit.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.biscuit),
      );
  }
}

TextStyle kiranaStatusTextStyle(String status) {
  switch (status.toLowerCase()) {
    case 'open':
      return GoogleFonts.lato(
        color: AppColors.caramel,
        fontWeight: FontWeight.w700,
        fontSize: 12,
      );
    case 'closed':
      return GoogleFonts.lato(
        color: AppColors.success,
        fontWeight: FontWeight.w700,
        fontSize: 12,
      );
    default:
      return GoogleFonts.lato(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        fontSize: 12,
      );
  }
}

ButtonStyle get kirana_dangerButtonStyle => ElevatedButton.styleFrom(
  backgroundColor: AppColors.error,
  foregroundColor: AppColors.onPrimary,
  elevation: 0,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
);

ButtonStyle get kirana_tonalButtonStyle => ElevatedButton.styleFrom(
  backgroundColor: AppColors.biscuit,
  foregroundColor: AppColors.espresso,
  elevation: 0,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
);

class KiranaAnalyticsCardDark extends StatelessWidget {
  final String label;
  final String value;

  const KiranaAnalyticsCardDark({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.coffee,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.caption.copyWith(color: AppColors.onPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: AppTextStyles.display.copyWith(color: AppColors.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

class KiranaAnalyticsCardLight extends StatelessWidget {
  final String label;
  final String value;

  const KiranaAnalyticsCardLight({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextStyles.caption),
            const SizedBox(height: 8),
            Text(value, style: AppTextStyles.display.copyWith(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

class KiranaItemTile extends StatelessWidget {
  final String name;
  final String price;
  final bool isSelected;
  final VoidCallback? onTap;

  const KiranaItemTile({
    super.key,
    required this.name,
    required this.price,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: kiranaListTileDecoration(
          accentColor: isSelected ? AppColors.caramel : AppColors.biscuit,
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: AppTextStyles.body),
            Text(price, style: AppTextStyles.cardHeading),
          ],
        ),
      ),
    );
  }
}
