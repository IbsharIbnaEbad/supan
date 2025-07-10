import 'package:flutter/material.dart';
import 'package:supan/fee_management_screen.dart';
import 'package:supan/login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser; // Get current user
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${user?.email ?? 'User'}!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await supabase.auth.signOut();
              // After logout, navigate back to login screen
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.payment, size: 28),
          label: const Text('Manage Fees', style: TextStyle(fontSize: 20)),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => FeeManagementScreen()));
          },
        ),
      ),
    );
  }
}