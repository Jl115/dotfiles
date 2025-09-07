import 'package:{{{fullPath}}}/domain/entities/{{feature_name.snakeCase()}}_entity.dart';

class {{feature_name.pascalCase()}}Model extends {{feature_name.pascalCase()}}Entity {
  {{feature_name.pascalCase()}}Model() {
  }

  factory {{feature_name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) {
    return {{feature_name.pascalCase()}}Model();
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  Map<String, dynamic> toDatabaseJson() {
    return toJson();
  }
}
