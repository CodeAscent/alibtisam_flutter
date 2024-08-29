import 'dart:convert';

import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/bottomNav/model/age_category.dart';
import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
      customSnackbar(e.message, ContentType.failure);
    }
    return Left(ServerException());
  }
}
