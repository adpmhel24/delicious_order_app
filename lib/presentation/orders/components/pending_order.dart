import 'package:delicious_ordering_app/widget/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

import '../../../widget/custom_date_range_picker.dart';
import '/presentation/orders/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_item.dart';

class PendingOrdersScreen extends StatefulWidget {
  const PendingOrdersScreen({Key? key}) : super(key: key);

  @override
  State<PendingOrdersScreen> createState() => _PendingOrdersScreenState();
}

class _PendingOrdersScreenState extends State<PendingOrdersScreen> {
  final TextEditingController _startdateController = TextEditingController();
  final TextEditingController _enddateController = TextEditingController();

  Future<void> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    BlocProvider.of<OrdersBloc>(context).add(FetchForConfirmOrders(
        _startdateController.text, _enddateController.text));
  }

  @override
  void initState() {
    context.read<OrdersBloc>().add(FetchForConfirmOrders(
        _startdateController.text, _enddateController.text));
    super.initState();
  }

  @override
  void dispose() {
    _startdateController.dispose();
    _enddateController.dispose();
    super.dispose();
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
                        context.read<OrdersBloc>().add(FetchForConfirmOrders(
                            _startdateController.text,
                            _enddateController.text));
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
              if (state is LoadedOrdersForConfirm) {
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
        )
      ],
    );
  }
}
