import 'package:dio/dio.dart';
import 'package:new_project/models/usermodel.dart';

class GetUserService {
  static Future<dynamic> getUserService() async {
    try {
      Response response =
          await Dio().get("https://jsonplaceholder.typicode.com/users");

      if (response.statusCode == 200) {
        List<UserModel> userData =
            (response.data as List).map((e) => UserModel.fromJson(e)).toList();
        return userData;
      } else {
        return response.statusMessage;
      }
    } on DioError catch (e) {
      return e.message.toString();
    }
  }
}
