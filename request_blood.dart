import 'package:flutter/material.dart';

class RequestBlood extends StatefulWidget {
  @override
  _RequestBloodState createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  final _formKey = GlobalKey<FormState>();
  String _selectedBloodGroup = 'A+';
  String _urgency = 'Emergency';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Blood'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Icon(Icons.emergency, size: 64, color: Colors.red),
              SizedBox(height: 20),
              Text(
                'Emergency Blood Request',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Patient Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter patient name' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Hospital Name',
                  prefixIcon: Icon(Icons.local_hospital),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter hospital name' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField(
                value: _selectedBloodGroup,
                decoration: InputDecoration(
                  labelText: 'Blood Group Needed',
                  prefixIcon: Icon(Icons.bloodtype),
                  border: OutlineInputBorder(),
                ),
                items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].map((group) {
                  return DropdownMenuItem(value: group, child: Text(group));
                }).toList(),
                onChanged: (value) => setState(() => _selectedBloodGroup = value!),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Enter contact number' : null,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _showRequestDialog();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Submit Emergency Request', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRequestDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Icon(Icons.check_circle, color: Colors.green, size: 48),
        content: Text('Request submitted! Donors will be notified.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}