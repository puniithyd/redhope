import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Emergency banner (matches your site)
          Container(
            width: double.infinity,
            color: const Color(0xFFFFE5E5),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: const Text(
              '🔴 0 Critical requests right now',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          
          // Main content
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bloodtype,
                      size: 80,
                      color: Colors.red[700],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Give blood.\nGive life.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'RedHope connects blood donors with hospitals in emergency situations.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'One donation can save up to three lives.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 48),
                    
                    // Become a Donor Button
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/register'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Become a Donor',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Find Donors Button
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/donors'),
                      child: const Text('Find Donors →', style: TextStyle(fontSize: 16)),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // NEW: Request Blood Button (Emergency)
                    OutlinedButton(
                      onPressed: () => Navigator.pushNamed(context, '/request'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Request Blood 🚨', style: TextStyle(color: Colors.red, fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}