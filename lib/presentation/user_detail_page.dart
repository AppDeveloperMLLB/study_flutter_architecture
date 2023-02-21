import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flutter_architecture/providers.dart';

class UserDetailViewPage extends ConsumerWidget {
  final String userId;
  const UserDetailViewPage({
    super.key,
    required this.userId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Detail"),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: UserDetailView(userId: userId),
          ),
        ),
      ),
    );
  }
}

class UserDetailView extends ConsumerWidget {
  final String userId;
  const UserDetailView({
    super.key,
    required this.userId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetail = ref.watch(userDetailProvider(userId));

    return userDetail.when(
      data: (data) {
        return Column(
          children: [
            Text(
              data.hobby,
            ),
            Text(
              data.followerCount.toString(),
            ),
            FollowToggleButton(userId: userId),
          ],
        );
      },
      error: (error, _) => Text(
        error.toString(),
      ),
      loading: (() => const CircularProgressIndicator()),
    );
  }
}

class FollowToggleButton extends ConsumerWidget {
  final String userId;
  const FollowToggleButton({
    super.key,
    required this.userId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followedUser = ref.watch(followedUserProvider(userId));
    return followedUser.when(
      data: (followed) => ElevatedButton(
        onPressed: () {
          if (followed) {
            ref.read(userDetailProvider(userId).notifier).unfollow();
          } else {
            ref.read(userDetailProvider(userId).notifier).follow();
          }
        },
        child: Text(followed ? "Unfollow" : "Follow"),
      ),
      error: (e, _) => Text(e.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
