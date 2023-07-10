class Shop {
  var id;
  var imageURL;
  var name;
  var Id_stateType;

  Shop({
    required this.id,
    required this.imageURL,
    required this.name,
    this.Id_stateType,
  });
  factory Shop.fromJson(var json) {
    return Shop(
      id: json['Id'],
      imageURL: json['ImageURL'],
      name: json['Name'],
      Id_stateType: json['Id_statetype'],
    );
  }
}
