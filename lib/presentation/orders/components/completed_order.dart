import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

import '../../../widget/custom_text_field.dart';
import '../../../widget/custom_date_range_picker.dart';
import '/presentation/orders/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_item.dart';

// class CompletedOrderScreen extends StatefulWidget {
//   const CompletedOrderScreen({Key? key}) : super(key: key);

//   @override
//   State<CompletedOrderScreen> createState() => _CompletedOrderScreenState();
// }

// class _CompletedOrderScreenState extends State<CompletedOrderScreen> {

// }

class CompletedOrderScreen extends StatefulWidget {
  const CompletedOrderScreen({Key? key}) : super(key: key);

  @override
  State<CompletedOrderScreen> createState() => _CompletedOrderScreenState();
}

class _CompletedOrderScreenState extends State<CompletedOrderScreen> {
  final TextEditingController _startdateController = TextEditingController();
  final TextEditingController _enddateController = TextEditingController();

  @override
  void dispose() {
    _startdateController.dispose();
    _enddateController.dispose();
    super.dispose();
  }

  Future<void> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    BlocProvider.of<OrdersBloc>(context).add(FetchCompletedOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                child: CustomTextField(
                  controller: _startdateController,
                  labelText: 'Start Delivery Date',
                  readOnly: true,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Flexible(
                child: CustomTextField(
                  controller: _enddateController,
                  labelText: 'End Delivery Date',
                  readOnly: true,
                ),
              ),
              IconButton(
                onPressed: () {
                  customDateRangePicker(
                      context: context,
                      startDateController: _startdateController,
                      endDateController: _enddateController,
                      onSubmit: () {
                        // context.read<OrdersBloc>().add(FetchForConfirmOrders());
                        Navigator.of(context).pop();
                      });
                },
                icon: const Icon(LineIcons.calendar),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              if (state is LoadedOrdersCompleted) {
                return RefreshIndicator(
                  onRefresh: () => _refresh(context),
                  child: ListView.builder(
                    itemCount: state.orders.length,
                    itemBuilder: (cntxt, i) {
                      return OrderItem(state.orders[i]);
                    },
                  ),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () => _refresh(context),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
