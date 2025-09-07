import 'package:flutter/material.dart';
import 'package:{{{fullPath}}}/presentation/bloc/bloc.dart';
import 'package:{{{fullPath}}}/presentation/widgets/widgets.dart';

/// {@template {{feature_name.snakeCase()}}_page}
/// A description for {{feature_name.pascalCase()}}Page
/// {@endtemplate}
class {{feature_name.pascalCase()}}Page extends StatelessWidget {
  /// {@macro {{feature_name.snakeCase()}}_page}
  const {{feature_name.pascalCase()}}Page({super.key});

  /// The static route for {{feature_name.pascalCase()}}Page
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const {{feature_name.pascalCase()}}Page());
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{feature_name.pascalCase()}}Bloc(),
      child: const Scaffold(
        body: {{feature_name.pascalCase()}}Body(),
      ),
    );
  } 
}

