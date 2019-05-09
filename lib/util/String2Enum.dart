/*import 'dart:mirrors';

enum Visibility {VISIBLE, COLLAPSED, HIDDEN}

class EnumFromString<T>
  T get(String value) {
    return (reflectType(T) as ClassMirror).getField(#values).reflectee.firstWhere((e)=>e.toString().split('.')[1].toUpperCase()==value.toUpperCase());
  }
}

dynamic enumFromString(String value, t) {
  return (reflectType(t) as ClassMirror).getField(#values).reflectee.firstWhere((e)=>e.toString().split('.')[1].toUpperCase()==value.toUpperCase());
}

void main() {
  var converter = new EnumFromString<Visibility>();

  Visibility x = converter.get('COLLAPSED');
  print(x);

  Visibility y = enumFromString('HIDDEN', Visibility);
  print(y);
}*/