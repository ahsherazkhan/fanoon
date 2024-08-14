import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:funoon/core/error/expections.dart';

import '../../../../../core/network_manger.dart';
import '../../../../feed/domain/entities/post.dart';

class ProfileService {
  var dio = NetworkManager.instance();
  final secureStorage = const FlutterSecureStorage();

  Future<Post> createPost({
    required String title,
    required String description,
    required int price,
    required List<String> images,
    required List<String> tags,
  }) async {
    // get token from the storage
    String? token = await secureStorage.read(key: 'token');
    //For simple data
    FormData formData = FormData.fromMap({
      'title': title,
      'price': price,
      'description': description,
      'tags': tags
    });

    // an loop that itterates over the list of images and then converts them to a file.
    for (var img in images) {
      String fileName = img.split('/').last;
      formData.files.addAll([
        MapEntry(
            "images",
            await MultipartFile.fromFile(
              img,
              filename: fileName,
              contentType: MediaType('image', 'jpg'),
            )),
      ]);
    }

    Response response = await dio.post('/posts/createPost',
        data: formData,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ));

    if (response.statusCode == 201) {
      return Post.empty;
    } else {
      throw ServerException();
    }
  }
}


// {
//    "status":"success",
//    "data":{
//       "data":{
//          "title":"Bags for Ladiies that are handmade",
//          "description":"This bag is really affordable.",
//          "likes":0,
//          "likesIDs":[
            
//          ],
//          "shares":0,
//          "sharesIDs":[
            
//          ],
//          "isSold":false,
//          "images":[
//             post-1668959011062.jpg
//          ],
//          "imagesUrls":[
            
//          ],
//          "price":150,
//          "tags":[
//             "Crafts"
//          ],
//          "createdBy":637a29e1180e1c1ed7b944f0,
//          "_id":637a4b235f602eba6f80afe4,
//          "comments":[
            
//          ],
//          "dateCreated":"2022-11-20T15":"43":31.229Z,
//          "__v":0
//       }
//    }
// }



// ------------api/v1/users/myProfile
// {
//     "status": "success",
//     "User": {
//         "_id": "638260c3f08b08732e77af4c",
//         "name": "somegood",
//         "email": "somegood@gmail.com",
//         "interests": [],
//         "role": "user",
//         "isVerified": false,
//         "isInterested": false,
//         "__v": 0
//     },
//     "Posts": []
// }