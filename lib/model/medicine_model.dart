class MedicineModel {
  int? id;
  String? name;
  String? manufacturer;
  String? composition;
  List<dynamic>? usage;
  List<dynamic>? sideEffects;
  String? qrLink;

  MedicineModel({
    this.id,
    this.name,
    this.manufacturer,
    this.composition,
    this.usage,
    this.sideEffects,
    this.qrLink,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      manufacturer: json['manufacturer'] as String?,
      composition: json['composition'] as String?,
      usage: json['usage'] as List<dynamic>?,
      sideEffects: json['side_effects'] as List<dynamic>?,
      qrLink: json['qr_link'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'manufacturer': manufacturer,
        'composition': composition,
        'usage': usage,
        'side_effects': sideEffects,
        'qr_link': qrLink,
      };
}
