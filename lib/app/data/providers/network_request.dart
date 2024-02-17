import 'package:dio/dio.dart';
import 'package:tr_store/app/data/values/app_string.dart';

class NetworkRequest {
  final String url;

  final dynamic data;

  NetworkRequest({
    required this.url,
    this.data,
  });

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: AppString.baseUrl,
      headers: {},
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (err, handler) {
          return handler.next(err);
        },
      ),
    );

  Future<Response>? get({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) {
    beforeSend();

    dio
        .get(
      url,
      queryParameters: data,
    )
        .then((res) {
      if (onSuccess != null) onSuccess(res.data);
      return res;
    }).catchError((error, s) {
      if (onError != null) onError(error);
    });
  }

  Future<Response>? post({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) {
    beforeSend == null ? null : beforeSend();

    dio
        .post(
      url,
      data: data,
    )
        .then((res) {
      if (res.statusCode == 400) {
        onError(res.data);
      } else if (onSuccess != null) {
        onSuccess(res.data);
        return res;
      }
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  Future<Response>? delete({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) {
    beforeSend == null ? null : beforeSend();

    dio.delete(url, data: data).then((res) {
      if (res.statusCode == 400) {
        onError(res.data);
      } else if (onSuccess != null) {
        onSuccess(res.data);
        return res;
      }
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  Future<Response>? patch({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) {
    beforeSend == null ? null : beforeSend();

    dio.patch(url, data: data).then((res) {
      if (res.statusCode == 202) {
        onError(res.data);
      } else if (onSuccess != null) {
        onSuccess(res.data);
        return res;
      }
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  Future<Response>? put({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) {
    beforeSend == null ? null : beforeSend();

    dio.put(url, data: data).then((res) {
      if (res.statusCode == 202) {
        onError(res.data);
      } else if (onSuccess != null) {
        onSuccess(res.data);
        return res;
      }
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }
}

resetDIO() {
  NetworkRequest.dio = Dio(
    BaseOptions(baseUrl: AppString.baseUrl, headers: {}),
  );
}
