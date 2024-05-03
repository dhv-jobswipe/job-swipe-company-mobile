// ignoreforfile: nonconstantidentifiernames

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

interface class AppThemeData {
  late final String version_label;

  ///
  /// Icon color
  ///
  late final Color icon_primary;
  late final Color icon_normal;

  ///
  /// Button color
  ///
  late final Color button_primary_bg;
  late final Color button_white_bg;
  late final Color button_disable_bg;
  late final Color button_error_bg;

  ///
  /// Shadow color
  ///
  late final Color shadow;

  ///
  /// Drawder color
  ///
  late final Color drawer_header_text;
  late final Color drawer_header_icon;
  late final Color drawer_bg;
  late final Color drawer_body_bg;
  late final Color drawer_footer_bg;
  late final Color drawer_footer_text;
  late final Color drawer_footer_icon;

  ///
  /// Layout color
  ///
  late final Color layout_bg;
  late final Color layout_app_bar;
  late final Color layout_status_bar;
  late final Color primary_color;
  late final Color primary_light_color;
  late final Color primary_dark_color;

  ///
  /// Text color
  ///
  late final Color text_title;
  late final Color text_body;
  late final Color text_field_label;
  late final Color text_normal;
  late final Color text_placeholder;
  late final Color text_selected_dropdown_label;
  late final Color text_required_icon;
  late final Color text_error;

  ///
  /// Background color
  ///
  late final Color bg_primary;
  late final Color bg_field;
  late final Color bg_dialog;
  late final Color bg_modal_bottom_sheet;
  late final Color bg_error;
  late final Color bg_dropdown;
  late final Color bg_image;

  ///
  /// Banner color
  ///
  late final Color banner_success_bg;
  late final Color banner_success_icon;
  late final Color banner_success_text;
  late final Color banner_error_bg;
  late final Color banner_error_icon;
  late final Color banner_error_text;
  late final Color banner_warning_bg;
  late final Color banner_warning_icon;
  late final Color banner_warning_text;
  late final Color banner_info_bg;
  late final Color banner_info_icon;
  late final Color banner_info_text;

  ///
  /// Border color
  ///
  late final Color border_primary;
  late final Color border_focus;
  late final Color border_unfocus;
  late final Color border_error;

  ///
  /// Divider color
  ///
  late final Color divider_primary;

