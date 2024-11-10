import 'package:flutter/material.dart';
import 'package:forum_app/controllers/post_controller.dart';
import 'package:forum_app/models/post_model.dart';
import 'package:forum_app/views/widgets/input_widget.dart';
import 'package:forum_app/views/widgets/post_data_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key, required this.post});

  final PostModel post;

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _postController.getComments(widget.post.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            widget.post.user.name,
            style: const TextStyle(color: Colors.white),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            children: [
              PostData(post: widget.post),
              SizedBox(
                width: double.infinity,
                height: 500,
                child: Obx(() {
                  return _postController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: _postController.comments.value.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return _postController.comments.value.isEmpty
                                ? const Center(
                                    child: Text('There is no comment'),
                                  )
                                : ListTile(
                                    title: Text(
                                      _postController
                                          .comments.value[index].user.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(_postController
                                        .comments.value[index].body),
                                  );
                          },
                        );
                }),
              ),
              InputWidget(
                  hintText: "Write a comment",
                  controller: _commentController,
                  obsecureText: false),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Obx(() {
                  return _postController.isLoading.value
                      ? const LinearProgressIndicator(
                          color: Colors.black,
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10)),
                          onPressed: () async {
                            await _postController.createComment(
                                widget.post.id, _commentController.text.trim());
                            _commentController.clear();
                            _postController.getComments(widget.post.id);
                          },
                          child: Text(
                            "Submit",
                            style: GoogleFonts.poppins(color: Colors.white),
                          ));
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
