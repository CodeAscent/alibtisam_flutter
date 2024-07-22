import 'package:alibtisam/features/bottomNav/model/group_model.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:get/get.dart';

class GroupsController extends GetxController {
  List<GroupModel>? groups = [];
  String selectedGroupId = '';
  bool isLoading = false;
  Future fetchGroups({required String stage, required String gameId}) async {
    isLoading = true;
    groups = await ApiRequests().getGroups(stage: stage, gameId: gameId);
    isLoading = false;
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
    List<UserModel>? users = [];
    users = await ApiRequests().getPlayersByGroup(groupId: selectedGroupId);
    return users;
  }
}
