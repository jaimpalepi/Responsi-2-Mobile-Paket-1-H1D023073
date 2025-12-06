import 'package:flutter/material.dart';
import 'package:mart/bloc/produk_bloc.dart';
import 'package:mart/model/produk.dart';
import 'package:mart/ui/produk_form.dart';
import 'package:mart/ui/produk_page.dart';
import 'package:mart/widget/warning_dialog.dart';

class ProdukDetail extends StatefulWidget {
  final Produk? produk;
  const ProdukDetail({super.key, this.produk});
  @override
  State<ProdukDetail> createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Inventaris ZaimMart"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Nama : ${widget.produk!.namaProduk}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${widget.produk!.hargaProduk.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Jumlah : ${widget.produk!.hargaProduk.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Tanggal Masuk : ${widget.produk!.tanggal}",
              style: const TextStyle(fontSize:18.0)
            ),
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(produk: widget.produk!),
              ),
            );
          },
        ),
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            ProdukBloc.deleteProduk(id: widget.produk!.id!).then(
                (value) => {
                      if (mounted)
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ProdukPage()))
                    }, onError: (error) {
              if (!mounted) return false;
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus data gagal, silahkan coba lagi",
                      ));
              return false;
            });
          },
        ),
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}