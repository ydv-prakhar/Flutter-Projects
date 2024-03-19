import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final String title;
  final Widget leading;
  final void Function()? onTap;

  const DrawerTile({required this.title, required this.leading, required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      title: Text(title),
      leading: leading,
      onTap: onTap
    );
  }
}