import 'package:{{{fullPath}}}/data/repositories/{{feature_name.snakeCase()}}_repository.dart';
import 'package:{{{fullPath}}}/domain/domain.dart';


class {{feature_name.pascalCase()}}Usecase {
  final {{feature_name.pascalCase()}}Repository repository = {{feature_name.pascalCase()}}Repository();

  {{feature_name.pascalCase()}}Usecase();

  Future<{{feature_name.pascalCase()}}Entity> call() =>
      repository.fetch{{feature_name.pascalCase()}}();
}
