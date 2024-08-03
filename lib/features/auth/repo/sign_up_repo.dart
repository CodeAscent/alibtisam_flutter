import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';

class SignUpRepo {
  checkUserExist({required String mobile, required String email}) async {
    try {
      final res = await HttpWrapper.postRequest(
          base_url + 'user/check', {'email': email, 'mobile': mobile});
      return res;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
