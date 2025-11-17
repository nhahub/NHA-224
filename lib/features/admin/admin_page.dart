import 'admin_dashboard.dart';
import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/widgets/app_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  Future<bool> _checkIsAdmin() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (!doc.exists) return false;
    final data = doc.data();
    if (data == null) return false;
    final role = data['role'];
    return role == 'admin' || role == 'superadmin';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Admin'),
      body: FutureBuilder<bool>(
        future: _checkIsAdmin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final isAdmin = snapshot.data ?? false;
          if (!isAdmin) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('You do not have admin access.'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(AppRoutes.home);
                      },
                      child: const Text('Return Home'),
                    ),
                  ],
                ),
              ),
            );
          }

          return const AdminDashboard();
        },
      ),
    );
  }
}
