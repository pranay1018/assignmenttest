import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../repository/home_repository.dart';
import '../view_model/home_view_model.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  final homeRepository = ref.read(homeRepositoryProvider);
  return HomeViewModel(homeRepository);
});


final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});


final productDetailProvider = FutureProvider.family<ProductModel, int>((ref, productId) async {
  final homeRepository = ref.read(homeRepositoryProvider);
  return await homeRepository.fetchProductDetails(productId);
});
