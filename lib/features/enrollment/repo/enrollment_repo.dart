import 'dart:convert';

import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:logger/web.dart';

class EnrollmentRepo {
  Future submitEnrollmentForm({
    required String name,
    required String fatherName,
    required String motherName,
    required String gender,
    required String dateOfBirth,
    required String bloodGroup,
    required String height,
    required String weight,
    required String phoneNumber,
    required String email,
    required String address,
    required String correspondenceAddress,
    required String city,
    required String state,
    required String relationWithApplicant,
    required XFile? idProofFrontPath,
    required XFile? idProofBackPath,
    required XFile? pic,
    required XFile? certificate,
    required String batch,
    required String gameId,
    required String stage,
    required String relationWithPlayer,
    required String playerGovId,
    required String guardianGovId,
    required String guardianGovIdExpiry,
    required String playerGovIdExpiry,
  }) async {
    try {
      String url = create_player;
      Map<String, String>? fields = {
        "name": name,
        "fatherName": fatherName,
        "motherName": motherName,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "bloodGroup": bloodGroup,
        "height": height,
        "weight": weight,
        "mobile": phoneNumber,
        "email": email,
        "address": address,
        "correspondenceAddress": correspondenceAddress,
        "city": city,
        "state": state,
        "relation": relationWithApplicant,
        "batch": batch,
        "gameId": gameId,
        "stage": stage,
        "playerGovId": playerGovId,
        "relationWithPlayer": relationWithPlayer,
        "guardianGovId": guardianGovId,
        "guardianGovIdExpiry": guardianGovIdExpiry,
        "playerGovIdExpiry": playerGovIdExpiry
      };
      List<http.MultipartFile> files = [];
      files.addAll([
        await http.MultipartFile.fromPath("pic", pic!.path),
        await http.MultipartFile.fromPath(
            "idFrontImage", idProofFrontPath!.path),
        await http.MultipartFile.fromPath("idBackImage", idProofBackPath!.path),
      ]);
      if (certificate != null) {
        files.add(await http.MultipartFile.fromPath(
            "certificateLink", certificate.path));
      }
      final res =
          await HttpWrapper.multipartRequest(url, files, fields: fields);
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  Future changeGameAndStage({
    required String id,
    required String gameId,
    required String stage,
  }) async {
    try {
      final res = await HttpWrapper.postRequest(
          base_url + 'user/update-user-game/$id', {
        "gameId": gameId,
        "stage": stage,
      });
      Logger().f(res.body);
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
