import 'package:{{{fullPath}}}/data/datasource/{{feature_name.snakeCase()}}_datasource.dart';
import 'package:{{{fullPath}}}/domain/entities/{{feature_name.snakeCase()}}_entity.dart';   

class {{feature_name.pascalCase()}}Repository {
  final {{feature_name.pascalCase()}}DataSource local = {{feature_name.pascalCase()}}DataSource();

  {{feature_name.pascalCase()}}Repository();

  Future<{{feature_name.pascalCase()}}Entity> fetch{{feature_name.pascalCase()}}() async {
    return local.fetch{{feature_name.pascalCase()}}();
  }
}

