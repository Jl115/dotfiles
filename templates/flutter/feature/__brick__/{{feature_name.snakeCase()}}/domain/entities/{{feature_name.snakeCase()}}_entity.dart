import 'package:uuid/uuid.dart';
import 'package:{{{fullPath}}}/domain/entities/{{feature_name.snakeCase()}}_entity.dart';

class {{feature_name.pascalCase()}}Entity {
  final String id;

  {{feature_name.pascalCase()}}Entity({
    String? id,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() => {
    'id': id,
  };

  Map<String, dynamic> toDatabaseJson() => {
    'id': id,
  };

  @override
  String toString() => '{{$feature_name.pascalCase()}}Entity(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is {{feature_name.pascalCase()}}Entity && other.id == id;
  }


  @override
  int get hashCode => id.hashCode;
}