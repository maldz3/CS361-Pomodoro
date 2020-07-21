import 'package:firebase_database/firebase_database.dart';

class Categories {
  final _innerList = List<Category>();
  final _innerMap = Map<String, Category>();
  DatabaseReference categoriesRef;

  Categories(FirebaseDatabase database, String uid) {
    categoriesRef = database.reference().child('users/' + uid + '/categories');

    retrieve();
  }

  retrieve() {
    
    categoriesRef.once().then((DataSnapshot snapshot) {
       Map<dynamic,dynamic> map = snapshot.value;
       map.forEach((key, value) {
         add(Category.fromJson(key, value));
         });
    });
  }

  int get length { return _innerList.length; }

  Category operator [](String key) {
    // no safety checks are performed
    if (_innerMap.containsKey(key))
      return _innerMap[key];
    else
      return Category("Category not set.");
  }

  void add(Category category) {
    _innerList.add(category);
    _innerMap[category.key] = category;
  }
}

class Category {
  String key = "key not set";
  String _name;
  final  taskKeys = Map<String, String>();

  Category(String name) {
    _name = name;
  }

  String get name {return _name.toString();} // not sure if necessary, want to break reference

  Category.fromJson(String key, Map<dynamic, dynamic> json) {
    this.key = key;
    _name = json['name'];
    json['categories'].forEach((key, value) {
         taskKeys[key] = value;
         });
  }

  void addTaskKey(String taskKey) {
    // add to database if not in database, get key,
    String key = "replace this line with one that does what it should";
    taskKeys[key] = taskKey;
  }
}