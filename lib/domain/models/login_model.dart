class LoginModel {
  late bool status;
  late String message;
  UserData? data;

  LoginModel(this.status, this.message, this.data);

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['data'] ? data!.toJson : null;
    return map;
  }
}

class UserData {
  late num _id;
  late String _name;
  late String _email;
  late String _phone;
  String? _image;
  late num _points;
  late num _credit;
  late String _token;

  UserData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _image = json['image'] ?? '';
    _points = json['points'];
    _credit = json['credit'];
    _token = json['token'];
  }

  num get id => _id;
  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get image => _image ?? '';
  num get points => _points;
  num get credit => _credit;
  String get token => _token;

  Map<String, dynamic> get toJson => {
        'id': _id,
        'name': _name,
        'email': _email,
        'phone': _phone,
        'image': _image,
        'points': _points,
        'credit': _credit,
        'token': _token,
      };
}
