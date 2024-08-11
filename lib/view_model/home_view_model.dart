import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../repository/home_repository.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel(this._repository) : super(HomeState.initial()) {
    _fetchAllData();
  }

  final HomeRepository _repository;

  Future<void> _fetchAllData() async {
    state = state.copyWith(overallState: const AsyncValue.loading());

    try {
      final bannersFuture = _repository.fetchBanners();
      final categoriesFuture = _repository.fetchCategories();
      final horizontalProductsFuture = _repository.fetchRecentlyOrderedProducts();
      final verticalProductsFuture = _repository.fetchProducts();

      final banners = await bannersFuture;
      final categories = await categoriesFuture;
      final horizontalProducts = await horizontalProductsFuture;
      final verticalProducts = await verticalProductsFuture;

      state = state.copyWith(
        overallState: AsyncValue.data(null), // Data is loaded successfully
        banners: AsyncValue.data(banners),
        categories: AsyncValue.data(categories),
        horizontalProducts: AsyncValue.data(horizontalProducts),
        verticalProducts: AsyncValue.data(verticalProducts),
      );
    } catch (e) {
      state = state.copyWith(
        overallState: AsyncValue.error(e,StackTrace.current),
        banners: AsyncValue.error(e,StackTrace.current),
        categories: AsyncValue.error(e,StackTrace.current),
        horizontalProducts: AsyncValue.error(e,StackTrace.current),
        verticalProducts: AsyncValue.error(e,StackTrace.current),
      );
    }
  }
}


class HomeState {
  final AsyncValue<void> overallState; // New unified state
  final AsyncValue<List<BannerModel>> banners;
  final AsyncValue<List<CategoryModel>> categories;
  final AsyncValue<List<ProductModel>> horizontalProducts;
  final AsyncValue<List<ProductModel>> verticalProducts;

  HomeState({
    required this.overallState,
    required this.banners,
    required this.categories,
    required this.horizontalProducts,
    required this.verticalProducts,
  });

  factory HomeState.initial() {
    return HomeState(
      overallState: const AsyncValue.loading(),
      banners: const AsyncValue.loading(),
      categories: const AsyncValue.loading(),
      horizontalProducts: const AsyncValue.loading(),
      verticalProducts: const AsyncValue.loading(),
    );
  }

  HomeState copyWith({
    AsyncValue<void>? overallState,
    AsyncValue<List<BannerModel>>? banners,
    AsyncValue<List<CategoryModel>>? categories,
    AsyncValue<List<ProductModel>>? horizontalProducts,
    AsyncValue<List<ProductModel>>? verticalProducts,
  }) {
    return HomeState(
      overallState: overallState ?? this.overallState,
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      horizontalProducts: horizontalProducts ?? this.horizontalProducts,
      verticalProducts: verticalProducts ?? this.verticalProducts,
    );
  }
}


