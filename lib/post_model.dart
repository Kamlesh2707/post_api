// class LoginModel {
//   String? _message;
//   String? _status;
//
//   LoginModel({String? message, String? status}) {
//     if (message != null) {
//       this._message = message;
//     }
//     if (status != null) {
//       this._status = status;
//     }
//   }
//
//   String? get message => _message;
//   set message(String? message) => _message = message;
//   String? get status => _status;
//   set status(String? status) => _status = status;
//
//   LoginModel.fromJson(Map<String, dynamic> json) {
//     _message = json['message'];
//     _status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this._message;
//     data['status'] = this._status;
//     return data;
//   }
// }
//

class LoginModel {
  String? message;
  String? status;

  LoginModel({this.message, this.status});

  // Factory constructor to create an instance of LoginModel from JSON
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json['message'],
      status: json['status'],
    );
  }

  // Method to convert LoginModel instance to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
    };
  }
}

