import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  const ProductCard(
      {super.key,
      required this.image,
      required this.title,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                height: 100,
                width: double.infinity,
                child: CachedNetworkImage(imageUrl: image)),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.only(top: 5, right: 5),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 0, 136, 154).withOpacity(.9),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "$price \$",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: RichText(
              overflow: TextOverflow.ellipsis,
              strutStyle: const StrutStyle(fontSize: 12.0),
              text: TextSpan(
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 136, 154),
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                  text: title)),
        ),
      ],
    );
  }
}
