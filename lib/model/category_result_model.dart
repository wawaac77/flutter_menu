class CategoryItemModel {
  final String img;
  final String priceImg;
  final String color;
  final String display;
  final String name;
  final String catId;
  final String avatar;
  final String desc;

  CategoryItemModel ({this.img, this.priceImg, this.color, this.display, this.name, this.catId, this.avatar, this.desc});

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) {
    return CategoryItemModel(
      img: json['img'],
      priceImg: json['priceimg'],
      color: json['color'],
      display: json['display'],
      name: json['name'],
      catId: json['id'],
      avatar: json['avatar'],
      desc: json['desc'],
    );
  }
}

class ResultModel {
  final String result;
  final int code;
  final List<CategoryItemModel> categoryList;

  ResultModel ({this.result, this.code, this.categoryList});

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    var list = json['category'] as List;
    List<CategoryItemModel> categoryListCast = list.map((i) => CategoryItemModel.fromJson(i)).toList();

    return ResultModel(
      result: json['result'],
      code: json['code'],
      categoryList: categoryListCast,
    );
  }
}