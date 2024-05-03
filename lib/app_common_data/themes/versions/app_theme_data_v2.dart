// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data.dart';

class AppThemeDataV2 implements AppThemeData {
  @override
  String version_label = "AppThemeDataV2";

  @override
  Color banner_error_bg = const Color(0xFFFFF1F0);

  @override
  Color banner_error_icon = const Color(0xffE02D3C);

  @override
  Color banner_error_text = const Color(0xFF363445);

  @override
  Color banner_info_bg = const Color(0xFFd1fafa);

  @override
  Color banner_info_icon = const Color(0xFF5FBDFF);

  @override
  Color banner_info_text = const Color(0xFF363445);

  @override
  Color banner_success_bg = const Color(0xFFE6FFFB);

  @override
  Color banner_success_icon = const Color(0xFF08875D);

  @override
  Color banner_success_text = const Color(0xFF363445);

  @override
  Color banner_warning_bg = const Color(0xFFFFFBE6);

  @override
  Color banner_warning_icon = const Color(0xFFFFC47E);

  @override
  Color banner_warning_text = const Color(0xFF363445);

  @override
  Color bg_dialog = const Color(0xFFFFFFFF);

  @override
  Color bg_dropdown = const Color(0xFFFFFFFF);

  @override
  Color bg_error = const Color(0xffE02D3C);

  @override
  Color bg_field = const Color(0xFFFFFFFF);

  @override
  Color bg_image = const Color(0xFFCDD6DF);

  @override
  Color bg_modal_bottom_sheet = const Color(0xFFFFFFFF);

  @override
  Color bg_primary = const Color(0xFFF5F5F5);

  @override
  Color black = const Color(0xFF000000);

  @override
  Color border_error = const Color(0xffE02D3C);

  @override
  Color border_focus = const Color(0xff713ABE);

  @override
  Color border_primary = const Color(0xFFCDD6DF);

  @override
  Color border_unfocus = const Color(0xFFCDD6DF);

  @override
  Color button_disable_bg = const Color(0xFFCDD6DF);

  @override
  Color button_error_bg = const Color(0xffE02D3C);

  @override
  Color button_primary_bg = const Color(0xff713ABE);

  @override
  Color button_white_bg = const Color(0xFFFFFFFF);

  @override
  Color divider_primary = const Color(0xFFCDD6DF);

  @override
  Color drawer_bg = const Color(0xff713ABE);

  @override
  Color drawer_body_bg = const Color(0xFFF5F5F5);

  @override
  Color drawer_footer_bg = const Color(0xFFF5F5F5);

  @override
  Color drawer_footer_icon = const Color(0xff713ABE);

  @override
  Color drawer_footer_text = const Color(0xff713ABE);

  @override
  Color drawer_header_icon = const Color(0xFFFFFFFF);

  @override
  Color drawer_header_text = const Color(0xFFFFFFFF);

  @override
  Color icon_normal = const Color(0xFF363445);

  @override
  Color icon_primary = const Color(0xff713ABE);

  @override
  Color layout_app_bar = const Color(0xff713ABE);

  @override
  Color layout_bg = const Color(0xFFF5F5F5);

  @override
  Color layout_status_bar = const Color(0xFFFFFFFF);

  @override
  Color primary_color = const Color(0xff713ABE);

  @override
  Color primary_dark_color = const Color(0xff5B0888);

  @override
  Color primary_light_color = const Color(0xFFB15EFF);

  @override
  Color shadow = Colors.black.withOpacity(0.2);

  @override
  Color text_body = const Color(0xFF525252);

  @override
  Color text_error = const Color(0xffE02D3C);

  @override
  Color text_field_label = const Color(0xFF595959);

  @override
  Color text_normal = const Color(0xFF595959);

  @override
  Color text_placeholder = const Color(0xFFA3AED0);

  @override
  Color text_required_icon = const Color(0xffE02D3C);

  @override
  Color text_selected_dropdown_label = const Color(0xFF363445);

  @override
  Color text_title = const Color(0xFF363445);

  @override
  Color transparent = Colors.transparent;

  @override
  Color white = const Color(0xFFFFFFFF);

  ///
  /// ------------------ BASIC COLOR ------------------
  ///

