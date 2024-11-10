import 'package:flutter/material.dart';
import 'package:forum_app/controllers/post_controller.dart';
import 'package:forum_app/models/post_model.dart';
import 'package:forum_app/views/post_detail_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostData extends StatefulWidget {
  const PostData({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  final PostController _postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post.user.name,
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          Text(widget.post.user.email,
              style: GoogleFonts.poppins(fontSize: 10)),
          const SizedBox(
            height: 20,
          ),
          Text(widget.post.content),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    await _postController.likeAndDislike(widget.post.id);
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.thumb_up,
                    size: 20,
                    color: widget.post.liked ? Colors.blue : Colors.black,
                  )),
              IconButton(
                  onPressed: () {
                    Get.to(() => PostDetail(
                          post: widget.post,
                        ));
                  },
                  icon: const Icon(
                    Icons.message,
                    size: 20,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
