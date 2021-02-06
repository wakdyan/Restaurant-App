import 'package:flutter/material.dart';

import '../themes/app_color.dart';

class FailedView extends StatelessWidget {
  final GestureTapCallback onPressed;

  const FailedView(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/undraw_server_down.png'),
        ListTile(
          title: Text(
            'Tidak dapat terhubung ke server',
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            'Pastikan smartphone kamu terhubung ke internet',
            textAlign: TextAlign.center,
          ),
        ),
        RaisedButton(
          onPressed: onPressed,
          color: AppColor.primary,
          textColor: Colors.white,
          child: Text('COBA LAGI'),
        )
      ],
    );
  }
}
