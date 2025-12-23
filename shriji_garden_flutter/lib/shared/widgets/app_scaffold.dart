import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class AppScaffold extends StatefulWidget {
  final Widget child;

  const AppScaffold({
    super.key,
    required this.child,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _currentIndex = 0;

  final List<_NavItem> _navItems = [
    _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home', path: '/'),
    _NavItem(icon: Icons.local_offer_outlined, activeIcon: Icons.local_offer, label: 'Packages', path: '/packages'),
    _NavItem(icon: Icons.tune_outlined, activeIcon: Icons.tune, label: 'Customize', path: '/customize'),
    _NavItem(icon: Icons.photo_library_outlined, activeIcon: Icons.photo_library, label: 'Gallery', path: '/gallery'),
    _NavItem(icon: Icons.info_outline, activeIcon: Icons.info, label: 'About', path: '/about'),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    _currentIndex = _getIndexFromLocation(location);

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _navItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected = _currentIndex == index;
                
                return _buildNavItem(
                  item: item,
                  isSelected: isSelected,
                  onTap: () => _onNavTap(index),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required _NavItem item,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? item.activeIcon : item.icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                item.label,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  int _getIndexFromLocation(String location) {
    for (int i = 0; i < _navItems.length; i++) {
      if (_navItems[i].path == location) {
        return i;
      }
    }
    if (location == '/contact' || location == '/admin/requests') {
      return -1; // No highlight for these pages
    }
    return 0;
  }

  void _onNavTap(int index) {
    if (_currentIndex != index) {
      setState(() => _currentIndex = index);
      context.go(_navItems[index].path);
    }
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String path;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.path,
  });
}
