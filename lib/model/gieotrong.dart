class GieoTrong {
  final NgoaiCanh ngoaiCanh;
  final String thoiVu;

  GieoTrong({
    required this.ngoaiCanh,
    required this.thoiVu,
  });
}

class NgoaiCanh {
  final String nhietdo;
  final String anhSang;
  final String nuoc;
  final String doAm;
  final String chatLuongKK;
  final String moTaThem;

  NgoaiCanh({
    required this.nhietdo,
    required this.anhSang,
    required this.nuoc,
    required this.doAm,
    required this.chatLuongKK,
    required this.moTaThem,
  });
}
