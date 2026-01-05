import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/services/booking_service.dart';

class CustomizePage extends StatefulWidget {
  const CustomizePage({super.key});

  @override
  State<CustomizePage> createState() => _CustomizePageState();
}

class _CustomizePageState extends State<CustomizePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _guestsController = TextEditingController();
  final _decorationThemeController = TextEditingController();
  final _requestsController = TextEditingController();

  DateTime? _selectedDate;
  String _eventType = 'Wedding';
  String _catering = 'Vegetarian';
  final List<String> _entertainment = [];

  bool _isSubmitting = false;
  String? _successMessage;
  final _bookingService = BookingService();

  final List<String> _eventTypes = ['Wedding', 'Reception', 'Engagement'];
  final List<String> _cateringOptions = [
    'Vegetarian',
    'Non-Vegetarian',
    'Jain'
  ];
  final List<String> _entertainmentOptions = ['DJ', 'Live Band', 'Dancers'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _guestsController.dispose();
    _decorationThemeController.dispose();
    _requestsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                'Customize Your Event',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primaryDark,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Success Message
                  if (_successMessage != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.success.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle,
                              color: AppColors.success),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _successMessage!,
                              style: const TextStyle(
                                color: AppColors.success,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            onPressed: () =>
                                setState(() => _successMessage = null),
                            color: AppColors.success,
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 300.ms),

                  // Form Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: AppColors.cardShadow,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Personal Information Section
                          _buildSectionTitle('Personal Information'),
                          const SizedBox(height: 16),

                          _buildTextField(
                            controller: _nameController,
                            label: 'Full Name',
                            icon: Icons.person_outline,
                            required: true,
                          ),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  controller: _emailController,
                                  label: 'Email',
                                  icon: Icons.email_outlined,
                                  keyboardType: TextInputType.emailAddress,
                                  required: true,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildTextField(
                                  controller: _phoneController,
                                  label: 'Phone',
                                  icon: Icons.phone_outlined,
                                  keyboardType: TextInputType.phone,
                                  required: true,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 24),

                          // Event Details Section
                          _buildSectionTitle('Event Details'),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              Expanded(child: _buildDateField()),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildTextField(
                                  controller: _guestsController,
                                  label: 'Guests',
                                  icon: Icons.groups_outlined,
                                  keyboardType: TextInputType.number,
                                  required: true,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Event Type
                          Text(
                            'Event Type',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: _eventTypes.map((type) {
                              final isSelected = _eventType == type;
                              return ChoiceChip(
                                label: Text(type),
                                selected: isSelected,
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() => _eventType = type);
                                  }
                                },
                                selectedColor:
                                    AppColors.primary.withOpacity(0.2),
                                labelStyle: TextStyle(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textSecondary,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 24),

                          // Preferences Section
                          _buildSectionTitle('Preferences'),
                          const SizedBox(height: 16),

                          // Catering
                          _buildDropdown(
                            label: 'Catering',
                            value: _catering,
                            items: _cateringOptions,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _catering = value);
                              }
                            },
                          ),

                          const SizedBox(height: 16),

                          _buildTextField(
                            controller: _decorationThemeController,
                            label: 'Decoration Theme',
                            icon: Icons.palette_outlined,
                          ),

                          const SizedBox(height: 16),

                          // Entertainment
                          Text(
                            'Entertainment',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: _entertainmentOptions.map((option) {
                              final isSelected =
                                  _entertainment.contains(option);
                              return FilterChip(
                                label: Text(option),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      _entertainment.add(option);
                                    } else {
                                      _entertainment.remove(option);
                                    }
                                  });
                                },
                                selectedColor:
                                    AppColors.primary.withOpacity(0.2),
                                checkmarkColor: AppColors.primary,
                                labelStyle: TextStyle(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textSecondary,
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 24),

                          // Special Requests
                          _buildTextField(
                            controller: _requestsController,
                            label: 'Special Requests',
                            icon: Icons.note_outlined,
                            maxLines: 3,
                          ),

                          const SizedBox(height: 32),

                          // Submit Button
                          ElevatedButton(
                            onPressed: _isSubmitting ? null : _handleSubmit,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: _isSubmitting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Submit Request'),
                          ),
                        ],
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.05, end: 0),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    bool required = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: required
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              if (label == 'Email' && !value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            }
          : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
      ),
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: _selectDate,
      child: AbsorbPointer(
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Event Date',
            prefixIcon: Icon(Icons.calendar_today_outlined, size: 20),
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
          controller: TextEditingController(
            text: _selectedDate != null
                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                : '',
          ),
          validator: (value) {
            if (_selectedDate == null) {
              return 'Please select a date';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.restaurant_outlined, size: 20),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final formData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'date': _selectedDate?.toIso8601String(),
      'guests': _guestsController.text,
      'eventType': _eventType,
      'catering': _catering,
      'decorationTheme': _decorationThemeController.text,
      'entertainment': _entertainment,
      'requests': _requestsController.text,
      'package': 'Customized Package',
      'status': 'pending',
    };

    try {
      await _bookingService.submitBooking(formData);

      setState(() {
        _successMessage = 'Your request has been submitted successfully!';
        // Reset form
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _guestsController.clear();
        _decorationThemeController.clear();
        _requestsController.clear();
        _selectedDate = null;
        _eventType = 'Wedding';
        _catering = 'Vegetarian';
        _entertainment.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }
}
