import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uas_project/important/home_main.dart';
import 'package:uas_project/important/model.dart';

class UpdatePage extends StatefulWidget {
  final PostModel model;
  // ignore: use_key_in_widget_constructors
  const UpdatePage({Key? key, required this.model});

  @override
  // ignore: library_private_types_in_public_api
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final Dio dio = Dio();
  final String apiUrl = "http://192.168.18.6/flutter-api/update.php";

  TextEditingController newNameController = TextEditingController();
  TextEditingController newCategoryController = TextEditingController();
  TextEditingController newSatuanController = TextEditingController();
  TextEditingController newQuantityController = TextEditingController();
  TextEditingController newTotalController = TextEditingController();

  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    newNameController.text = widget.model.name ?? "";
    newCategoryController.text = widget.model.category ?? "";
    newSatuanController.text = widget.model.satuan ?? "";
    newQuantityController.text = widget.model.quantity ?? "";
    newTotalController.text = widget.model.total ?? "";
  }

  void updateData() async {
    try {
      if (newCategoryController.text.toLowerCase() == 'food' ||
          newCategoryController.text.toLowerCase() == 'drink') {
        Response response = await dio.post(apiUrl, data: {
          "id": widget.model.id,
          "newName": newNameController.text,
          "newCategory": newCategoryController.text,
          "newSatuan": newSatuanController.text,
          "newQuantity": newQuantityController.text,
          "newTotal": newTotalController.text,
        });
        debugPrint("Response: ${response.data}");
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeMain()),
            (route) => false);

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil diperbaharui')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Category must be either "Food" or "Drink"')),
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Page Info'),
        centerTitle: true,
        backgroundColor: Colors.amber[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: newNameController,
                    decoration:
                        const InputDecoration(labelText: 'Nama Barang Baru'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: newCategoryController,
                    decoration:
                        const InputDecoration(labelText: 'Category Baru'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: newSatuanController,
                    decoration:
                        const InputDecoration(labelText: 'Harga Satuan Baru'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: newQuantityController,
                    decoration: const InputDecoration(
                        labelText: 'Jumlah Pembelian Baru'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          controller: newTotalController,
                          decoration:
                              const InputDecoration(labelText: 'Total Baru'),
                          enabled: false,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        double harga =
                            double.tryParse(newSatuanController.text) ?? 0;
                        int quantity =
                            int.tryParse(newQuantityController.text) ?? 0;
                        double total = harga * quantity;

                        newTotalController.text = total.toStringAsFixed(
                            total.truncateToDouble() == total ? 0 : 2);

                        setState(() {});
                      },
                      child: const Text('Calculate'),
                    ),
                  ],
                ),
                ButtonBar(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        updateData();
                      },
                      child: const Text('Update'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeMain(),
                            ),
                            (route) => false);
                      },
                      child: const Text('Back'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
