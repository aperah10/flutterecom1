class ApiError {
  String? _error;

  ApiError({String? error}) {
    this._error = error;
  }
  String get error => _error!;
  set error(String error) => _error = error;

  ApiError.fromJson(Map<String, dynamic> json) {
    _error = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._error;
    return data;
  }
}

// ! API RESPONSE
class ApiResponse {
  // _data will hold any response converted into
  // its own object. For example user.
  Object? _data;
  // _apiError will hold the error object
  Object? _apiError;

  Object get Data => _data!;
  set Data(Object data) => _data = data;

  Object get ApiError => _apiError as Object;
  set ApiError(Object error) => _apiError = error;
}
