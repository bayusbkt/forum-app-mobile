// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
    int id;
    String userId;
    int feedId;
    String body;
    DateTime createdAt;
    DateTime updatedAt;
    User user;
    Feed feed;

    CommentModel({
        required this.id,
        required this.userId,
        required this.feedId,
        required this.body,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
        required this.feed,
    });

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"],
        userId: json["user_id"],
        feedId: json["feed_id"],
        body: json["body"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
        feed: Feed.fromJson(json["feed"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "feed_id": feedId,
        "body": body,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
        "feed": feed.toJson(),
    };
}

class Feed {
    int id;
    String userId;
    String content;
    DateTime createdAt;
    DateTime updatedAt;
    bool liked;

    Feed({
        required this.id,
        required this.userId,
        required this.content,
        required this.createdAt,
        required this.updatedAt,
        required this.liked,
    });

    factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json["id"],
        userId: json["user_id"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        liked: json["liked"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "liked": liked,
    };
}

class User {
    String id;
    String name;
    String username;
    String email;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;

    User({
        required this.id,
        required this.name,
        required this.username,
        required this.email,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
