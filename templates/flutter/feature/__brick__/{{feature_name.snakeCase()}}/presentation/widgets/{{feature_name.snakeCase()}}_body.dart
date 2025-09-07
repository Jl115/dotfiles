import 'package:flutter/material.dart';
import 'package:{{{fullPath}}}/presentation/bloc/bloc.dart';

/// {@template {{feature_name.snakeCase()}}_body}
/// Body of the {{feature_name.pascalCase()}}Page.
///
/// Add what it does
/// {@endtemplate}
class {{feature_name.pascalCase()}}Body extends StatelessWidget {
  /// {@macro {{feature_name.snakeCase()}}_body}
  const {{feature_name.pascalCase()}}Body({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<{{feature_name.pascalCase()}}Bloc, {{feature_name.pascalCase()}}State>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }
}
