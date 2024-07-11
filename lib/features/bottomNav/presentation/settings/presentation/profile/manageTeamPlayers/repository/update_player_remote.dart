import 'dart:convert';

import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/core/utils/loading_manager.dart';
import 'package:alibtisam/network/api_urls.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/web.dart';
import 'package:http/http.dart' as http;

class UpdatePlayerRemote {
  Future<Either<ServerException, String>> updateUserById(
      {required String uid, required Map<String, String> body}) async {
    try {
      final res =
          http.MultipartRequest('POST', Uri.parse(update_user_by_id + uid));
      // Add fields
      body.forEach((key, value) {
        res.fields[key] = value;
      });
      final data = await res.send();
      final response = await data.stream.bytesToString();
      Logger().w(body);

      if (data.statusCode == 200) {
        return Right(jsonDecode(response)['message']);
      } else {
        return Left(ServerException(jsonDecode(response)['message']));
      }
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return Left(ServerException());
  }
}
