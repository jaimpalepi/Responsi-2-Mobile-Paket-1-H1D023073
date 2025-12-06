import 'package:flutter/material.dart';
import 'package:mart/bloc/produk_bloc.dart';
import 'package:mart/model/produk.dart';
import 'package:mart/ui/produk_page.dart';
import 'package:mart/widget/warning_dialog.dart';

class ProdukForm extends StatefulWidget {
  final Produk? produk;
  const ProdukForm({super.key, this.produk});
  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";

  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();
  final _jumlahTextboxController = TextEditingController();
  final _tanggalTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "Ubah Inventaris ZaimMart";
        tombolSubmit = "UBAH";
        _namaProdukTextboxController.text = widget.produk!.namaProduk!;
        _hargaProdukTextboxController.text = widget.produk!.hargaProduk
            .toString();
        _jumlahTextboxController.text = widget.produk!.jumlah.toString();
        _tanggalTextboxController.text = widget.produk!.tanggal!;
      });
    } else {
      judul = "Tambah Inventaris ZaimMart";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _namaProdukTextField(),
                _hargaProdukTextField(),
                _jumlahTextField(),
                _tanggalTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Produk"),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga"),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  Widget _jumlahTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jumlah"),
      keyboardType: TextInputType.number,
      controller: _jumlahTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jumlah harus diisi";
        }
        return null;
      },
    );
  }

  Widget _tanggalTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Tanggal Masuk"),
      keyboardType: TextInputType.text,
      controller: _tanggalTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tanggal harus diisi";
        }
        return null;
      },
    );
  }

  bool _isLoading = false;

  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.produk != null) {
              //kondisi update produk
              _ubah();
            } else {
              //kondisi tambah produk
              _simpan();
            }
          }
        }
      },
    );
  }

  void _simpan() {
    setState(() {
      _isLoading = true;
    });
    Produk createProduk = Produk(id: null);
    createProduk.namaProduk = _namaProdukTextboxController.text;
    createProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
    createProduk.jumlah = int.parse(_jumlahTextboxController.text);
    createProduk.tanggal = _tanggalTextboxController.text;
    ProdukBloc.addProduk(produk: createProduk).then((value) {
      if (!mounted) return;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage()));
    }, onError: (error) {
      if (!mounted) return null;
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
      return null;
    });
    setState(() {
      _isLoading = false;
    });
  }

  void _ubah() {
    setState(() {
      _isLoading = true;
    });
    Produk updateProduk = Produk(id: widget.produk!.id!);
    updateProduk.namaProduk = _namaProdukTextboxController.text;
    updateProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
    updateProduk.jumlah = int.parse(_jumlahTextboxController.text);
    updateProduk.tanggal = _tanggalTextboxController.text;
    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      if (!mounted) return;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage()));
    }, onError: (error) {
      if (!mounted) return null;
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
      return null;
    });
    setState(() {
      _isLoading = false;
    });
  }
}