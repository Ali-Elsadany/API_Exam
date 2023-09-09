import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'cat_code.dart';

class CatsScreen extends StatefulWidget {
  @override
  _CatsScreen createState() => _CatsScreen();
}

class _CatsScreen extends State<CatsScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  List cats = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 1,
        vsync: this
    );
    fetchCats();
  }

  Future<void> fetchCats() async {
    setState(() {
      loading = true;
    });
    final url = Uri.parse('https://api.thecatapi.com/v1/images/search?limit=80&mime_types=&order=Random&size=small&page=3&sub_id=demo-ce06ee');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final newCats = json.decode(response.body);
      setState(() {
        cats = newCats;
        loading = false;
      });
    } //error
    else {setState(() {
        loading = false;
        cats = [];
      });
    }
  }

  Future<void> refreshData() async {
    await fetchCats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Flutter Cats App Toy'),
        actions: [
          IconButton(
              onPressed: () {
                refreshData();
              },
              icon: Icon(Icons.refresh))
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Cats'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
             loading ?
             Shimmer.fromColors(
        baseColor: Colors.grey[850]!,
        highlightColor: Colors.grey[800]!,
        child: GridView.builder(
          padding: EdgeInsets.all(24),
          itemCount: cats.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),

          itemBuilder: (context, index) {
            return
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        CatCodeScreen(catId: cats[index]['id'])),
                  );
                },
                child: Image.network(cats[index]['url'], fit: BoxFit.fitHeight),
              );
          },
        ),
      ): GridView.builder(
            padding: EdgeInsets.all(24),
            itemCount: cats.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),

            itemBuilder: (context, index) {
              return
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          CatCodeScreen(catId: cats[index]['id'])),
                    );
                  },
                  child: Image.network(cats[index]['url'], fit: BoxFit.fitHeight),
                );
            },
          ),
        ],
      ),
    );
  }
}


