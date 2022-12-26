import 'package:fire_str/bloc/app_event.dart';
import 'package:fire_str/bloc/app_state.dart';
import 'package:fire_str/repo/product_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBlock extends Bloc<ProductEvent, ProductState>{
  final ProductRepo productRepo;

  ProductBlock({required this.productRepo}) : super(IntialState()){
    on<Create>((event, emit) async {
      emit(ProductAdding());
      await Future.delayed(const Duration(seconds: 1));
      try{
        await productRepo.create(name: event.name, price: event.price);
        emit(ProductAdded());
      } catch (e){
        emit(ProductError(error: e.toString()));
      }
    });
  }
}