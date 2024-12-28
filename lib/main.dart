import 'package:famcards/features/cards/presentation/pages/home_screen.dart';
import 'package:famcards/features/cards/presentation/cubit/card_cubit.dart';
import 'package:famcards/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CardCubit>(), // Use Cubit from GetIt
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fam Flutter Assignment',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
