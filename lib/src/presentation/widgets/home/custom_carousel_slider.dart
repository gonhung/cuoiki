import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
import 'package:go_router/go_router.dart';

class CustomCarouselSliderMap extends StatelessWidget {
  const CustomCarouselSliderMap(
      {super.key, required this.onPageChanged, required this.sliderImages});

  final List<Map<String, String>> sliderImages;

  final Function(int p1, CarouselPageChangedReason p2) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: sliderImages.map((i) {
        return Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              context.pushNamed(
                  AppRouteConstants.categoryproductsScreenRoute.name,
                  pathParameters: {'category': i['category']!});
            },
            child: Image.network(
              i['image']!,
              alignment: Alignment.topCenter,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error);
              },
            ),
          );
        });
      }).toList(),
      options: CarouselOptions(
          autoPlay: true,
          height: 450,
          viewportFraction: 1,
          onPageChanged: onPageChanged),
    );
  }
}

class CustomCarouselSliderList extends StatelessWidget {
  const CustomCarouselSliderList({
    super.key,
    required this.sliderImages,
    required this.onPageChanged,
  });

  final List<String> sliderImages;
  final Function(int p1, CarouselPageChangedReason p2) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: sliderImages.map((i) {
        return Builder(builder: (context) {
          return Image.network(
            i,
            alignment: Alignment.topCenter,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error);
            },
          );
        });
      }).toList(),
      options: CarouselOptions(
          height: 450, viewportFraction: 1, onPageChanged: onPageChanged),
    );
  }
}
