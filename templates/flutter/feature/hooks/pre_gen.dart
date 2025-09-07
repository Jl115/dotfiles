import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

// Helper function to convert strings from camelCase or PascalCase to snake_case
String _toSnakeCase(String text) {
  if (text.isEmpty) return '';
  final regex = RegExp('(?<=[a-z])[A-Z]');
  return text.replaceAllMapped(regex, (m) => '_${m.group(0)}').toLowerCase();
}

/// Finds the project root by searching upwards for a `pubspec.yaml` file.
Future<Directory> _findProjectRoot() async {
  var dir = Directory.current;
  while (true) {
    final pubspecFile = File(path.join(dir.path, 'pubspec.yaml'));
    if (await pubspecFile.exists()) {
      return dir;
    }
    // Stop if we reach the root of the filesystem
    if (dir.parent.path == dir.path) {
      break;
    }
    dir = dir.parent;
  }
  throw Exception(
    'Could not find pubspec.yaml. Make sure you are running this command inside a Flutter project.',
  );
}

Future<void> run(HookContext context) async {
  final logger = context.logger;
  final progress = logger.progress('Configuring feature variables...');

  try {
    // 1. Find the project root directory, regardless of where the command is run.
    final projectRoot = await _findProjectRoot();
    logger.info('✅ Project root found at: ${projectRoot.path}');

    // 2. Read the package name from the pubspec.yaml at the project root.
    final pubspecFile = File(path.join(projectRoot.path, 'pubspec.yaml'));
    final content = await pubspecFile.readAsString();
    final yamlMap = loadYaml(content);
    final packageName = yamlMap['name'] as String?;

    if (packageName == null || packageName.isEmpty) {
      throw Exception('Could not find a "name" property in pubspec.yaml.');
    }

    // 3. Get the feature name and convert it to snake_case using our helper.
    final featureNameInput = context.vars['feature_name'] as String;
    final featureName = _toSnakeCase(featureNameInput);

    // 4. Set the 'fullPath' variable for use in your templates (e.g., for imports).
    // This path is now consistently pointing to the correct location.
    final importPath = 'app/features/$featureName';
    context.vars = {
      ...context.vars,
      // 'fullPath' will be like: my_package_name/app/features/my_new_feature
      'fullPath': '$packageName/$importPath',
    };

    progress.complete('✅ Variables configured successfully!');
  } on Exception catch (e) {
    progress.fail('❌ An error occurred: ${e.toString()}');
    // Re-throw the exception to make the mason command fail.
    rethrow;
  }
}
