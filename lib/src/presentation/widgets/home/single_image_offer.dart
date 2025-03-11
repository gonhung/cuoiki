import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:go_router/go_router.dart';

class SingleImageOffer extends StatelessWidget {
  const SingleImageOffer({
    super.key,
    required this.headTitle,
    required this.subTitle,
    required this.productCategory,
    required this.image,
  });

  final String headTitle;
  final String subTitle;
  final String image;
  final String productCategory;

  @override
  Widget build(BuildContext context) {
    void goToCateogryDealsScreen() {
      context.pushNamed(AppRouteConstants.categoryproductsScreenRoute.name,
          pathParameters: {
            'category': productCategory,
          });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        Text(
          headTitle,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        Text(
          subTitle,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onTap: () => goToCateogryDealsScreen(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                image,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
