import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:machinetest_intellect/Model/product_model.dart';
import 'package:machinetest_intellect/product_detailScreen.dart';
import 'package:machinetest_intellect/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ProductModel>> productlist;

  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  @override
  void initState() {
    super.initState();

    /// call api
    productlist = fetchProducts();
  }

  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(
        'https://ayurplan.com/wp-json/wc/v3/products?consumer_key=ck_ba3701bbf507f75d163384c5cbf983c8a95a34ab&consumer_secret=cs_1ec0a20b921e3221627ba6b2291d4bf34370cbb8'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ProductModel>((json) => ProductModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.clear();
              Fluttertoast.showToast(msg: "Logout successfully");

              if (!mounted) return;

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                  (Route<dynamic> route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Center(child: Text('ProductsList ')),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: productlist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 1),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                            productmodel: snapshot.data![index])));
                  },
                  child: ListTile(
                    title: Text(
                      snapshot.data![index].name,
                    ),
                    subtitle: Text(snapshot.data![index].shortDescription
                        .replaceAll(exp, '')),
                    // trailing: Text(snapshot.data![index].averageRating),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
