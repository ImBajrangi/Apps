import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final testimonials = [
      _Testimonial(
        quote: 'The best wedding venue! The staff was amazing and everything was perfect.',
        author: 'John Doe',
        rating: 5,
      ),
      _Testimonial(
        quote: 'A beautiful place with excellent service. Highly recommended!',
        author: 'Jane Smith',
        rating: 5,
      ),
      _Testimonial(
        quote: 'Our guests couldn\'t stop talking about how stunning the venue was!',
        author: 'Priya Sharma',
        rating: 5,
      ),
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
      child: Column(
        children: [
          Text(
            'What Our Clients Say',
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
          
          const SizedBox(height: 32),
          
          ...testimonials.asMap().entries.map((entry) {
            final index = entry.key;
            final testimonial = entry.value;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _TestimonialCard(
                testimonial: testimonial,
                delay: Duration(milliseconds: 150 * index),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _Testimonial {
  final String quote;
  final String author;
  final int rating;

  const _Testimonial({
    required this.quote,
    required this.author,
    required this.rating,
  });
}

class _TestimonialCard extends StatelessWidget {
  final _Testimonial testimonial;
  final Duration delay;

  const _TestimonialCard({
    required this.testimonial,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade100,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Quote Icon
          Icon(
            Icons.format_quote,
            color: AppColors.primary.withOpacity(0.3),
            size: 32,
          ),
          
          const SizedBox(height: 12),
          
          // Stars
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                index < testimonial.rating ? Icons.star : Icons.star_border,
                color: AppColors.accent,
                size: 20,
              );
            }),
          ),
          
          const SizedBox(height: 16),
          
          // Quote Text
          Text(
            '"${testimonial.quote}"',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Author
          Text(
            '— ${testimonial.author}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    )
    .animate()
    .fadeIn(duration: 500.ms, delay: delay)
    .slideY(begin: 0.1, end: 0);
  }
}
