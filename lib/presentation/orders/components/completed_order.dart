import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget/custom_text_field.dart';
import '../../../widget/custom_date_range_picker.dart';
import '/presentation/orders/bloc/bloc.dart';

import 'order_item.dart';

class CompletedOrderScreen extends StatefulWidget {
  final TextEditingController startdateController;
  final TextEditingController enddateController;
  const CompletedOrderScreen(
      {Key? key,
      required this.startdateController,
      required this.enddateController})
      : super(key: key);

  @override
  State<CompletedOrderScreen> createState() => _CompletedOrderScreenState();
}

class _CompletedOrderScreenState extends State<CompletedOrderScreen> {
  Future<void> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    BlocProvider.of<OrdersBloc>(context).add(FetchCompletedOrders(
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
                      initialDateRange: PickerDateRange(
                        DateTime.parse(
                          widget.startdateController.text.isEmpty
                              ? DateFormat('MM/dd/yyyy').format(DateTime.now())
                              : DateFormat("MM/dd/yyyy")
                                  .parse(widget.startdateController.text)
                                  .toString(),
                        ),
                        DateTime.parse(
                          widget.enddateController.text.isEmpty
                              ? DateFormat('MM/dd/yyyy').format(DateTime.now())
                              : DateFormat("MM/dd/yyyy")
                                  .parse(widget.enddateController.text)
                                  .toString(),
                        ),
                      ),
                      onSubmit: () {
                        context.read<OrdersBloc>().add(FetchCompletedOrders(
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
