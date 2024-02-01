import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uas_project/important/home_main.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  String? selectedCategory;

  final formKey = GlobalKey<FormState>();

  void postData() async {
    Dio dio = Dio();
    String apiUrl = "http://192.168.18.6/flutter-api/insert.php";

    try {
      Response response = await dio.post(apiUrl, data: {
        "name": nameController.text,
        "category": selectedCategory, // Added category to the request data
        "satuan": hargaController.text,
        "quantity": quantityController.text,
        "total": totalController.text,
      });

      debugPrint("Response: ${response.data}");
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Form Post',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: Colors.green[700],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(labelText: 'Masukan Nama Barang'),
                  ),
                  const SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'Food',
                        child: Text('Food'),
                      ),
                      DropdownMenuItem(
                        value: 'Drink',
                        child: Text('Drink'),
                      ),
                    ],
                    decoration: const InputDecoration(labelText: 'Category'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: hargaController,
                    decoration:
                        const InputDecoration(labelText: 'Masukan Harga Satuan'),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: quantityController,
                    decoration:
                        const InputDecoration(labelText: 'Masukan Jumlah Pembelian'),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: totalController,
                          decoration:
                              const InputDecoration(labelText: 'Total Pembelian'),
                          enabled: false,
                        ),
                      ),
                      const SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () {
                          // Calculate and set the total based on hargaController and quantityController
                          double harga =
                              double.tryParse(hargaController.text) ?? 0;
                          int quantity =
                              int.tryParse(quantityController.text) ?? 0;
                          double total = harga * quantity;

                          // Format the total to exclude decimal places for whole numbers
                          totalController.text = total.toStringAsFixed(
                              total.truncateToDouble() == total ? 0 : 2);

                          // Use setState to trigger a rebuild of the widget
                          setState(() {});
                        },
                        child: const Text('Calculate'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      postData();

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Data post berhasil disimpan')));

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeMain()),
                          (route) => false);
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
