// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lapor_book/components/list_item.dart';
import 'package:lapor_book/models/akun.dart';
import 'package:lapor_book/models/laporan.dart';

class AllLaporan extends StatefulWidget {
  final Akun akun;
  const AllLaporan({super.key, required this.akun});

  @override
  State<AllLaporan> createState() => _AllLaporanState();
}

class _AllLaporanState extends State<AllLaporan> {
  final _db = FirebaseFirestore.instance;

  List<Laporan> listLaporan = [];

  void getLaporan() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _db.collection('laporan').get();
      setState(() {
        listLaporan.clear();
        for (var documents in querySnapshot.docs) {
          List<dynamic>? likeData = documents.data()['likes'];
          List<Likes>? listLike = likeData?.map((e){
            return Likes(email: e['email'], tanggal: e['tanggal'].toDate());
          }).toList();
          listLaporan.add(
            Laporan(
              uid: documents.data()['uid'],
              docId: documents.data()['docId'],
              judul: documents.data()['judul'],
              instansi: documents.data()['instansi'],
              nama: documents.data()['nama'],
              status: documents.data()['status'],
              tanggal: documents.data()['tanggal'].toDate(),
              maps: documents.data()['maps'],
              deskripsi: documents.data()['deskripsi'],
              gambar: documents.data()['gambar'],
              like: listLike,
            ),
          );
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getLaporan();
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1 / 1.129,
            ),
            itemCount: listLaporan.length,
            itemBuilder: (context, index) {
              return ListItem(
                akun: widget.akun,
                laporan: listLaporan[index],
                isLaporanKu: false,
              );
            }),
      ),
    );
  }
}
