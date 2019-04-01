import 'package:flutter/material.dart';

enum ActiveMenu { HOME, ACCOUNT, SCHEDULE, INFO }

class BottomNav extends StatelessWidget {
  final ActiveMenu activeMenu;
  final List<BottomNavItem> menuItem;

  BottomNav({
    this.activeMenu = ActiveMenu.HOME,
    this.menuItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 55.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: menuItem,
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final Color color;
  final VoidCallback onTap;

  BottomNavItem({
    @required this.icon,
    this.isActive = false,
    this.color = Colors.grey,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? color : Colors.black,
          ),
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
              size: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
