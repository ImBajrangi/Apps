import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/models/booking_request_model.dart';
import '../../../../core/services/booking_service.dart';

class AdminRequestsPage extends StatelessWidget {
  const AdminRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingService = BookingService();
    
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: StreamBuilder<List<BookingRequest>>(
        stream: bookingService.getBookingsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Error loading bookings: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          final requests = snapshot.data ?? [];
          final isLoading = snapshot.connectionState == ConnectionState.waiting && requests.isEmpty;
          
          return CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                expandedHeight: 120,
                floating: false,
                pinned: true,
                backgroundColor: const Color(0xFF111827),
                elevation: 0,
                leading: const BackButton(color: Colors.white),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: const Text(
                    'Admin Panel',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF1F2937),
                          Color(0xFF111827),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Submitted Requests',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ).animate().fadeIn(duration: 400.ms),
                      
                      const SizedBox(height: 8),
                      
                      if (isLoading)
                        const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      else
                        Text(
                          '${requests.length} total requests',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
                    ],
                  ),
                ),
              ),
              
              // Request Cards
              if (requests.isEmpty && !isLoading)
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 64,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No requests submitted yet.',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final request = requests[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _RequestCard(
                            request: request,
                            animationDelay: Duration(milliseconds: 100 * index),
                            bookingService: bookingService,
                          ),
                        );
                      },
                      childCount: requests.length,
                    ),
                  ),
                ),
              
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final BookingRequest request;
  final Duration animationDelay;
  final BookingService bookingService;

  const _RequestCard({
    required this.request,
    required this.animationDelay,
    required this.bookingService,
  });

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _showContactMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Contact Customer',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.blue),
              title: const Text('Call Phone'),
              onTap: () {
                Navigator.pop(context);
                _launchUrl('tel:${request.phone}');
              },
            ),
            ListTile(
              leading: const Icon(Icons.message, color: Colors.green),
              title: const Text('Send SMS'),
              onTap: () {
                Navigator.pop(context);
                _launchUrl('sms:${request.phone}');
              },
            ),
            if (request.email.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.email, color: Colors.orange),
                title: const Text('Send Email'),
                onTap: () {
                  Navigator.pop(context);
                  _launchUrl('mailto:${request.email}?subject=Booking at ShriJi Garden');
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');
    final bool isApproved = request.status == 'approved';
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isApproved ? Colors.green.withOpacity(0.05) : AppColors.primary.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (isApproved ? Colors.green : AppColors.primary).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      request.name.isNotEmpty ? request.name[0].toUpperCase() : 'U',
                      style: TextStyle(
                        color: isApproved ? Colors.green : AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        request.email,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (request.packageName != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (isApproved ? Colors.green : AppColors.primary).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      request.packageName!,
                      style: TextStyle(
                        color: isApproved ? Colors.green : AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _DetailRow(
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: request.phone,
                ),
                if (request.date != null)
                  _DetailRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Event Date',
                    value: request.date!,
                  ),
                if (request.guests != null)
                  _DetailRow(
                    icon: Icons.groups_outlined,
                    label: 'Guests',
                    value: request.guests!,
                  ),
                if (request.eventType != null)
                    _DetailRow(
                      icon: Icons.celebration_outlined,
                      label: 'Type',
                      value: request.eventType!,
                    ),
                if (request.requests != null && request.requests!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.note_outlined, size: 18, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            request.requests!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const Divider(height: 24),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'Submitted: ${dateFormat.format(request.submittedAt)} ${timeFormat.format(request.submittedAt)}',
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isApproved ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        request.status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isApproved ? Colors.green : Colors.orange,
                        ),
                      ),
                    ),
                   ],
                ),
              ],
            ),
          ),
          
          // Actions
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isApproved)
                  TextButton.icon(
                    onPressed: () => _showContactMenu(context),
                    icon: const Icon(Icons.contact_phone_outlined, size: 18),
                    label: const Text('Contact'),
                  ),
                const SizedBox(width: 8),
                if (!isApproved)
                  ElevatedButton.icon(
                    onPressed: () {
                      if (request.docId != null) {
                        bookingService.updateBookingStatus(request.docId!, 'approved');
                      }
                    },
                    icon: const Icon(Icons.check, size: 18),
                    label: const Text('Approve'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: Colors.white,
                    ),
                  )
                else
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 18),
                        SizedBox(width: 4),
                        Text('Approved', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
                
                // Allow deleting old requests
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                  onPressed: () {
                    if (request.docId != null) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Booking?'),
                          content: const Text('This will permanently remove this record.'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                            TextButton(
                              onPressed: () {
                                FirebaseFirestore.instance.collection('bookings').doc(request.docId).delete();
                                Navigator.pop(context);
                              }, 
                              child: const Text('Delete', style: TextStyle(color: Colors.red))
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    )
    .animate()
    .fadeIn(duration: 400.ms, delay: animationDelay)
    .slideY(begin: 0.05, end: 0);
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
