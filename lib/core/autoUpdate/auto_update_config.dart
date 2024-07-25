import 'package:app_version_update/app_version_update.dart';

final appleId =
    '6529530790'; // If this value is null, its packagename will be considered
final playStoreId =
    'com.alibtisam.club'; // If this value is null, its packagename will be considered

checkForUpdate(context) async {
  await AppVersionUpdate.checkForUpdates(
          appleId: appleId, playStoreId: playStoreId)
      .then((data) async {
    print(data.storeUrl);
    print(data.storeVersion);
    if (data.canUpdate!) {
      //showDialog(... your custom widgets view)
      //or use our widgets
      // AppVersionUpdate.showAlertUpdate
      // AppVersionUpdate.showBottomSheetUpdate
      // AppVersionUpdate.showPageUpdate
      AppVersionUpdate.showAlertUpdate(
          appVersionResult: data, context: context);
    }
  });
}
