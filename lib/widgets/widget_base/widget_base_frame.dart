import 'package:flutter/cupertino.dart';

class BaseWidgetFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF9CC06F)),
      width: MediaQuery.of(context).size.width * 0.25,
    );
  }
}
