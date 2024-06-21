import 'dart:convert';

import 'package:SNP/core/error/server_exception.dart';
import 'package:SNP/core/utils/custom_snackbar.dart';
import 'package:SNP/core/utils/loading_manager.dart';
import 'package:SNP/network/api_urls.dart';
import 'package:SNP/network/http_wrapper.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get_connect/http/src/request/request.dart';
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