  ///
  /// ------------------ BASIC COLOR ------------------
  ///
  late final Color transparent;
  late final Color white;
  late final Color black;
  late final Color slate100;
  late final Color slate200;
  late final Color slate300;
  late final Color slate400;
  late final Color slate500;
  late final Color slate600;
  late final Color slate700;
  late final Color slate800;
  late final Color slate900;
  /* */
  late final Color gray100;
  late final Color gray200;
  late final Color gray300;
  late final Color gray400;
  late final Color gray500;
  late final Color gray600;
  late final Color gray700;
  late final Color gray800;
  late final Color gray900;
  /* */
  late final Color neutral100;
  late final Color neutral200;
  late final Color neutral300;
  late final Color neutral400;
  late final Color neutral500;
  late final Color neutral600;
  late final Color neutral700;
  late final Color neutral800;
  late final Color neutral900;
  /* */
  late final Color red100;
  late final Color red200;
  late final Color red300;
  late final Color red400;
  late final Color red500;
  late final Color red600;
  late final Color red700;
  late final Color red800;
  late final Color red900;
  /* */
  late final Color orange100;
  late final Color orange200;
  late final Color orange300;
  late final Color orange400;
  late final Color orange500;
  late final Color orange600;
  late final Color orange700;
  late final Color orange800;
  late final Color orange900;
  /* */
  late final Color amber100;
  late final Color amber200;
  late final Color amber300;
  late final Color amber400;
  late final Color amber500;
  late final Color amber600;
  late final Color amber700;
  late final Color amber800;
  late final Color amber900;
  /* */
  late final Color yellow100;
  late final Color yellow200;
  late final Color yellow300;
  late final Color yellow400;
  late final Color yellow500;
  late final Color yellow600;
  late final Color yellow700;
  late final Color yellow800;
  late final Color yellow900;
  /* */
  late final Color lime100;
  late final Color lime200;
  late final Color lime300;
  late final Color lime400;
  late final Color lime500;
  late final Color lime600;
  late final Color lime700;
  late final Color lime800;
  late final Color lime900;
  /* */
  late final Color green100;
  late final Color green200;
  late final Color green300;
  late final Color green400;
  late final Color green500;
  late final Color green600;
  late final Color green700;
  late final Color green800;
  late final Color green900;
  /* */
  late final Color emerald100;
  late final Color emerald200;
  late final Color emerald300;
  late final Color emerald400;
  late final Color emerald500;
  late final Color emerald600;
  late final Color emerald700;
  late final Color emerald800;
  late final Color emerald900;
  /* */
  late final Color teal100;
  late final Color teal200;
  late final Color teal300;
  late final Color teal400;
  late final Color teal500;
  late final Color teal600;
  late final Color teal700;
  late final Color teal800;
  late final Color teal900;
  /* */
  late final Color cyan100;
  late final Color cyan200;
  late final Color cyan300;
  late final Color cyan400;
  late final Color cyan500;
  late final Color cyan600;
  late final Color cyan700;
  late final Color cyan800;
  late final Color cyan900;
  /* */
  late final Color sky100;
  late final Color sky200;
  late final Color sky300;
  late final Color sky400;
  late final Color sky500;
  late final Color sky600;
  late final Color sky700;
  late final Color sky800;
  late final Color sky900;
  /* */
  late final Color blue100;
  late final Color blue200;
  late final Color blue300;
  late final Color blue400;
  late final Color blue500;
  late final Color blue600;
  late final Color blue700;
  late final Color blue800;
  late final Color blue900;
  /* */
  late final Color violet100;
  late final Color violet200;
  late final Color violet300;
  late final Color violet400;
  late final Color violet500;
  late final Color violet600;
  late final Color violet700;
  late final Color violet800;
  late final Color violet900;
  /* */
  late final Color purple100;
  late final Color purple200;
  late final Color purple300;
  late final Color purple400;
  late final Color purple500;
  late final Color purple600;
  late final Color purple700;
  late final Color purple800;
  late final Color purple900;
  /* */
  late final Color fuchsia100;
  late final Color fuchsia200;
  late final Color fuchsia300;
  late final Color fuchsia400;
  late final Color fuchsia500;
  late final Color fuchsia600;
  late final Color fuchsia700;
  late final Color fuchsia800;
  late final Color fuchsia900;
  /* */
  late final Color pink100;
  late final Color pink200;
  late final Color pink300;
  late final Color pink400;
  late final Color pink500;
  late final Color pink600;
  late final Color pink700;
  late final Color pink800;
  late final Color pink900;

  ///
  /// ------------------ BASIC COLOR ------------------
  ///

  /// ThemeData
  // ThemeData get themeData => ThemeData(
  // actionIconTheme: ActionIconThemeData(),
  // appBarTheme: AppBarTheme(),
  // bannerTheme: MaterialBannerThemeData(),
  // scaffoldBackgroundColor: Colors.red,
  // late final baheme: late final BahemeData(),
  // bottomAppBarTheme: BottomAppBarTheme(),
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(),
  // bottomSheetTheme: BottomSheetThemeData(),
  // brightness: Brightness.light,
  // buttonBarTheme: ButtonBarThemeData(),
  // buttonTheme: ButtonThemeData(),
  // cardTheme: CardTheme(),
  // checkboxTheme: CheckboxThemeData(),
  // colorScheme: ColorScheme(
  //     brightness: brightness,
  //     primary: primary,
  //     onPrimary: onPrimary,
  //     secondary: secondary,
  //     onSecondary: onSecondary,
  //     error: error,
  //     onError: onError,
  //     background: background,
  //     onBackground: onBackground,
  //     surface: surface,
  //     onSurface: onSurface),
  // dataTableTheme: DataTableThemeData(),
  // datePickerTheme: DatePickerThemeData(),
  // dialogTheme: DialogTheme(),
  // dividerTheme: DividerThemeData(),
  // iconTheme: IconThemeData(),
  // menuTheme: MenuThemeData(),
  // radioTheme: RadioThemeData(),
  // textTheme: TextTheme(),
  // drawerTheme: DrawerThemeData(),
  // sliderTheme: SliderThemeData(),
  // switchTheme: SwitchThemeData(),
  // tabBarTheme: TabBarTheme(),
  // menuBarTheme: MenuBarThemeData(),
  // tooltipTheme: TooltipThemeData(),
  // listTileTheme: ListTileThemeData(),
  // chipTheme: ChipThemeData(),
  // snackBarTheme: SnackBarThemeData(),
  // popupMenuTheme: PopupMenuThemeData(),
  // scrollbarTheme: ScrollbarThemeData(),
  // searchBarTheme: SearchBarThemeData(),
  // applyElevationOverlayColor: false,
  // );
}
