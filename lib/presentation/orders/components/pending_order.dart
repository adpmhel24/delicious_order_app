import 'package:delicious_ordering_app/widget/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../widget/custom_date_range_picker.dart';
import '/presentation/orders/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_item.dart';

class PendingOrdersScreen extends StatefulWidget {
  final TextEditingController startdateController;
  final TextEditingController enddateController;

  const PendingOrdersScreen(
      {Key? key,
      required this.startdateController,
      required this.enddateController})
      : super(key: key);

  @override
  State<PendingOrdersScreen> createState() => _PendingOrdersScreenState();
}

class _PendingOrdersScreenState extends State<PendingOrdersScreen> {
  @override
  void initState() {
    context.read<OrdersBloc>().add(FetchForConfirmOrders(
          fromDate: widget.startdateController,
          toDate: widget.enddateController,
        ));
    super.initState();
  }

  Future<void> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    context.read<OrdersBloc>().add(FetchForConfirmOrders(
          fromDate: widget.startdateController,
          toDate: widget.enddateController,
        ));
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
                  controller: widget.startdateController,
                  labelText: 'Start Delivery Date',
                  readOnly: true,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Flexible(
                child: CustomTextField(
                  controller: widget.enddateController,
                  labelText: 'End Delivery Date',
                  readOnly: true,
                ),
              ),
              IconButton(
                onPressed: () {
                  customDateRangePicker(
                      context: context,
                      startDateController: widget.startdateController,
                      endDateController: widget.enddateController,
                      // initialDateRange: PickerDateRange(
                      //   DateTime.parse(
                      //     widget.startdateController.text.isEmpty
                      //         ? DateFormat('MM/dd/yyyy').format(DateTime.now())
                      //         : DateFormat("MM/dd/yyyy")
                      //             .parse(widget.startdateController.text)
                      //             .toString(),
                      //   ),
                      //   DateTime.parse(
                      //     widget.enddateController.text.isEmpty
                      //         ? DateFormat('MM/dd/yyyy').format(DateTime.now())
                      //         : DateFormat("MM/dd/yyyy")
                      //             .parse(widget.enddateController.text)
                      //             .toString(),
                      //   ),
                      // ),
                      onSubmit: () {
                        context.read<OrdersBloc>().add(FetchForConfirmOrders(
                              fromDate: widget.startdateController,
                              toDate: widget.enddateController,
                            ));
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
