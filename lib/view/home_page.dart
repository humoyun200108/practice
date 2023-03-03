import 'package:flutter/material.dart';

import 'package:new_project/provider/home_provider.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Practice",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
            ),
            body: Builder(
              builder: (context) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://source.unsplash.com/random/$index"),
                        ),
                        title: Text(provider.data![index].name.toString()),
                        subtitle: Text(
                            "Phone: " + provider.data![index].phone.toString()),
                        trailing: Text(provider.data![index].id.toString()),
                      );
                    },
                    itemCount: provider.data!.length,
                  );
                }
              },
            ));
      },
    );
  }
}
