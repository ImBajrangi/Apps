import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/hero_section.dart';
import '../widgets/features_section.dart';
import '../widgets/gallery_preview_section.dart';
import '../widgets/testimonials_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar that fades with scroll
          SliverAppBar(
            expandedHeight: 60,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 12),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.local_florist,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'ShriJi Garden',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.phone_outlined),
                onPressed: () => context.push('/contact'),
              ),
              const SizedBox(width: 8),
            ],
          ),
          
          // Hero Section
          const SliverToBoxAdapter(
            child: HeroSection(),
          ),
          
          // Features Section
          const SliverToBoxAdapter(
            child: FeaturesSection(),
          ),
          
          // Gallery Preview Section
          const SliverToBoxAdapter(
            child: GalleryPreviewSection(),
          ),
          
          // Testimonials Section
          const SliverToBoxAdapter(
            child: TestimonialsSection(),
          ),
          
          // Footer
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFF111827),
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  Text(
                    '© 2025 ShriJi Garden. All rights reserved.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(Icons.facebook, () {}),
                      _buildSocialIcon(Icons.camera_alt_outlined, () {}),
                      _buildSocialIcon(Icons.alternate_email, () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
