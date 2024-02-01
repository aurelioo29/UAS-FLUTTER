import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:uas_project/important/create_page.dart';
import 'package:uas_project/important/detail_page.dart';
import 'package:uas_project/important/model.dart';
import 'package:uas_project/important/service.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  final apiService = ApiService();
  TextEditingController searchController = TextEditingController();
  late List<PostModel> allPosts;
  late List<PostModel> filteredList;
  late Dio dio;

  @override
  void initState() {
    super.initState();
    filteredList = [];
    allPosts = [];
    dio = Dio();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await dio.get('http://192.168.18.6/flutter-api/search.php');

      if (response.statusCode == 200) {
        setState(() {
          allPosts = List<PostModel>.from(
            response.data.map((model) => PostModel.fromJson(model)),
          );
          filteredList = allPosts;
        });
      } else {
        debugPrint('Failed to load data. Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void performSearch(String keyword) {
    setState(() {
      filteredList = allPosts
          .where((post) =>
              (post.name?.toLowerCase().contains(keyword.toLowerCase()) ??
                  false) ||
              (post.category?.toLowerCase().contains(keyword.toLowerCase()) ??
                  false))
          .toList();
    });
  }

  Future<void> onRefresh() async {
    await fetchData();
    // Add any additional logic you need after refreshing, such as showing a snackbar.
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data refreshed'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Transaction'),
        backgroundColor: Colors.blueAccent[400],
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreatePage(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            iconSize: 40,
          ),
          IconButton(
            onPressed: () async {
              await onRefresh();
            },
            icon: const Icon(Icons.refresh),
            iconSize: 40,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Enter keyword',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                performSearch(value);
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    PostModel model = filteredList[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox(
                        width: double.infinity,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(model: model),
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            child: Text('ID ${model.id.toString()}'),
                          ),
                          subtitle: Text(
                              'Name: ${model.name ?? ''}\nCategory: ${model.category ?? ''}\nTotal: ${model.total ?? ''}'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
