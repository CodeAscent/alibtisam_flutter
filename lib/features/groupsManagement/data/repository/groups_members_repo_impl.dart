import 'dart:convert';

import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/features/groupsManagement/domain/repository/groups_members_repo.dart';
import 'package:logger/logger.dart';

class GroupsMembersRepoImplementation implements GroupsMembersRepo {
  @override
  Future fetchMembersNotInAny(
      {required String stage, required String gameId}) async {
    try {
      final res = await HttpWrapper.postRequest(
        base_url + 'group/members/players-not-in-any-group',
        {
          "stage": stage,
          "gameId": gameId,
        },
      );
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future addMembersToGroup(
      {required List memberIds, required String groupId}) async {
    try {
      final res = await HttpWrapper.postRequest(
        base_url + 'group/members/add-multiple-group-members',
        {
          "memberIds": memberIds,
          "groupId": groupId,
        },
      );
      print('-------------->${res.body}');
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
