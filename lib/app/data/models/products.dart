// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Products productFromJson(String str) => Products.fromJson(json.decode(str));

String productToJson(Products data) => json.encode(data.toJson());

class Products {
  int? id;
  String? slug;
  String? url;
  String? title;
  String? content;
  String? image;
  String? thumbnail;
  String? status;
  String? category;
  String? publishedAt;
  String? updatedAt;
  int? userId;
  int? count;

  Products(
      {this.id,
      this.slug,
      this.url,
      this.title,
      this.content,
      this.image,
      this.thumbnail,
      this.status,
      this.category,
      this.publishedAt,
      this.updatedAt,
      this.userId,
      this.count});

  factory Products.fromJson(Map<String, dynamic> json) => Products(
      id: json["id"],
      slug: json["slug"],
      url: json["url"],
      title: json["title"],
      content: json["content"],
      image: json["image"],
      thumbnail: json["thumbnail"],
      status: json["status"],
      category: json["category"],
      publishedAt: json["publishedAt"],
      updatedAt: json["updatedAt"],
      userId: json["userId"],
      count: json['count'] ?? 1);

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "url": url,
        "title": title,
        "content": content,
        "image": image,
        "thumbnail": thumbnail,
        "status": status,
        "category": category,
        "publishedAt": publishedAt,
        "updatedAt": updatedAt,
        "userId": userId,
        "count": count
      };
}
