import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DonorRegistration extends StatefulWidget {
  @override
  _DonorRegistrationState createState() => _DonorRegistrationState();
}

class _DonorRegistrationState extends State<DonorRegistration> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  String _selectedBloodGroup = 'A+';
  bool _isSubmitting = false;

  final List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  Future<void> _registerDonor() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      final donorData = {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'bloodGroup': _selectedBloodGroup,
        'city': _cityController.text,
        'lastDonated': DateTime.now().toIso8601String(),
        'isAvailable': true,
      };

      try {
        final response = await http.post(
          Uri.parse('http://localhost:5000/api/donors'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(donorData),
        );

        if (response.statusCode == 201) {
          _showSuccessDialog();
        } else {
          _showErrorDialog('Registration failed. Please try again.');
        }
      } catch (e) {
        _showErrorDialog('Network error. Is backend running?');
      } finally {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Icon(Icons.check_circle, color: Colors.green, size: 48),
        content: Text('You are now a registered donor!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Become a Donor'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Icon(Icons.favorite, size: 64, color: Colors.red),
              SizedBox(height: 20),
              Text(
                'Save Lives by Donating Blood',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Enter phone number' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField(
                value: _selectedBloodGroup,
                decoration: InputDecoration(
                  labelText: 'Blood Group',
                  prefixIcon: Icon(Icons.bloodtype),
                  border: OutlineInputBorder(),
                ),
                items: bloodGroups.map((group) {
                  return DropdownMenuItem(value: group, child: Text(group));
                }).toList(),
                onChanged: (value) => setState(() => _selectedBloodGroup = value!),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter your city' : null,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _registerDonor,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: _isSubmitting
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Register as Donor', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}