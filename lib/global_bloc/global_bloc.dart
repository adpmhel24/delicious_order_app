import 'package:delicious_ordering_app/global_bloc/ph_location_bloc/brgy_bloc/brgy_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './auth_bloc/bloc.dart';
import './cart_bloc/cart_bloc.dart';
import './customer_bloc/bloc.dart';
import './disc_type_bloc/bloc.dart';
import './products_bloc/bloc.dart';
import './sales_type_bloc/bloc.dart';
import './cust_type_bloc/bloc.dart';
import './ph_location_bloc/province_bloc/bloc.dart';
import 'ph_location_bloc/city_municipality_bloc/bloc.dart';

class GlobalBloc {
  static final authBloc = AuthBloc();
  static final productsBloc = ProductsBloc();
  static final cartBloc = CartBloc();
  static final customerBloc = CustomerBloc();
  static final salesTypeBloc = SalesTypeBloc();
  static final discTypeBloc = DiscTypeBloc();
  static final custTypeBloc = CustTypeBloc();
  static final provinceBloc = ProvinceBloc();
  static final cityMunicipalityBloc = CityMunicipalityBloc();
  static final brgyBloc = BrgyBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<AuthBloc>(create: (context) => authBloc),
    BlocProvider<ProductsBloc>(create: (context) => productsBloc),
    BlocProvider<CartBloc>(create: (context) => cartBloc),
    BlocProvider<CustomerBloc>(create: (context) => customerBloc),
    BlocProvider<SalesTypeBloc>(create: (context) => salesTypeBloc),
    BlocProvider<DiscTypeBloc>(create: (context) => discTypeBloc),
    BlocProvider<CustTypeBloc>(create: (context) => custTypeBloc),
    BlocProvider<ProvinceBloc>(create: (context) => provinceBloc),
    BlocProvider<CityMunicipalityBloc>(
        create: (context) => cityMunicipalityBloc),
    BlocProvider<BrgyBloc>(create: (context) => brgyBloc),
  ];

  static void dispose() {
    authBloc.close();
    productsBloc.close();
    cartBloc.close();
    customerBloc.close();
    salesTypeBloc.close();
    discTypeBloc.close();
    custTypeBloc.close();
    provinceBloc.close();
    cityMunicipalityBloc.close();
    brgyBloc.close();
  }

  /// Singleton factory
  static final GlobalBloc _instance = GlobalBloc._internal();

  factory GlobalBloc() {
    return _instance;
  }
  GlobalBloc._internal();
}
