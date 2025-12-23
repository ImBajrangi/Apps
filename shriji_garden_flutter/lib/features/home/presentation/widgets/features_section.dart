import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      _FeatureItem(
        icon: Icons.diamond_outlined,
        title: 'Beautiful Venue',
        description: 'A stunning location that provides the perfect backdrop for your wedding.',
        color: AppColors.primary,
      ),
      _FeatureItem(
        icon: Icons.favorite_border,
        title: 'Customizable Packages',
        description: 'Choose from a variety of packages or create your own to suit your needs.',
        color: AppColors.secondary,
      ),
      _FeatureItem(
        icon: Icons.groups_outlined,
        title: 'Professional Services',
        description: 'Our experienced team will ensure every detail is taken care of.',
        color: AppColors.accent,
      ),
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Why Choose Us',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ).animate().fadeIn(duration: 500.ms),
          
          const SizedBox(height: 8),
          
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          const SizedBox(height: 40),
          
          ...features.asMap().entries.map((entry) {
            final index = entry.key;
            final feature = entry.value;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _FeatureCard(
                feature: feature,
                delay: Duration(milliseconds: 100 * index),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class _FeatureCard extends StatelessWidget {
  final _FeatureItem feature;
  final Duration delay;

  const _FeatureCard({
    required this.feature,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade100,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: feature.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              feature.icon,
              color: feature.color,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feature.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
    .animate()
    .fadeIn(duration: 500.ms, delay: delay)
    .slideX(begin: 0.1, end: 0);
  }
}
