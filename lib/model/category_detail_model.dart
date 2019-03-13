class PackPackageDetailModel {
  final String validitywithunit;
  final String image;
  final String color;
  final String tnc;
  final String showvalidity;
  final String allowpurchase;
  final String avatar;
  final String title;
  final String name;
  final String category;
  final String desc;

  PackPackageDetailModel ({
    this.validitywithunit,
    this.image,
    this.color,
    this.tnc,
    this.showvalidity,
    this.allowpurchase,
    this.avatar,
    this.title,
    this.name,
    this.category,
    this.desc,
  });

  factory PackPackageDetailModel.fromJson(Map<String, dynamic> json) {
    return PackPackageDetailModel(
      validitywithunit: json['validitywithunit'],
      image: json['image'],
      color: json['color'],
      tnc: json['tnc'],
      showvalidity: json['showvalidity'],
      allowpurchase: json['allowpurchase'],
      avatar: json['avatar'],
      title: json['title'],
      name: json['name'],
      category: json['category'],
      desc: json['desc'],
    );
  }
}

class PackDetailModel {
  final String result;
  final int code;
  final String packtnc;
  final String cpbal;

  final List<PackPackageDetailModel> packagesList;

  PackDetailModel ({this.result, this.code, this.packagesList, this.packtnc, this.cpbal});

  factory PackDetailModel.fromJson(Map<String, dynamic> json) {
    var list = json['packages'] as List;
    List<PackPackageDetailModel> packagesListCast = list.map((i) => PackPackageDetailModel.fromJson(i)).toList();

    return PackDetailModel(
      result: json['result'],
      code: json['code'],
      packtnc: json['packtnc'],
      cpbal: json['cpbal'],
      packagesList: packagesListCast,
    );
  }
}