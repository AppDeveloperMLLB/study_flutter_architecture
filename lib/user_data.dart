import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_data.freezed.dart';

@freezed
class UserData with _$UserData {
  const factory UserData(
    String id,
    String name,
    int age,
  ) = _UserData;
}
