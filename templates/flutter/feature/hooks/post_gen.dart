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

Future<void> run(HookContext context) async {
  final logger = context.logger;
  final progress = logger.progress('Configuring your new feature...');

  try {
    final projectRoot = await _findProjectRoot(logger);
    final packageName = await _getPackageName(projectRoot);

    // FIX: Use the helper function instead of .snakeCase
    final featureName = _toSnakeCase(context.vars['feature_name'] as String);

    // 1. Define the final destination for your feature
    final targetParentDir =
        Directory(path.join(projectRoot.path, 'lib', 'app', 'features'));
    final destinationDir =
        Directory(path.join(targetParentDir.path, featureName));

    // 2. Create the target directory if it doesn't exist
    if (!await targetParentDir.exists()) {
      await targetParentDir.create(recursive: true);
    }

    // 3. Set up the 'fullPath' variable for correct imports in templates
    _setupImportVariable(context, packageName, featureName);

    // 4. Move the generated files to their final destination
    final sourceDir = Directory(path.join(Directory.current.path, featureName));

    if (await sourceDir.exists()) {
      await sourceDir.rename(destinationDir.path);
      logger.info(
          '✅ Files moved to ${path.relative(destinationDir.path, from: projectRoot.path)}');
    }

    progress.complete('✅ Your feature is ready!');
    logger.success(
      'Created "${context.vars['feature_name']}" at lib/app/features/$featureName',
    );
  } on Exception catch (e) {
    progress.fail('❌ An error occurred: ${e.toString()}');
    rethrow;
  }
}

/// Finds the project root by searching upwards for a `pubspec.yaml` file.
Future<Directory> _findProjectRoot(Logger logger) async {
  var dir = Directory.current;
  while (true) {
    final pubspecFile = File(path.join(dir.path, 'pubspec.yaml'));
    if (await pubspecFile.exists()) {
      return dir;
    }
    if (dir.parent.path == dir.path) {
      break;
    }
    dir = dir.parent;
  }
  throw Exception(
    'Could not find pubspec.yaml. Make sure you are inside a Flutter project.',
  );
}

/// Reads the package name from the pubspec.yaml file.
Future<String> _getPackageName(Directory projectRoot) async {
  final pubspecFile = File(path.join(projectRoot.path, 'pubspec.yaml'));
  final content = await pubspecFile.readAsString();
  final yamlMap = loadYaml(content);
  final packageName = yamlMap['name'] as String?;
  if (packageName == null || packageName.isEmpty) {
    throw Exception('Could not find a "name" property in pubspec.yaml.');
  }
  return packageName;
}

/// Sets the 'fullPath' variable for use in templates (e.g., for imports).
void _setupImportVariable(
    HookContext context, String packageName, String featureName) {
  final importPath = 'app/features/$featureName';
  context.vars = {
    ...context.vars,
    'fullPath': '$packageName/$importPath',
  };
}
