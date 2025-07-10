
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supan/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xszpbcdpumhrultmjxbj.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhzenBiY2RwdW1ocnVsdG1qeGJqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIxNzgwMTAsImV4cCI6MjA2Nzc1NDAxMH0.dG_sKLxsqZhwIZV_KX0Rky7uoUtmicrl5wINNWRSyVA', // <<< REPLACE with your Supabase Project Anon Key
  );

  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Fee Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}