class UOM {
  String description;
  String iDPcode;
  int id;
  String idpcode;
  String unit;

  static UOM fromJSON(json) {
    UOM p = new UOM();
    p.unit = json['unit'];
    p.idpcode = json['idpcode'];
    p.iDPcode = json['iDPcode'];
    p.id = json['id'];
    p.description = json['description'];
    return p;
  }

}

