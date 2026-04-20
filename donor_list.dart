import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DonorList extends StatefulWidget {
  @override
  _DonorListState createState() => _DonorListState();
}

class _DonorListState extends State<DonorList> {
  List<dynamic> donors = [];
  bool _isLoading = true;
  String _selectedBloodGroup = 'All';
  String _selectedCity = '';

  final List<String> bloodGroups = ['All', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  @override
  void initState() {
    super.initState();
    _fetchDonors();
  }

  Future<void> _fetchDonors() async {
    setState(() => _isLoading = true);
    
    try {
      String url = 'http://localhost:5000/api/donors';
      if (_selectedBloodGroup != 'All') {
        url += '?bloodGroup=$_selectedBloodGroup';
      }
      
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        setState(() {
          donors = json.decode(response.body);
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text('Failed to load donors. Is backend running?'),
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
        title: Text('Available Donors'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          // Filter section
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    value: _selectedBloodGroup,
                    decoration: InputDecoration(
                      labelText: 'Blood Group',
                      border: OutlineInputBorder(),
                    ),
                    items: bloodGroups.map((group) {
                      return DropdownMenuItem(value: group, child: Text(group));
                    }).toList(),
                    onChanged: (value) {
                      setState(() => _selectedBloodGroup = value!);
                      _fetchDonors();
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _fetchDonors,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text('Search'),
                  ),
                ),
              ],
            ),
          ),
          
          // Donors list
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : donors.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.people_outline, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('No donors found', style: TextStyle(fontSize: 18)),
                            SizedBox(height: 8),
                            Text('Try different blood group or check back later'),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: donors.length,
                        itemBuilder: (ctx, index) {
                          final donor = donors[index];
                          return Card(
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.red[100],
                                child: Icon(Icons.bloodtype, color: Colors.red),
                              ),
                              title: Text(donor['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Blood: ${donor['bloodGroup']}'),
                                  Text('📍 ${donor['city']}'),
                                  Text('📞 ${donor['phone']}'),
                                ],
                              ),
                              trailing: Icon(Icons.phone, color: Colors.green),
                              isThreeLine: true,
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/register'),
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}