import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/features/groupsManagement/data/repository/groups_members_repo_impl.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class GroupMembersViewModel extends GetxController {
  final GroupsMembersRepoImplementation groupsMembersRepoImplementation;

  GroupMembersViewModel(this.groupsMembersRepoImplementation);

  List<UserModel> users = [];
  RxBool loading = false.obs;
  fetchNonGroupMembers({required String stage, required String gameId}) async {
    try {
      loading.value = true;
      final res = await groupsMembersRepoImplementation.fetchMembersNotInAny(
        stage: stage,
        gameId: gameId,
      );
      Logger().w(res);
      users = (res['users'] as List)
          .map((e) => UserModel.fromMap(e as Map<String, dynamic>))
          .toList();

      update();
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      loading.value = false;
    }
  }

  addMembersToGroup({required String groupId, required List memberIds}) async {
    try {
      loading.value = true;
      final res = await groupsMembersRepoImplementation.addMembersToGroup(
        groupId: groupId,
        memberIds: memberIds,
      );
      customSnackbar(res['message'].toString(), ContentType.success);
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      loading.value = false;
    }
  }
}
