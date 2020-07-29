import 'package:firebase_auth/firebase_auth.dart';
import 'package:pomodoro/models/category.dart';
import 'package:pomodoro/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class User {
  FirebaseUser firebaseUser;
  String uid;
  String username;
  String email;
  int level;
  Tasks tasks;
  Categories categories;

  User.fromFirebaseUser(FirebaseUser user) {
    this.firebaseUser = user;
    this.uid = user.uid;
    this.username = user.displayName;
    this.email = user.email;
    this.level = 1;
    this.tasks = Tasks();
  }

// Query db
Future<void> query() async {
  await Firestore.instance.collection("users").document(this.uid).get().then((result){
      print(result.data);
      this.uid = result.data["uid"];
      this.username = result.data["username"];
      this.email = result.data["email"];
      this.level = result.data["level"];
      this.tasks = Tasks();
      print("user stuff is set");
    });
}

  String getName() {
    return firebaseUser.displayName;
  }

  String getEmail() {
    return firebaseUser.email;
  }

  void addTask(Task job) {
    tasks.add(job);
  }

  void changeName(String newName) {
    // update in firebase
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = newName;
    firebaseUser.updateProfile(updateInfo);
    username = newName;
    // update in firestore
    dbUpdate("username", newName);
  }

  void changeEmail(String newEmail) {
    firebaseUser.updateEmail(newEmail);
    email = newEmail;
    dbUpdate("email", newEmail);
  }

  void dbUpdate(String field, String fieldValue) async {
    // Update passed in field in database
    Firestore db = Firestore.instance;
    await db.collection("users").document(this.uid).updateData({field: fieldValue})
    .then((_) {
      print("update success");
    });
  }

  void changePassword(String newPassword) {
    firebaseUser.updatePassword(newPassword);
  }

  //OLD DB CODE
  /*
  void logout() async {
    // I have no idea if this even works.
    if (database != null)
      await FirebaseDatabase.instance.goOffline();
    database = null;
    firebaseApp = null;    
  }

  asyncSetupShit() async {
    await connectFirebase();
    tasks = Tasks(database, uid);
    categories = Categories(database, uid);
    print('tasks was instantiated');
  }

  Future<void> connectFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    int randomToken = Random().nextInt(999999999);
    print("connecting to database with client id: " + uid + " and token " + randomToken.toString());
    firebaseApp = await FirebaseApp.configure(
        name: 'cs361-pomodoro-' + randomToken.toString(), // just made this up, AFAIK it just needs to be unique in case multiple apps are loaded.
        options: FirebaseOptions(
          clientID: uid,
          googleAppID: '1:439905512526:web:2e6e541c5b4b0c2170a71f',
          apiKey: 'AIzaSyCdc1uMGly7a7zJ_l2v8vM2cibnhpCu8bU',
          databaseURL: 'https://cs361-pomodoro.firebaseio.com',
        ));
    database = FirebaseDatabase(app: firebaseApp);
  }
  */
}