  @override
  Color slate100 = const Color.fromARGB(255, 241, 245, 249);
  @override
  Color slate200 = const Color.fromARGB(255, 226, 232, 240);
  @override
  Color slate300 = const Color.fromARGB(255, 203, 213, 225);
  @override
  Color slate400 = const Color.fromARGB(255, 148, 163, 184);
  @override
  Color slate500 = const Color.fromARGB(255, 100, 116, 139);
  @override
  Color slate600 = const Color.fromARGB(255, 71, 85, 105);
  @override
  Color slate700 = const Color.fromARGB(255, 51, 65, 85);
  @override
  Color slate800 = const Color.fromARGB(255, 30, 41, 59);
  @override
  Color slate900 = const Color.fromARGB(255, 15, 23, 42);
  /* */
  @override
  Color gray100 = const Color.fromARGB(255, 243, 244, 246);
  @override
  Color gray200 = const Color.fromARGB(255, 229, 231, 235);
  @override
  Color gray300 = const Color.fromARGB(255, 209, 213, 219);
  @override
  Color gray400 = const Color.fromARGB(255, 156, 163, 175);
  @override
  Color gray500 = const Color.fromARGB(255, 107, 114, 128);
  @override
  Color gray600 = const Color.fromARGB(255, 75, 85, 99);
  @override
  Color gray700 = const Color.fromARGB(255, 55, 65, 81);
  @override
  Color gray800 = const Color.fromARGB(255, 31, 41, 55);
  @override
  Color gray900 = const Color.fromARGB(255, 17, 24, 39);
  /* */
  @override
  Color neutral100 = const Color.fromARGB(255, 245, 245, 245);
  @override
  Color neutral200 = const Color.fromARGB(255, 229, 229, 229);
  @override
  Color neutral300 = const Color.fromARGB(255, 212, 212, 212);
  @override
  Color neutral400 = const Color.fromARGB(255, 163, 163, 163);
  @override
  Color neutral500 = const Color.fromARGB(255, 115, 115, 115);
  @override
  Color neutral600 = const Color.fromARGB(255, 82, 82, 82);
  @override
  Color neutral700 = const Color.fromARGB(255, 64, 64, 64);
  @override
  Color neutral800 = const Color.fromARGB(255, 38, 38, 38);
  @override
  Color neutral900 = const Color.fromARGB(255, 23, 23, 23);
  /* */
  @override
  Color red100 = const Color.fromARGB(255, 254, 226, 226);
  @override
  Color red200 = const Color.fromARGB(255, 254, 202, 202);
  @override
  Color red300 = const Color.fromARGB(255, 252, 165, 165);
  @override
  Color red400 = const Color.fromARGB(255, 248, 113, 113);
  @override
  Color red500 = const Color.fromARGB(255, 239, 68, 68);
  @override
  Color red600 = const Color.fromARGB(255, 220, 38, 38);
  @override
  Color red700 = const Color.fromARGB(255, 185, 28, 28);
  @override
  Color red800 = const Color.fromARGB(255, 153, 27, 27);
  @override
  Color red900 = const Color.fromARGB(255, 127, 29, 29);
  /* */
  @override
  Color orange100 = const Color.fromARGB(255, 255, 237, 213);
  @override
  Color orange200 = const Color.fromARGB(255, 254, 215, 170);
  @override
  Color orange300 = const Color.fromARGB(255, 253, 186, 116);
  @override
  Color orange400 = const Color.fromARGB(255, 251, 146, 60);
  @override
  Color orange500 = const Color.fromARGB(255, 249, 115, 22);
  @override
  Color orange600 = const Color.fromARGB(255, 234, 88, 12);
  @override
  Color orange700 = const Color.fromARGB(255, 194, 65, 12);
  @override
  Color orange800 = const Color.fromARGB(255, 154, 52, 18);
  @override
  Color orange900 = const Color.fromARGB(255, 124, 45, 18);
  /* */
  @override
  Color amber100 = const Color.fromARGB(255, 254, 243, 199);
  @override
  Color amber200 = const Color.fromARGB(255, 253, 230, 138);
  @override
  Color amber300 = const Color.fromARGB(255, 252, 211, 77);
  @override
  Color amber400 = const Color.fromARGB(255, 251, 191, 36);
  @override
  Color amber500 = const Color.fromARGB(255, 245, 158, 11);
  @override
  Color amber600 = const Color.fromARGB(255, 217, 119, 6);
  @override
  Color amber700 = const Color.fromARGB(255, 180, 83, 9);
  @override
  Color amber800 = const Color.fromARGB(255, 146, 64, 14);
  @override
  Color amber900 = const Color.fromARGB(255, 120, 53, 15);
  /* */
  @override
  Color yellow100 = const Color.fromARGB(255, 254, 249, 195);
  @override
  Color yellow200 = const Color.fromARGB(255, 254, 240, 138);
  @override
  Color yellow300 = const Color.fromARGB(255, 253, 224, 71);
  @override
  Color yellow400 = const Color.fromARGB(255, 250, 204, 21);
  @override
  Color yellow500 = const Color.fromARGB(255, 234, 179, 8);
  @override
  Color yellow600 = const Color.fromARGB(255, 202, 138, 4);
  @override
  Color yellow700 = const Color.fromARGB(255, 161, 98, 7);
  @override
  Color yellow800 = const Color.fromARGB(255, 133, 77, 14);
  @override
  Color yellow900 = const Color.fromARGB(255, 113, 63, 18);
  /* */
  @override
  Color lime100 = const Color.fromARGB(255, 236, 252, 203);
  @override
  Color lime200 = const Color.fromARGB(255, 217, 249, 157);
  @override
  Color lime300 = const Color.fromARGB(255, 190, 242, 100);
  @override
  Color lime400 = const Color.fromARGB(255, 163, 230, 53);
  @override
  Color lime500 = const Color.fromARGB(255, 132, 204, 22);
  @override
  Color lime600 = const Color.fromARGB(255, 101, 163, 13);
  @override
  Color lime700 = const Color.fromARGB(255, 77, 124, 15);
  @override
  Color lime800 = const Color.fromARGB(255, 63, 98, 18);
  @override
  Color lime900 = const Color.fromARGB(255, 54, 83, 20);
  /* */
  @override
  Color green100 = const Color.fromARGB(255, 220, 252, 231);
  @override
  Color green200 = const Color.fromARGB(255, 187, 247, 208);
  @override
  Color green300 = const Color.fromARGB(255, 134, 239, 172);
  @override
  Color green400 = const Color.fromARGB(255, 74, 222, 128);
  @override
  Color green500 = const Color.fromARGB(255, 34, 197, 94);
  @override
  Color green600 = const Color.fromARGB(255, 22, 163, 74);
  @override
  Color green700 = const Color.fromARGB(255, 21, 128, 61);
  @override
  Color green800 = const Color.fromARGB(255, 22, 101, 52);
  @override
  Color green900 = const Color.fromARGB(255, 20, 83, 45);
  /* */
  @override
  Color emerald100 = const Color.fromARGB(255, 209, 250, 229);
  @override
  Color emerald200 = const Color.fromARGB(255, 167, 243, 208);
  @override
  Color emerald300 = const Color.fromARGB(255, 110, 231, 183);
  @override
  Color emerald400 = const Color.fromARGB(255, 52, 211, 153);
  @override
  Color emerald500 = const Color.fromARGB(255, 16, 185, 129);
  @override
  Color emerald600 = const Color.fromARGB(255, 5, 150, 105);
  @override
  Color emerald700 = const Color.fromARGB(255, 4, 120, 87);
  @override
  Color emerald800 = const Color.fromARGB(255, 6, 95, 70);
  @override
  Color emerald900 = const Color.fromARGB(255, 6, 78, 59);
  /* */
  @override
  Color teal100 = const Color.fromARGB(255, 204, 251, 241);
  @override
  Color teal200 = const Color.fromARGB(255, 153, 246, 228);
  @override
  Color teal300 = const Color.fromARGB(255, 94, 234, 212);
  @override
  Color teal400 = const Color.fromARGB(255, 45, 212, 191);
  @override
  Color teal500 = const Color.fromARGB(255, 20, 184, 166);
  @override
  Color teal600 = const Color.fromARGB(255, 13, 148, 136);
  @override
  Color teal700 = const Color.fromARGB(255, 15, 118, 110);
  @override
  Color teal800 = const Color.fromARGB(255, 17, 94, 89);
  @override
  Color teal900 = const Color.fromARGB(255, 19, 78, 74);
  /* */
  @override
  Color cyan100 = const Color.fromARGB(255, 207, 250, 254);
  @override
  Color cyan200 = const Color.fromARGB(255, 165, 243, 252);
  @override
  Color cyan300 = const Color.fromARGB(255, 103, 232, 249);
  @override
  Color cyan400 = const Color.fromARGB(255, 34, 211, 238);
  @override
  Color cyan500 = const Color.fromARGB(255, 6, 182, 212);
  @override
  Color cyan600 = const Color.fromARGB(255, 8, 145, 178);
  @override
  Color cyan700 = const Color.fromARGB(255, 14, 116, 144);
  @override
  Color cyan800 = const Color.fromARGB(255, 21, 94, 117);
  @override
  Color cyan900 = const Color.fromARGB(255, 22, 78, 99);
  /* */
  @override
  Color sky100 = const Color.fromARGB(255, 224, 242, 254);
  @override
  Color sky200 = const Color.fromARGB(255, 186, 230, 253);
  @override
  Color sky300 = const Color.fromARGB(255, 125, 211, 252);
  @override
  Color sky400 = const Color.fromARGB(255, 56, 189, 248);
  @override
  Color sky500 = const Color.fromARGB(255, 14, 165, 233);
  @override
  Color sky600 = const Color.fromARGB(255, 2, 132, 199);
  @override
  Color sky700 = const Color.fromARGB(255, 3, 105, 161);
  @override
  Color sky800 = const Color.fromARGB(255, 7, 89, 133);
  @override
  Color sky900 = const Color.fromARGB(255, 12, 74, 110);
  /* */
  @override
  Color blue100 = const Color.fromARGB(255, 219, 234, 254);
  @override
  Color blue200 = const Color.fromARGB(255, 191, 219, 254);
  @override
  Color blue300 = const Color.fromARGB(255, 147, 197, 253);
  @override
  Color blue400 = const Color.fromARGB(255, 96, 165, 250);
  @override
  Color blue500 = const Color.fromARGB(255, 59, 130, 246);
  @override
  Color blue600 = const Color.fromARGB(255, 37, 99, 235);
  @override
  Color blue700 = const Color.fromARGB(255, 29, 78, 216);
  @override
  Color blue800 = const Color.fromARGB(255, 30, 64, 175);
  @override
  Color blue900 = const Color.fromARGB(255, 30, 58, 138);
  /* */
  @override
  Color violet100 = const Color.fromARGB(255, 237, 233, 254);
  @override
  Color violet200 = const Color.fromARGB(255, 221, 214, 254);
  @override
  Color violet300 = const Color.fromARGB(255, 196, 181, 253);
  @override
  Color violet400 = const Color.fromARGB(255, 167, 139, 250);
  @override
  Color violet500 = const Color.fromARGB(255, 139, 92, 246);
  @override
  Color violet600 = const Color.fromARGB(255, 124, 58, 237);
  @override
  Color violet700 = const Color.fromARGB(255, 109, 40, 217);
  @override
  Color violet800 = const Color.fromARGB(255, 91, 33, 182);
  @override
  Color violet900 = const Color.fromARGB(255, 76, 29, 149);
  /* */
  @override
  Color purple100 = const Color.fromARGB(255, 243, 232, 255);
  @override
  Color purple200 = const Color.fromARGB(255, 233, 213, 255);
  @override
  Color purple300 = const Color.fromARGB(255, 216, 180, 254);
  @override
  Color purple400 = const Color.fromARGB(255, 192, 132, 252);
  @override
  Color purple500 = const Color.fromARGB(255, 168, 85, 247);
  @override
  Color purple600 = const Color.fromARGB(255, 147, 51, 234);
  @override
  Color purple700 = const Color.fromARGB(255, 126, 34, 206);
  @override
  Color purple800 = const Color.fromARGB(255, 107, 33, 168);
  @override
  Color purple900 = const Color.fromARGB(255, 88, 28, 135);
  /* */
  @override
  Color fuchsia100 = const Color.fromARGB(255, 250, 232, 255);
  @override
  Color fuchsia200 = const Color.fromARGB(255, 245, 208, 254);
  @override
  Color fuchsia300 = const Color.fromARGB(255, 240, 171, 252);
  @override
  Color fuchsia400 = const Color.fromARGB(255, 232, 121, 249);
  @override
  Color fuchsia500 = const Color.fromARGB(255, 217, 70, 239);
  @override
  Color fuchsia600 = const Color.fromARGB(255, 192, 38, 211);
  @override
  Color fuchsia700 = const Color.fromARGB(255, 162, 28, 175);
  @override
  Color fuchsia800 = const Color.fromARGB(255, 134, 25, 143);
  @override
  Color fuchsia900 = const Color.fromARGB(255, 112, 26, 117);
  /* */
  @override
  Color pink100 = const Color.fromARGB(255, 252, 231, 243);
  @override
  Color pink200 = const Color.fromARGB(255, 251, 207, 232);
  @override
  Color pink300 = const Color.fromARGB(255, 249, 168, 212);
  @override
  Color pink400 = const Color.fromARGB(255, 244, 114, 182);
  @override
  Color pink500 = const Color.fromARGB(255, 236, 72, 153);
  @override
  Color pink600 = const Color.fromARGB(255, 219, 39, 119);
  @override
  Color pink700 = const Color.fromARGB(255, 190, 24, 93);
  @override
  Color pink800 = const Color.fromARGB(255, 157, 23, 77);
  @override
  Color pink900 = const Color.fromARGB(255, 131, 24, 67);

  ///
  /// ------------------ BASIC COLOR ------------------
  ///
}
