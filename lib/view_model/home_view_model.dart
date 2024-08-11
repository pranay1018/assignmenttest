import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/porduct.dart';
import '../repository/home_repository.dart'; // Import your VerticalProductModel

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel(this._repository) : super(HomeState.initial()) {
    _fetchBanners();
    _fetchCategories();
    _fetchHorizontalProducts();
    _fetchVerticalProducts();
  }

  final HomeRepository _repository;

  Future<void> _fetchBanners() async {
    state = state.copyWith(banners: const AsyncValue.loading());
    try {
      final banners = await _repository.fetchBanners();
      state = state.copyWith(banners: AsyncValue.data(banners));
    } catch (e) {
      state = state.copyWith(categories: AsyncValue.error(e,StackTrace.current));
    }
  }

  Future<void> _fetchCategories() async {
    state = state.copyWith(categories: const AsyncValue.loading());
    try {
      final categories = await _repository.fetchCategories();
      state = state.copyWith(categories: AsyncValue.data(categories));
    } catch (e) {
      state = state.copyWith(categories: AsyncValue.error(e,StackTrace.current));
    }
  }

  Future<void> _fetchHorizontalProducts() async {
    state = state.copyWith(horizontalProducts: const AsyncValue.loading());
    try {
      final products = await _repository.fetchHorizontalProducts();
      state = state.copyWith(horizontalProducts: AsyncValue.data(products));
    } catch (e) {
      state = state.copyWith(categories: AsyncValue.error(e,StackTrace.current));
    }
  }

  Future<void> _fetchVerticalProducts() async {
    state = state.copyWith(verticalProducts: const AsyncValue.loading());
    try {
      final products = await _repository.fetchVerticalProducts();
      state = state.copyWith(verticalProducts: AsyncValue.data(products));
    } catch (e) {
      state = state.copyWith(categories: AsyncValue.error(e,StackTrace.current));
    }
  }
}

class HomeState {
  final AsyncValue<List<BannerModel>> banners;
  final AsyncValue<List<CategoryModel>> categories;
  final AsyncValue<List<ProductModel>> horizontalProducts;
  final AsyncValue<List<VerticalProductModel>> verticalProducts;

  HomeState({
    required this.banners,
    required this.categories,
    required this.horizontalProducts,
    required this.verticalProducts,
  });

  factory HomeState.initial() {
    return HomeState(
      banners: const AsyncValue.loading(),
      categories: const AsyncValue.loading(),
      horizontalProducts: const AsyncValue.loading(),
      verticalProducts: const AsyncValue.loading(),
    );
  }

  HomeState copyWith({
    AsyncValue<List<BannerModel>>? banners,
    AsyncValue<List<CategoryModel>>? categories,
    AsyncValue<List<ProductModel>>? horizontalProducts,
    AsyncValue<List<VerticalProductModel>>? verticalProducts,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      horizontalProducts: horizontalProducts ?? this.horizontalProducts,
      verticalProducts: verticalProducts ?? this.verticalProducts,
    );
  }
}

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  final repository = HomeRepository();
  return HomeViewModel(repository);
});
