// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../bloc/bloc.dart';
// import 'dismissible_cart.dart';

// class CartListView extends StatelessWidget {
//   const CartListView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<CheckOutBloc, CheckOutState>(
//       listener: (_, state) {
//         if (state.cartItems.isEmpty) {
//           print('called');
//           AutoRouter.of(context).pop();
//         }
//       },
//       child: BlocBuilder<CheckOutBloc, CheckOutState>(builder: (_, state) {
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: state.cartItems.length,
//           itemBuilder: (context, index) {
//             return DismissibleCart(cartItem: state.cartItems[index]);
//           },
//         );
//       }),
//     );
//   }
// }
