abstract class GroupsMembersRepo {
  Future fetchMembersNotInAny({required String stage, required String gameId});
  Future addMembersToGroup({required List memberIds, required String groupId});
}
