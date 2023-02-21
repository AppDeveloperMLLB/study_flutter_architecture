import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flutter_architecture/repository/user_repository.dart';
import 'package:study_flutter_architecture/user_data.dart';

/// ユーザー一覧を取得するプロバイダー
final userDataListProvider =
    AutoDisposeAsyncNotifierProvider<UserDataList, List<UserData>>(
        UserDataList.new);

class UserDataList extends AutoDisposeAsyncNotifier<List<UserData>> {
  @override
  Future<List<UserData>> build() {
    return UserRepository.instance.getUsers();
  }
}

/// ユーザー詳細を取得するプロバイダー
final userDetailProvider = AutoDisposeAsyncNotifierProviderFamily<
    UserDetailController, UserDetail, String>(UserDetailController.new);

class UserDetailController
    extends AutoDisposeFamilyAsyncNotifier<UserDetail, String> {
  late String _userId;

  @override
  Future<UserDetail> build(String userId) async {
    _userId = userId;
    return UserRepository.instance.getUserDetail(_userId);
  }

  Future<void> follow() async {
    state = const AsyncLoading();
    await UserRepository.instance.follow(_userId);
    ref.invalidateSelf();
    ref.invalidate(followedUserListProvider);
    ref.invalidate(followedUserProvider);
  }

  Future<void> unfollow() async {
    state = const AsyncLoading();
    await UserRepository.instance.unfollow(_userId);
    ref.invalidateSelf();
    ref.invalidate(followedUserListProvider);
    ref.invalidate(followedUserProvider);
  }
}

/// フォローしているユーザー一覧を取得するプロバイダー
final followedUserListProvider =
    AutoDisposeAsyncNotifierProvider<FollowedUserList, List<UserData>>(
        FollowedUserList.new);

class FollowedUserList extends AutoDisposeAsyncNotifier<List<UserData>> {
  @override
  Future<List<UserData>> build() {
    return UserRepository.instance.getFollowedUsers();
  }
}

/// フォローしているか取得するプロバイダー
final followedUserProvider =
    AutoDisposeAsyncNotifierProviderFamily<FollowedUser, bool, String>(
        FollowedUser.new);

class FollowedUser extends AutoDisposeFamilyAsyncNotifier<bool, String> {
  late String _userId;

  @override
  Future<bool> build(String userId) {
    _userId = userId;
    return UserRepository.instance.followed(_userId);
  }
}
