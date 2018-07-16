import 'package:database_crud_sample/Model/user.dart';
import 'package:database_crud_sample/Utils/database_helper.dart';
import 'package:flutter/material.dart';

List users;
void main() async {
  var db = new DataBaseHelper();

  int saveuser = await db.saveUser(new User("nelzkie","nelzkie"));

  print(saveuser);

  users = await db.getAllUsers();
  

  runApp(MaterialApp(
    title: "DataBase",
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DataBase"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: new ListView.builder(
        itemCount: users.length,
        itemBuilder: (_,int position){

          var user = User.fromMap(users[position]);
          return new Card(
            color: Colors.white,
            elevation: 2.0,
            child: new ListTile(
              leading: CircleAvatar(
                child: Text(user.username.substring(0,1).toUpperCase()),
              ),
              title: Text(user.username),
              subtitle: Text("ID: ${user.id}"),
              onTap: () => debugPrint("$user"),
            ),
          );
        }
          
      ),
    );
  }
}
