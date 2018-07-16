class User {
  String username;
  String password;
  int id;

  User(this.username, this.password);
  User.map(dynamic obj) {
    this.username = obj["username"];
    this.password = obj["password"];
    this.id = obj["id"];
  }
  String get UserName => username;
  String get PassWord => password;
  int get ID => id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }


  User.fromMap(Map<String,dynamic> map){
    this.username = map["username"];
    this.password = map["password"];
    this.id = map["id"];
  }

}
