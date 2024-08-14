import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    super.id = '',
    super.name = '',
    super.email = '',
    super.role = '',
    super.active = true,
    super.isVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = UserModel(
      id: json['data']['user']['_id'],
      name: json['data']['user']['name'],
      email: json['data']['user']['email'],
      role: json['data']['user']['role'],
      active: json['data']['user']['active'] ?? true,
      isVerified: json['data']['user']['isVerified'],
    );
    return user;
  }

  factory UserModel.fromJsonPost(Map<String, dynamic> json) {
    final user = UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      isVerified: json['isVerified'],
    );
    return user;
  }

  Map<String, dynamic> toJson() {
    var body = {
      'user': {
        'name': name,
        'email': email,
        'role': role,
        'active': active,
        'isVerified': isVerified,
        '_id': id,
      }
    };

    return body;
  }
}

// ```json
// {
//     "status": "success",
//     "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzM2YwMzg0YjRhYzRhM2I4ZTQ5NzlkMCIsImlhdCI6MTY2NTA3NDA1MywiZXhwIjoxNjY1MDc0MDUzfQ.jgm-zPpOlqS2Fl17QZESZlnfAks1P18JLQm1BfY_N5Y",
//     "data": {
//         "user": {
//             "name": "waseek Ahmed123",
//             "email": "waseeqe693ahmed@gmail.com",
//             "role": "user",
//             "active": true,
//             "isVerified": false,
//             "_id": "633f0384b4ac4a3b8e4979d0",
//             "__v": 0
//         }
//     }
// }
// ````

// {
//    "status":"success",
//    "token":eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzODI1ODUyNGM2NDc5ZWU0ZmI4ZmZjMyIsImlhdCI6MTY2OTQ4Njg3MCwiZXhwIjoxNjc3MjYyODcwfQ.qxF7NdlTS-F_GiBrpSziPIgO6AJxW0qty0TDMLKSP3c,
//    "data":{
//       "user":{
//          "_id":638258524c6479ee4fb8ffc3,
//          "name":waseeqahmed69,
//          "email":waseeqhaider1236@gmail.com,
//          "interests":[
            
//          ],
//          "role":"user",
//          "isVerified":false,
//          "isInterested":false,
//          "__v":0
//       }
//    }
// }