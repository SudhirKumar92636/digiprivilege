import 'dart:convert';

HomeDataModel homeDataModelFromJson(String str) =>
    HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
  String? group_id;
  String? group_name;
  String? type;
  String? hero_image_url;
  String? id;
  List<Item>? items;

  HomeDataModel(
      {this.group_id,
      this.group_name,
      this.type,
      this.hero_image_url,
      this.items,
      this.id});

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        group_id: json["group_id"].toString(),
        group_name: json["group_name"],
        type: json["type"],
        id: json["id"],
        hero_image_url: json["hero_image_url"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "group_id": group_id,
        "group_name": group_name,
        "type": type,
        "url": hero_image_url,
        "id": id,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({this.desc, this.title, this.id, this.hero_image_url, this.web_url});

  String? desc;
  String? title;
  String? hero_image_url;
  String? web_url;
  String? id;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      desc: json["desc"],
      title: json["title"],
      web_url: json["web_url"],
      hero_image_url: json["hero_image_url"],
      id: json["id"]);

  Map<String, dynamic> toJson() => {
        "desc": desc,
        "title": title,
        "url": hero_image_url,
        "id": id,
        "web_url": web_url
      };
}