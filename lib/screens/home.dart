import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/models/product.dart';
import 'package:task/providers/provider.dart';
import 'package:task/screens/widgets/card_shimmer.dart';
import 'package:task/screens/widgets/product_card.dart';
import 'package:task/utils/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _controller = ScrollController();
  bool _isLoading = false;
  bool changeCategory = false;

  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(scrollListener);
    fetch();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading =
        Provider.of<CustomProvider>(context, listen: true).isLoading;

    final custom = Provider.of<CustomProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 136, 154),
      body: SafeArea(
          child: SingleChildScrollView(
        controller: _controller,
        child: products.isEmpty && _isLoading
            ? const CardShimmer()
            : Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    width: width(context) * .9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        dropdownColor: Colors.white,
                        focusColor: Colors.white,
                        items: custom.categories
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 136, 154),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: custom.category,
                        onChanged: (value) {
                          setState(() {
                            custom.category = value as String;
                            fetch();
                            changeCategory = true;
                          });
                        },
                      ),
                    ),
                  ),
                  isLoading
                      ? const CardShimmer()
                      : changeCategory
                          ? const CardShimmer()
                          : SizedBox(
                              child: GridView.builder(
                                padding: const EdgeInsets.all(5),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: custom.products.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                        width: width(context) * .4,
                                        decoration: const BoxDecoration(),
                                        child: ProductCard(
                                            image: custom.products[index].image,
                                            title: custom.products[index].title,
                                            price: custom.products[index].price
                                                .toString())),
                                  );
                                },
                              ),
                            ),
                  _isLoading ? const CardShimmer() : Container()
                ],
              ),
      )),
    );
  }

  void scrollListener() async {
    final custom = Provider.of<CustomProvider>(context, listen: false);
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      custom.num = custom.num + 2;
      setState(() {});
      fetch();
    }
  }

  fetch() async {
    setState(() {
      _isLoading = true;
    });
    final custom = Provider.of<CustomProvider>(context, listen: false);
    await custom.fetchData().then((value) {
      setState(() {
        products = custom.products;
        _isLoading = false;
        changeCategory = false;
      });
    });
  }
}
