import 'package:bottom_bar_matu/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:linen_republic_admin/colors/colors.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomBarDoubleBullet(
      backgroundColor: blackColor,
      color: whiteColor,
      selectedIndex: 0,
      onSelect: (index) {
        indexChangeNotifier.value = index;
      },
      items: [
        BottomBarItem(iconData: CupertinoIcons.home, label: 'Home'),
        BottomBarItem(iconData: CupertinoIcons.percent, label: 'Coupons'),
        BottomBarItem(iconData: CupertinoIcons.add, label: 'Product'),
        BottomBarItem(iconData: CupertinoIcons.person_3_fill, label: 'Users')
      ],
    );
  }
}
