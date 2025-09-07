import 'package:{{{fullPath}}}/domain/entities/{{feature_name.snakeCase()}}_entity.dart';
import 'package:{{{fullPath}}}/data/models/{{feature_name.snakeCase()}}_model.dart';

class {{feature_name.pascalCase()}}DataSource {
  {{feature_name.pascalCase()}}DataSource();

  Future<{{feature_name.pascalCase()}}Entity> fetch{{feature_name.pascalCase()}}() async {
    await Future.delayed(const Duration(seconds: 1));
    return {{feature_name.pascalCase()}}Model();
  }

  Future<void> create{{feature_name.pascalCase()}}({{feature_name.pascalCase()}}Entity entity) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> update{{feature_name.pascalCase()}}({{feature_name.pascalCase()}}Entity entity) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> delete{{feature_name.pascalCase()}}(String id) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
