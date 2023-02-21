import 'dart:math';
import 'package:study_flutter_architecture/user_data.dart';

/// ユーザーデータのリポジトリ
class UserRepository {
  static final instance = UserRepository._();
  UserRepository._();

  List<UserData> userList = List.generate(
    10,
    (index) => UserData(
      "$index",
      "name$index",
      index + 5,
    ),
  );

  List<String> followedUserIdList = [];

  static final _hobbies = [
    "Soccer",
    "Baseball",
    "Volleyball",
    "AmericanFootball",
    "Basketball",
    "Sumo",
    "Golf",
    "Music",
    "Book",
    "Game",
    "Walking",
  ];

  List<UserDetail> userDetails = List.generate(
    10,
    (index) => UserDetail(
      userId: "$index",
      hobby: _hobbies[index],
      followerCount: index + 10,
    ),
  );

  Future<List<UserData>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return userList;
  }

  Future<UserDetail> getUserDetail(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = userDetails.indexWhere((element) => element.userId == userId);
    return userDetails[index];
  }

  Future<void> follow(String userId) async {
    await Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
    );

    final index = userDetails.indexWhere((element) => element.userId == userId);
    final userDetail = userDetails[index];
    userDetails = List.of(userDetails)
      ..[index] = userDetail.incrementFollowerCount();

    followedUserIdList.add(userId);
  }

  Future<void> unfollow(String userId) async {
    await Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
    );

    final index = userDetails.indexWhere((element) => element.userId == userId);
    final userDetail = userDetails[index];
    userDetails = List.of(userDetails)
      ..[index] = userDetail.decrementFollowerCount();
    followedUserIdList.removeWhere((element) => element == userId);
  }

  Future<List<UserData>> getFollowedUsers() async {
    await Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
    );
    return followedUserIdList
        .map(
          (e) => userList.firstWhere((element) => element.id == e),
        )
        .toList();
  }

  Future<bool> followed(String userId) async {
    await Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
    );

    return followedUserIdList.any((element) => element == userId);
  }
}

class UserDetail {
  final String userId;
  final String hobby;
  final int followerCount;

  UserDetail({
    required this.userId,
    required this.hobby,
    required this.followerCount,
  });

  UserDetail incrementFollowerCount() {
    return UserDetail(
      userId: userId,
      hobby: hobby,
      followerCount: followerCount + 1,
    );
  }

  UserDetail decrementFollowerCount() {
    return UserDetail(
      userId: userId,
      hobby: hobby,
      followerCount: max(followerCount - 1, 0),
    );
  }
}
