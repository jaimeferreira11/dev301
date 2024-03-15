import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;

  const CustomAppBar({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      title: Text(
        titulo,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(AppBar().preferredSize.height * 1.1);
}
