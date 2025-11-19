// lib/screens/send_money_screen.dart
import 'package:flutter/material.dart';
import 'package:myapp/main.dart'; // Import main.dart for color constants
// No need to import widgets/send_money_button.dart as we use ElevatedButtonTheme

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String? _selectedPaymentMethod = 'Bank Transfer'; // Default value
  bool _isFavoriteTransaction = false;
  bool _transactionSuccess = false;
  bool _isLoading = false;

  final List<String> _paymentMethods = [
    'Bank Transfer',
    'Credit Card',
    'Mobile Wallet',
    'Cryptocurrency',
  ];

  void _sendMoney() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _transactionSuccess = false;
      });

      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      print('Sending Money:');
      print('  Recipient: ${_recipientController.text}');
      print('  Amount: ${_amountController.text}');
      print('  Method: $_selectedPaymentMethod');
      print('  Favorite: $_isFavoriteTransaction');

      setState(() {
        _isLoading = false;
        _transactionSuccess = true;
      });

      // Hide success message after a delay
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted) {
          setState(() {
            _transactionSuccess = false;
          });
        }
      });

      // Optionally clear fields
      _recipientController.clear();
      _amountController.clear();
      setState(() {
        _selectedPaymentMethod = 'Bank Transfer'; // Reset to default
        _isFavoriteTransaction = false;
      });
    }
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'), // App Name in title
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'New Transaction',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: primaryBlue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Recipient Name TextField with improved styling
              TextFormField(
                controller: _recipientController,
                decoration: const InputDecoration(
                  labelText: 'Recipient Name',
                  hintText: 'e.g., Jane Doe',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Recipient name cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Amount TextField with improved styling and validation
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  hintText: 'e.g., 50.00',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Amount cannot be empty';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Amount must be a positive number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Payment Method Dropdown with improved styling
              DropdownButtonFormField<String>(
                initialValue: _selectedPaymentMethod,
                decoration: const InputDecoration(
                  labelText: 'Payment Method',
                  prefixIcon: Icon(Icons.payment),
                ),
                items: _paymentMethods.map((String method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method, style: Theme.of(context).textTheme.bodyMedium),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPaymentMethod = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a payment method';
                  }
                  return null;
                },
                dropdownColor: Theme.of(context).colorScheme.surface, // Dropdown background
                style: Theme.of(context).textTheme.bodyMedium, // Text style for selected item
                icon: const Icon(Icons.arrow_drop_down, color: primaryBlue), // Dropdown icon color
              ),
              const SizedBox(height: 20),

              // Mark as Favorite Switch with custom styling
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface, // White background
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: primaryBlue.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_border, color: accentGold), // Gold star icon
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Mark as Favorite',
                        style: Theme.of(context).textTheme.titleMedium, // Themed text
                      ),
                    ),
                    Switch(
                      value: _isFavoriteTransaction,
                      onChanged: (bool value) {
                        setState(() {
                          _isFavoriteTransaction = value;
                        });
                      },
                      activeThumbColor: secondaryGreen, // Green for active switch
                      inactiveTrackColor: primaryBlue.withOpacity(0.3), // Blue tint for inactive track
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Send Money Button (now using ElevatedButton themed in main.dart)
              _isLoading
                  ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(primaryBlue)))
                  : ElevatedButton(
                      onPressed: _sendMoney,
                      child: const Text('Send Money'), // Text styled via ElevatedButtonTheme
                    ),
              const SizedBox(height: 30),

              // Animated Success Message (Green-themed)
              AnimatedOpacity(
                opacity: _transactionSuccess ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600), // Slightly longer duration
                curve: Curves.easeOutCirc, // More pronounced curve
                child: Container(
                  padding: const EdgeInsets.all(18.0), // More padding
                  decoration: BoxDecoration(
                    color: secondaryGreen.withOpacity(0.15), // Light green background
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                    border: Border.all(color: secondaryGreen, width: 1.5), // Green border
                    boxShadow: [
                      BoxShadow(
                        color: secondaryGreen.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle, color: secondaryGreen, size: 30),
                      const SizedBox(width: 15),
                      Text(
                        'Transaction Successful!',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: secondaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}