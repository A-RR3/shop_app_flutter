/// id : 15
/// username : "kminchelle"
/// email : "kminchelle@qq.com"
/// firstName : "Jeanne"
/// lastName : "Halvorson"
/// gender : "female"
/// image : "https://robohash.org/Jeanne.png?set=set4"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoia21pbmNoZWxsZSIsImVtYWlsIjoia21pbmNoZWxsZUBxcS5jb20iLCJmaXJzdE5hbWUiOiJKZWFubmUiLCJsYXN0TmFtZSI6IkhhbHZvcnNvbiIsImdlbmRlciI6ImZlbWFsZSIsImltYWdlIjoiaHR0cHM6Ly9yb2JvaGFzaC5vcmcvSmVhbm5lLnBuZz9zZXQ9c2V0NCIsImlhdCI6MTcxNTk0NTI4NSwiZXhwIjoxNzE1OTQ4ODg1fQ.bBtqVx5jUO7SaBOdMK7N99aiHzh-_g4Ny_wsaxmwBMo"
library;

class UserModel {
  num _id;
  String _username;
  String _email;
  String _firstName;
  String _lastName;
  String _gender;
  String _image;
  String _token;

  UserModel(this._id, this._username, this._email, this._firstName,
      this._lastName, this._gender, this._image, this._token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['id'],
      json['username'],
      json['email'],
      json['firstName'],
      json['lastName'],
      json['gender'],
      json['image'] ?? '',
      json['token'] ?? '',
    );
  }

  num get id => _id;
  String get username => _username;
  String get email => _email;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get gender => _gender;
  String get image => _image;
  String get token => _token;

  Map<String, dynamic> toJson() => {
        'id': _id,
        'username': _username,
        'email': _email,
        'firstName': _firstName,
        'lastName': _lastName,
        'gender': _gender,
        'image': _image,
        'token': _token,
      };
}
