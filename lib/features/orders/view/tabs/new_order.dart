import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:linen_republic_admin/utils/responsive/responsive.dart';

class NewOrders extends StatelessWidget {
  const NewOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Responsive.height * 0.14,
          width: Responsive.width,
          color: colorGrey3,
        )
      ],
    );
  }
}
