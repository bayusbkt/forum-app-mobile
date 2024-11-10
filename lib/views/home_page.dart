import 'package:flutter/material.dart';
import 'package:forum_app/controllers/post_controller.dart';
import 'package:forum_app/views/widgets/post_data_widget.dart';
import 'package:forum_app/views/widgets/post_field_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final PostController _postController = Get.put(PostController());
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "Forumin",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostField(
                hintText: "What do you want to ask?",
                controller: _textController,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                    ),
                    onPressed: () async {
                      await _postController.createPost(
                          content: _textController.text.trim());
                      _textController.clear();
                      _postController.getAllPosts();
                    },
                    child: Obx(() {
                      return _postController.isLoading.value
                          ? const SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3.0,
                              ),
                            )
                          : const Text(
                              'Post',
                              style: TextStyle(color: Colors.white),
                            );
                    }),
                  )),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Posts',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Obx(() {
                return _postController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _postController.posts.value.length,
                        itemBuilder: (context, index) {
                          return PostData(
                              post: _postController.posts.value[index]);
                        },
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
