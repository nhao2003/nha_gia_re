class Province {
  String? name;
  int? code;
  String? codename;
  String? divisionType;
  int? phoneCode;
  List<District?>? districts;

  Province(
      { this.name,
        this.code,
        this.codename,
        this.divisionType,
        this.phoneCode,
        this.districts});

  Province.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    codename = json['codename'];
    divisionType = json['division_type'];
    phoneCode = json['phone_code'];
    if (json['districts'] != null) {
      districts = <District>[];
      json['districts'].forEach((v) {
        districts?.add(District.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['codename'] = this.codename;
    data['division_type'] = this.divisionType;
    data['phone_code'] = this.phoneCode;
    final districts = this.districts;
    if (districts != null) {
      data['districts'] = districts.map((v) => v?.toJson()).toList();
    }
    return data;
  }
}

class District {
  String? name;
  int? code;
  String? codename;
  String? divisionType;
  String? shortCodename;
  List<Ward?>? wards;

  District(
      {this.name,
        this.code,
        this.codename,
        this.divisionType,
        this.shortCodename,
        this.wards});

  District.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    codename = json['codename'];
    divisionType = json['division_type'];
    shortCodename = json['short_codename'];
    if (json['wards'] != null) {
      wards = <Ward>[];
      json['wards'].forEach((v) {
        wards?.add(Ward.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['codename'] = codename;
    data['division_type'] = divisionType;
    data['short_codename'] = shortCodename;
    final wards = this.wards;
    if (wards != null) {
      data['wards'] = wards.map((v) => v?.toJson()).toList();
    }
    return data;
  }
}

class Ward {
  String? name;
  int? code;
  String? codename;
  String? divisionType;
  String? shortCodename;

  Ward(
      {this.name,
        this.code,
        this.codename,
        this.divisionType,
        this.shortCodename});

  Ward.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    codename = json['codename'];
    divisionType = json['division_type'];
    shortCodename = json['short_codename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['codename'] = codename;
    data['division_type'] = divisionType;
    data['short_codename'] = shortCodename;
    return data;
  }
}