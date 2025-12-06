// model/produk.dart
class Produk {
  int? id;
  String? namaProduk;
  int? hargaProduk;
  int? jumlah;
  String? tanggal;

  Produk({this.id, this.namaProduk, this.hargaProduk, this.jumlah, this.tanggal});

  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
      id: (obj['id'] is int) ? obj['id'] : int.tryParse(obj['id'].toString()),
      namaProduk: obj['nama'],
      hargaProduk: (obj['harga'] is int)
          ? obj['harga']
          : int.tryParse(obj['harga'].toString()),
      jumlah: (obj['jumlah'] is int)
          ? obj['jumlah']
          : int.tryParse(obj['jumlah'].toString()),
      tanggal: obj['tanggal_masuk']
    );
  }
}