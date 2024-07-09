import 'dart:convert';

import 'package:SNP/core/error/server_exception.dart';
import 'package:SNP/core/utils/custom_snackbar.dart';
import 'package:SNP/core/utils/loading_manager.dart';
import 'package:SNP/features/bottomNav/model/age_category.dart';
import 'package:SNP/network/api_urls.dart';
import 'package:SNP/network/http_wrapper.dart';
import 'package:fpdart/fpdart.dart';

class AgeCategoryRepo {
  Future<Either<ServerException, List<AgeCategoryModel>>>
      getAgeCategory() async {
    try {
      final res = await HttpWrapper.getRequest(age_category);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        List<AgeCategoryModel> ageCategories = [];

        for (var ages in data['categories']) {
          ageCategories.add(AgeCategoryModel.fromMap(ages));
        }
        return Right(ageCategories);
      } else {
        return Left(ServerException(data['message']));
      }
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return Left(ServerException());
  }
}
