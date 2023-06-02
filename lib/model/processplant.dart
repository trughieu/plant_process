class ProcessPlant {
  final String idPlant;
  final String loaiCay;
  final CachTrong cachTrong;
  final ChamSoc chamSoc;

  ProcessPlant({
    required this.idPlant,
    required this.cachTrong,
    required this.chamSoc,
    required this.loaiCay,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_plant': idPlant,
      'loaiCay': loaiCay,
      'cachTrong': cachTrong.toJson(),
      'chamSoc': chamSoc.toJson(),
    };
  }
}

class CachTrong {
  final String chonGiong;
  final GieoTrong gieoTrong;

  CachTrong({
    required this.chonGiong,
    required this.gieoTrong,
  });

  Map<String, dynamic> toJson() {
    return {
      'chonGiong': chonGiong,
      'gieoTrong': gieoTrong.toJson(),
    };
  }
}

class GieoTrong {
  final String thoiVu;
  final NgoaiCanh ngoaiCanh;

  GieoTrong({
    required this.thoiVu,
    required this.ngoaiCanh,
  });

  Map<String, dynamic> toJson() {
    return {
      'thoiVu': thoiVu,
      'ngoaiCanh': ngoaiCanh.toJson(),
    };
  }
}

class NgoaiCanh {
  final String nhietDo;
  final String anhSang;
  final String nuoc;
  final String doAm;
  final String chatLuongKK;
  final String moTaThem;

  NgoaiCanh({
    required this.nhietDo,
    required this.anhSang,
    required this.nuoc,
    required this.doAm,
    required this.chatLuongKK,
    required this.moTaThem,
  });

  Map<String, dynamic> toJson() {
    return {
      'nhietDo': nhietDo,
      'anhSang': anhSang,
      'nuoc': nuoc,
      'doAm': doAm,
      'chatLuongKK': chatLuongKK,
      'moTaThem': moTaThem,
    };
  }
}

class ChamSoc {
  final TuoiNuoc tuoiNuoc;
  final List<KyThuatTrong> kyThuatTrong;
  final List<PhanBon> phanBon;
  final List<PhongSauBenh> phongSauBenh;
  final ThuHoach thuHoach;

  ChamSoc({
    required this.tuoiNuoc,
    required this.kyThuatTrong,
    required this.phanBon,
    required this.phongSauBenh,
    required this.thuHoach,
  });

  Map<String, dynamic> toJson() {
    return {
      'tuoiNuoc': tuoiNuoc.toJson(),
      'kyThuatTrong': kyThuatTrong.map((kt) => kt.toJson()).toList(),
      'phanBon': phanBon.map((pb) => pb.toJson()).toList(),
      'phongSauBenh': phongSauBenh.map((psb) => psb.toJson()).toList(),
      'thuHoach': thuHoach.toJson(),
    };
  }
}

class TuoiNuoc {
  final String ngayTuoi;
  final String thoiGianTuoi;
  final String huongDan;

  TuoiNuoc({
    required this.ngayTuoi,
    required this.thoiGianTuoi,
    required this.huongDan,
  });

  Map<String, dynamic> toJson() {
    return {
      'ngayTuoi': ngayTuoi,
      'thoiGianTuoi': thoiGianTuoi,
      'huongDan': huongDan,
    };
  }
}

class KyThuatTrong {
  final String tenKyThuat;
  final String moTa;
  final String imgKT;
  final String huongDan;

  KyThuatTrong({
    required this.tenKyThuat,
    required this.moTa,
    required this.imgKT,
    required this.huongDan,
  });

  Map<String, dynamic> toJson() {
    return {
      'tenKyThuat': tenKyThuat,
      'moTa': moTa,
      'img_KT': imgKT,
      'huongDan': huongDan,
    };
  }
}

class PhanBon {
  final String tenLoaiPhan;
  final String moTa;
  final String imgPB;
  final String huongDan;
  final String id;

  PhanBon({
    required this.id,
    required this.tenLoaiPhan,
    required this.moTa,
    required this.imgPB,
    required this.huongDan,
  });

  Map<String, dynamic> toJson() {
    return {
      'tenLoaiPhan': tenLoaiPhan,
      'moTa': moTa,
      'img_PB': imgPB,
      'huongDan': huongDan,
    };
  }
}

class PhongSauBenh {
  final String tenLoaiSB;
  final String moTa;
  final String cachPhongTru;
  String? id;

  PhongSauBenh({
    required this.tenLoaiSB,
    required this.moTa,
    required this.cachPhongTru,

  });

  Map<String, dynamic> toJson() {
    return {
      'tenLoaiSB': tenLoaiSB,
      'moTa': moTa,
      'cachPhongTru': cachPhongTru,
    };
  }
}

class ThuHoach {
  final String thoiGianTH;
  final String baoQuan;
  final String noiDung;

  ThuHoach({
    required this.thoiGianTH,
    required this.baoQuan,
    required this.noiDung,
  });

  Map<String, dynamic> toJson() {
    return {
      'thoiGianTH': thoiGianTH,
      'baoQuan': baoQuan,
      'noiDung': noiDung,
    };
  }
}
