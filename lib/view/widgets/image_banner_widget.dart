import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../view_model/home_view_model.dart';

class ImageBannerList extends ConsumerStatefulWidget {
  const ImageBannerList({super.key});

  @override
  _ImageBannerListState createState() => _ImageBannerListState();
}

class _ImageBannerListState extends ConsumerState<ImageBannerList> {
  late final PageController _pageController;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        final page = (_pageController.page ?? 0) + 1;
        _pageController.animateToPage(
          page.toInt() % 3,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bannersAsyncValue = ref.watch(homeViewModelProvider.select((state) => state.banners));

    return bannersAsyncValue.when(
      data: (banners) {
        // Ensure we have 3 banners
        final limitedBanners = banners.take(3).toList();
        return SizedBox(

          height: MediaQuery.of(context).size.width * (2 / 3), // Aspect ratio 2:3
          child: PageView.builder(
            controller: _pageController,
            itemCount: limitedBanners.length,
            itemBuilder: (context, index) {
              final banner = limitedBanners[index];
              return buildBanner(banner.imageUrl);
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget buildBanner(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
