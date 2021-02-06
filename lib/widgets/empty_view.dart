import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const EmptyView({this.imagePath, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath),
        ListTile(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            subtitle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
