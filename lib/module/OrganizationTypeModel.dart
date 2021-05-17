class OrganizationTypeModel {
  int ID;
  String Name;

  OrganizationTypeModel({this.ID, this.Name});

  OrganizationTypeModel.fromMap(Map<String, dynamic> map)
      : ID = map['ID'],
        Name = map['Name'];
}
