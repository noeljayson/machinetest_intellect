import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:machinetest_intellect/Model/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    Key? key,
    required this.productmodel,
  }) : super(key: key);
  final ProductModel productmodel;

  // print()
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(height: 400.0),
              items: widget.productmodel.images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return i.src.isEmpty ? Container() : Image.network(i.src);
                  },
                );
              }).toList(),
            ),
            Text("Rating : ${widget.productmodel.averageRating}"),
            Text(
                "Description : ${widget.productmodel.description.replaceAll(exp, '')}"),
            Text("Price : ${widget.productmodel.price.toString()}"),
          ],
        ),
      ),
    );
  }
}
