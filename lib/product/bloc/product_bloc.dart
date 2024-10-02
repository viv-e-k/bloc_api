import 'package:bloc/bloc.dart';
import 'package:bloc_api/helper/exception_handler.dart';
import 'package:bloc_api/product/data/model/product_model.dart';
import 'package:bloc_api/product/data/repository/product_repository.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   ProductBloc() : super(ProductInitial()) {
//     on<ProductEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<GetProductEvent>(
        (GetProductEvent event, Emitter<ProductState> emit) async {
      emit(ProductLoadingState());
      try {
        final products = await productRepository.getProducts();
        if (products.isEmpty) {
          emit(ProductEmptyState());
        } else {
          emit(ProductLoadedState(products: products));
        }
      } catch (e) {
        final message = handleExceptionWithMessage(e);
        emit(ProductLoadingFailedState(errorMessage: message));
      }
    });
  }
}
