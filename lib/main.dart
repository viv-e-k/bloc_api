import 'package:bloc_api/pages/pages.dart';
import 'package:bloc_api/product/bloc/bloc.dart';
import 'package:bloc_api/product/data/repository/product_repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc API',
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQueryData.copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      theme: ThemeData(useMaterial3: true),
      home: RepositoryProvider<ProductRepository>(
        create: (context) => ProductRepository(),
        child: BlocProvider(
          lazy: false,
          create: (BuildContext context) =>
              ProductBloc(productRepository: context.read<ProductRepository>()),
          child: const ProductsPage(),
        ),
      ),
    );
  }
}
