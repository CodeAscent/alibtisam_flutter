import 'package:alibtisam/features/bottomNav/model/group_model.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class GroupsController extends GetxController {
  List<GroupModel>? groups = [];
  String selectedGroupId = '';
  late GroupModel selectedGroup;
  bool isLoading = false;
  Future fetchGroups({required String stage, required String gameId}) async {
    isLoading = true;
    groups = await ApiRequests().getGroups(stage: stage, gameId: gameId);
    isLoading = false;
    update();
  }

  Future fetchGroupsForPlayer() async {
    isLoading = true;
    groups = await ApiRequests().playerGroups();
    isLoading = false;
    update();
  }

  updateSelectedGroup(GroupModel group) {
    selectedGroup = group;
    update();
  }

  Future createGroup(
      {required String stage,
      required String gameId,
      required String name}) async {
    await ApiRequests().createGroup(stage: stage, gameId: gameId, name: name);
    await fetchGroups(stage: stage, gameId: gameId);
    isLoading = false;
    update();
  }

  Future addMemberToGroup({
    required String memberId,
    required String groupId,
  }) async {
    await ApiRequests().addMemberToGroup(memberId: memberId, groupId: groupId);
    isLoading = false;
    update();
  }

  Future<List<UserModel>?> fetchGroupMembers() async {
    isLoading = true;
    List<UserModel>? users = [];
    users = await ApiRequests().getPlayersByGroup(groupId: selectedGroupId);
    isLoading = false;
    update();
    return users;
  }
}
