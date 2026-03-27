import 'package:flutter/material.dart';
import 'utils/theme.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'services/ml_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final mlService = MLService();
  await mlService.loadModel();

  runApp(
    MultiProvider(
      providers: [
        Provider<MLService>.value(value: mlService),
      ],
      child: const CircularEconomyApp(),
    ),
  );
}

class CircularEconomyApp extends StatelessWidget {
  const CircularEconomyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Economy Assistant',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
