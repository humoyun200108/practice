import 'package:flutter/material.dart';
import 'package:new_project/models/usermodel.dart';
import 'package:new_project/service/get_user.dart';
import 'package:new_project/service/local/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    tz.initializeTimeZones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Alert App")),
      body: FutureBuilder(
          future: GetUserService.getUserService(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              List<UserModel> data = snapshot.data as List<UserModel>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (DismissDirection direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          await NotificationService().showNotification(
                              id: index,
                              title: "Ogohlantirish",
                              body:
                                  "${data[index].name.toString()} o'chirildi");
                        }
                      },
                      child: ListTile(
                        title: Text(data[index].name.toString()),
                        subtitle: Text(data[index].email.toString()),
                      ));
                },
                itemCount: data.length,
              );
            }
          }),
    );
  }
}
