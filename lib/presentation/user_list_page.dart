import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flutter_architecture/presentation/user_detail_page.dart';
import 'package:study_flutter_architecture/providers.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
      ),
      body: const SafeArea(
          child: Center(
        child: UserList(),
      )),
    );
  }
}

class UserList extends ConsumerWidget {
  const UserList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userDataListProvider).when(
        data: (users) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final user = users[index];
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    TextButton(
                      child: Text(user.name),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                UserDetailViewPage(userId: user.id),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
            itemCount: users.length,
          );
        },
        error: (e, _) => Text(e.toString()),
        loading: () => const CircularProgressIndicator());
  }
}
