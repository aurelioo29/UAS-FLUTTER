import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uas_project/important/home_main.dart';
import 'package:uas_project/important/model.dart';
import 'package:uas_project/important/update_page.dart';

class DetailPage extends StatelessWidget {
  final PostModel model;
  DetailPage({Key? key, required this.model}) : super(key: key);

  final Dio dio = Dio();
  final String apiUrl =
      "http://192.168.18.6/flutter-api/delete.php";

  void deleteData() async {
    try {
      Response response = await dio.post(apiUrl, data: {"id": model.id});
      debugPrint("Response: ${response.data}");
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page Info'),
        centerTitle: true,
        backgroundColor: Colors.brown[500],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'Name Barang: ${model.name.toString()}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  'Category Barang: ${model.category.toString()}\nHarga Satuan: ${model.satuan.toString()}\nHarga Per Quantity : ${model.quantity.toString()}\nHarga Total : ${model.total.toString()}',
                ),
              ),
              ButtonBar(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdatePage(
                                    model: model,
                                  )),
                          (route) => false);
                    },
                    child: const Text('Edit'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      deleteData();

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Data berhasil dihapus')));

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeMain()),
                          (route) => false);
                    },
                    child: const Text('Delete'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
