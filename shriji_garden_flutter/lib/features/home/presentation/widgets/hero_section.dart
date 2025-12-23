import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return SizedBox(
      height: size.height * 0.75,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          CachedNetworkImage(
            imageUrl: AppConstants.galleryImages.first,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppColors.primary.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.primary,
            ),
          ),
          
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  
                  // Title
                  Text(
                    'Find Your Perfect\nWedding Venue',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      height: 1.2,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.2, end: 0),
                  
                  const SizedBox(height: 16),
                  
                  // Subtitle
                  Text(
                    AppConstants.appDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                      height: 1.5,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideY(begin: 0.2, end: 0),
                  
                  const SizedBox(height: 32),
                  
                  // CTA Button
                  ElevatedButton(
                    onPressed: () => context.push('/packages'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      elevation: 4,
                      shadowColor: AppColors.primary.withOpacity(0.4),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Explore Packages',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 400.ms)
                  .slideY(begin: 0.2, end: 0),
                  
                  const Spacer(flex: 3),
                  
                  // Scroll indicator
                  Column(
                    children: [
                      Text(
                        'Scroll to explore',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white.withOpacity(0.6),
                        size: 24,
                      )
                      .animate(
                        onPlay: (controller) => controller.repeat(reverse: true),
                      )
                      .moveY(begin: 0, end: 8, duration: 800.ms),
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
}
