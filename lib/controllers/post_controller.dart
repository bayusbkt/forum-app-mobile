import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forum_app/constants/constant.dart';
import 'package:forum_app/models/comment_model.dart';
import 'package:forum_app/models/post_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PostController extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  Rx<List<CommentModel>> comments = Rx<List<CommentModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  Future getAllPosts() async {
    try {
      posts.value.clear();
      isLoading.value = true;
      var response = await http.get(
        Uri.parse('$url/feed'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        for (var item in jsonDecode(response.body)['data']) {
          posts.value.add(PostModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(jsonDecode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createPost({
    required String content,
  }) async {
    try {
      var data = {
        'content': content,
      };

      var response = await http.post(
        Uri.parse('$url/feed'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        print(json.decode(response.body));
      } else {
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getComments(id) async {
    try {
      comments.value.clear();
      isLoading.value = true;

      var response = await http.get(
        Uri.parse('$url/feed/comment/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        final content = json.decode(response.body)['data'];
        for (var item in content) {
          comments.value.add(CommentModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future createComment(id, body) async {
    try {
      isLoading.value = true;
      var data = {
        'body': body,
      };

      var request = await http.post(
        Uri.parse('$url/feed/comment/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      if (request.statusCode == 201) {
        isLoading.value = false;
        print(json.decode(request.body));
      } else {
        isLoading.value = false;
        print(json.decode(request.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

 Future<void> likeAndDislike(int id) async {
  try {
    isLoading.value = true;

    // Mengirim request ke endpoint like/unlike
    var response = await http.post(
      Uri.parse('${url}/feed/like/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );

    // Memeriksa apakah respons berhasil
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      String message = responseBody['message'];

      if (message == 'Liked') {
        var post = posts.value.firstWhere((p) => p.id == id);
        post.liked = true;
      } else if (message == 'Unliked') {       
        var post = posts.value.firstWhere((p) => p.id == id);
        post.liked = false;
      }
      posts.refresh();
    } else {
      print("Error: ${json.decode(response.body)['message']}");
    }
  } catch (e) {
    print("Exception: $e");
  } finally {
    isLoading.value = false; 
  }
}

}
