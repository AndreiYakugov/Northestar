import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:northstar_app/Models/prosignup.dart';
import 'package:northstar_app/Models/signin.dart';
import 'package:northstar_app/Models/signup.dart';
import '../utils/SharedPrefUtils.dart';
import '../utils/app_contstants.dart';
import '../utils/helper_methods.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<dynamic> signup(Signup signupData) async {
    try {
      var params = {
        "first_name": signupData.firstName,
        "last_name": signupData.lastName,
        "email": signupData.email,
        "phone": signupData.phoneNumber,
        "sponsor_id": signupData.enrollerID,
        "username": signupData.userName,
        "password": signupData.password,
        "country": "",
        "state": "",
        "type": "1"
      };
      Response response = await _dio.post(
        signup_url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(params),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> signin(SignIn signinData) async {
    try {
      var params = {
        "username": signinData.username,
        "password": signinData.password,
        "is_mobile": getPhoneModel(),
        "device_type": "android",
        "device_token": getDeviceToken(),
        "device_name": getDeviceName(),
        "device_uuid": getSerialNumber(),
        "device_model": getDeviceModel()
      };
      Response response = await _dio.post(
        signin_url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(params),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> forgot(String username) async {
    try {
      var params = {
        "username": username
      };
      Response response = await _dio.post(
        forgot_url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(params),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> banner(String token) async {
    try {
      Response response = await _dio.get(
        banner_url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        }),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> contactsteam(String token) async {
    try {
      Response response = await _dio.get(
        contactsteam_url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        }),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> prosignup(Prosignup signupData) async {
    try {
      var params = {
        "first_name": signupData.firstName,
        "last_name": signupData.lastName,
        "phone": signupData.phoneNumber,
        "email": signupData.email,
        "shipaddline1": signupData.sadrline1,
        "shipaddline2": signupData.sadrline2,
        "city": signupData.city,
        "state": signupData.state,
      };
      Response response = await _dio.post(
        prosignup_url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(params),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }
  Future<dynamic> earningsstats(String token) async {
    try {
      Response response = await _dio.get(
        earningsstats_url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        }),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> earningsgraph(String token) async {
    try {
      var cy = new DateTime.now().year;
      String current_year = "$cy|$cy";
      Map<String, String> params = {
        'year_range': current_year
      };
      Response response = await _dio.get(
        earningsgraph_url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        }),
        queryParameters: params
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> earningslist(String token) async {
    try {
      Map<String, String> params = {
        'per_page': '10000',
        'page': '1'
      };
      Response response = await _dio.get(
          earningslist_url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          }),
          queryParameters: params
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> history(String token) async {
    try {
      Map<String, String> params = {
        'page': '1',
        'per_page': '10000'
      };
      Response response = await _dio.get(
          history_url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          }),
          queryParameters: params
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> notification(String token) async {
    try {
      Map<String, String?> params = {
        'device_token': getDeviceToken(),
        'title': '',
        'per_page': '10000',
        'page': '1'
      };
      Response response = await _dio.get(
          notification_url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          }),
          queryParameters: params
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> resource(String token) async {
    try {
      Map<String, String> params = {
        'filter[type]': ''
      };
      Response response = await _dio.get(
          resource_url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          }),
          queryParameters: params
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> training(String token) async {
    try {
      Map<String, String> params = {
        'filter[type]': '6'
      };
      Response response = await _dio.get(
          training_url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          }),
          queryParameters: params
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> unilevellist(String token) async {
    try {
      var uu = await SharedPrefUtils.readPrefStr("uuid");
      Map<String, String> params = {
        'per_page': '10',
        'page': '1',
        'user_id': uu
      };
      Response response = await _dio.get(
          unilevellist_url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          }),
          queryParameters: params
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> unileveltree(String token) async {
    try {
      var uu = await SharedPrefUtils.readPrefStr("uuid");
      Map<String, String> params = {
        'user_id': uu,
        'nodes': '2'
      };
      Response response = await _dio.get(
          unileveltree_url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          }),
          queryParameters: params
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> uplineenrollee(String token) async {
    try {
      Response response = await _dio.get(
          uplineenrollee_url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          }),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> missionsList(String token, String typeId) async {
    try {
      Map<String, String> params = {
        'type': typeId
      };
      Response response = await _dio.get(
          missionslist_url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          }),
          queryParameters: params
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> missionsContent(String token, String missionsId, String typeId) async {
    try {
      Map<String, String> params = {
        'type': typeId
      };
      Response response = await _dio.get(
          "$missions_url/$missionsId",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          }),
          queryParameters: params
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> missionsComplete(String token, String missionsId, String str_completedAt, String str_cnt) async {
    try {
      var params = {
        "completed_at": str_completedAt,
        "completed_cnt": str_cnt
      };
      Response response = await _dio.post(
        "$missions_url/$missionsId/complete",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        }),
        data: jsonEncode(params),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> missionsInComplete(String token, String missionsId, String str_cnt) async {
    try {
      var params = {
        "completed_cnt": str_cnt
      };
      Response response = await _dio.post(
        "$missions_url/$missionsId/incomplete",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        }),
        data: jsonEncode(params),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> missionsCreate(String token, String str_content, String str_title, String str_type) async {
    try {
      var params = {
        "content": str_content,
        "title": str_title,
        "type": str_type
      };
      Response response = await _dio.post(
        missions_url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        }),
        data: jsonEncode(params),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> missionsEdit(String token, String missionsId, String str_content, String str_title) async {
    try {
      var params = {
        "content": str_content,
        "title": str_title,
      };
      Response response = await _dio.post(
        "$missions_url/$missionsId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        }),
        data: jsonEncode(params),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> missionsReset(String token, String missionsId) async {
    try {
      Response response = await _dio.post(
        "$missions_url/$missionsId/reset",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        }),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> missionsDelete(String token, String missionsId) async {
    try {
      Response response = await _dio.delete(
        "$missions_url/$missionsId/delete",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        }),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> reportsProfile(String token) async {
    try {
      Response response = await _dio.get(
        reportsprofile_url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        }),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> reportsHeader(String token) async {
    try {
      Response response = await _dio.get(
        reportsheader_url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        }),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> reportsFive(String token) async {
    try {
      Response response = await _dio.get(
        reportsfive_url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        }),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
  Future<dynamic> reportsHundred(String token) async {
    try {
      Response response = await _dio.get(
        reportshundred_url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        }),
      );
      final Map map = Map.from(response.data);
      return map;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}