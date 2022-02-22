import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../utils/constant.dart';
import '../bloc/bloc.dart';
import '/global_bloc/sales_type_bloc/bloc.dart';
import '/global_bloc/disc_type_bloc/bloc.dart';
import '/utils/size_config.dart';
import '/widget/custom_text_field.dart';

class CheckOutForm extends StatefulWidget {
  const CheckOutForm({Key? key}) : super(key: key);

  @override
  _CheckOutFormState createState() => _CheckOutFormState();
}

class _CheckOutFormState extends State<CheckOutForm> {
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _deliveryMethod = TextEditingController();
  final TextEditingController _discountTypeController = TextEditingController();
  final TextEditingController _paymentMethod = TextEditingController();
  final TextEditingController _orderNotes = TextEditingController();
  final TextEditingController _salesTypeController = TextEditingController();

  DateFormat dateFormat = DateFormat("MM/dd/yyyy");

  @override
  void dispose() {
    _deliveryMethod.dispose();
    _paymentMethod.dispose();
    _orderNotes.dispose();
    _discountTypeController.dispose();
    _dateTimeController.dispose();
    _salesTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          FormBuilderChoiceChip(
            alignment: WrapAlignment.spaceEvenly,
            name: 'delivery_method_chips',
            backgroundColor: const Color(0xFFFFF1BD),
            selectedColor: const Color(0xFFA3DA8D),
            decoration: const InputDecoration(
              labelText: 'Delivery Method*',
            ),
            onChanged: (value) {
              context
                  .read<CheckOutBloc>()
                  .add(DeliveryMethodChange(value.toString()));
            },
            options: const [
              FormBuilderFieldOption(
                value: 'Pickup',
                child: Text(
                  'Pick Up',
                ),
              ),
              FormBuilderFieldOption(
                value: 'Delivery',
                child: Text(
                  'Delivery',
                ),
              ),
            ],
          ),
          FormBuilderChoiceChip(
            alignment: WrapAlignment.spaceEvenly,
            name: 'payment_method_chips',
            backgroundColor: const Color(0xFFFFF1BD),
            selectedColor: const Color(0xFFA3DA8D),
            decoration: const InputDecoration(
              labelText: 'Payment Method*',
            ),
            onChanged: (value) {
              context.read<CheckOutBloc>().add(
                  PaymentMethodChange((value == null) ? '' : value.toString()));
            },
            options: const [
              FormBuilderFieldOption(
                value: 'COD',
                child: Text(
                  'Cash On Delivery',
                ),
              ),
              FormBuilderFieldOption(
                value: 'OnlineBanking',
                child: Text(
                  'Online Banking',
                ),
              ),
              FormBuilderFieldOption(
                value: 'GCash',
                child: Text(
                  'GCash',
                ),
              ),
              FormBuilderFieldOption(
                value: 'PayMaya',
                child: Text(
                  'PayMaya',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomTextField(
            labelText: 'SalesType*',
            controller: _salesTypeController,
            readOnly: true,
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _salesTypeController.clear();
              },
            ),
            onTap: () {
              context.read<SalesTypeBloc>().add(FetchSalesTypeFromLocal());
              showMaterialModalBottomSheet(
                context: context,
                enableDrag: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                  ),
                ),
                builder: (_) {
                  return BlocBuilder<SalesTypeBloc, SalesTypeState>(
                    builder: (_, state) {
                      if (state is SalesTypeLoadedState) {
                        return SafeArea(
                          child: SizedBox(
                            height: (SizeConfig.screenHeight * .75).h,
                            child: RefreshIndicator(
                              onRefresh: () async {
                                context
                                    .read<SalesTypeBloc>()
                                    .add(FetchSalesTypeFromAPI());
                              },
                              child: ListView.separated(
                                itemCount: state.salesTypes.length,
                                separatorBuilder: (_, index) {
                                  return const Divider(
                                    thickness: 1,
                                    color: Color(0xFFBDBDBD),
                                  );
                                },
                                itemBuilder: (_, index) => ListTile(
                                  title:
                                      Text(state.salesTypes[index].description),
                                  selected:
                                      state.salesTypes[index].description ==
                                          _salesTypeController.text,
                                  selectedColor: Constant.onSelectedColor,
                                  onTap: () {
                                    _salesTypeController.text =
                                        state.salesTypes[index].description;
                                    context.read<CheckOutBloc>().add(
                                          SalesTypeCodeChange(
                                              state.salesTypes[index].code),
                                        );
                                    AutoRouter.of(context).pop();
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return SizedBox(
                        height: (SizeConfig.screenHeight * .5).h,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomTextField(
            labelText: 'Discount Type',
            controller: _discountTypeController,
            readOnly: true,
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _discountTypeController.clear();
              },
            ),
            onTap: () {
              context.read<DiscTypeBloc>().add(FetchDiscTypeFromLocal());
              showMaterialModalBottomSheet(
                context: context,
                enableDrag: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                  ),
                ),
                builder: (_) {
                  return BlocBuilder<DiscTypeBloc, DiscTypeState>(
                    builder: (_, state) {
                      if (state is DiscTypeLoadedState) {
                        return SafeArea(
                          child: SizedBox(
                            height: (SizeConfig.screenHeight * .75).h,
                            child: RefreshIndicator(
                              onRefresh: () async {
                                context
                                    .read<DiscTypeBloc>()
                                    .add(FetchDiscTypeFromAPI());
                              },
                              child: ListView.separated(
                                itemCount: state.discTypes.length,
                                separatorBuilder: (_, index) {
                                  return const Divider(
                                    thickness: 1,
                                    color: Color(0xFFBDBDBD),
                                  );
                                },
                                itemBuilder: (_, index) => ListTile(
                                  title:
                                      Text(state.discTypes[index].description),
                                  selected:
                                      state.discTypes[index].description ==
                                          _discountTypeController.text,
                                  selectedColor: Constant.onSelectedColor,
                                  onTap: () {
                                    _discountTypeController.text =
                                        state.discTypes[index].description;
                                    context.read<CheckOutBloc>().add(
                                          DiscTypeCodeChange(
                                            state.discTypes[index].code,
                                          ),
                                        );
                                    AutoRouter.of(context).pop();
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return SizedBox(
                        height: (SizeConfig.screenHeight * .5).h,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          SizedBox(
            height: 15.h,
          ),
          DeliveryDateField(
            controller: _dateTimeController,
            dateFormat: dateFormat,
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _dateTimeController.clear();
              },
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          RemarksField(
            controller: _orderNotes,
          ),
        ],
      ),
    );
  }
}

class RemarksField extends StatelessWidget {
  final TextEditingController _controller;

  const RemarksField({
    Key? key,
    required TextEditingController controller,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textInputAction: TextInputAction.newline,
      controller: _controller,
      labelText: 'Order Notes',
      minLines: 3,
      maxLines: 6,
      textAlign: TextAlign.left,
      prefixIcon: const Icon(Icons.note_add),
      suffixIcon: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          _controller.clear();
        },
      ),
      onChanged: (value) {
        context.read<CheckOutBloc>().add(CheckOutNotesChange(value));
      },
    );
  }
}

class DeliveryDateField extends StatelessWidget {
  final TextEditingController _controller;
  final DateFormat _dateFormat;
  final Widget? _suffixIcon;

  const DeliveryDateField({
    Key? key,
    required TextEditingController controller,
    required DateFormat dateFormat,
    Widget? suffixIcon,
  })  : _controller = controller,
        _dateFormat = dateFormat,
        _suffixIcon = suffixIcon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textInputAction: TextInputAction.next,
      controller: _controller,
      labelText: 'Delivery Date*',
      readOnly: true,
      onTap: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(2018, 3, 5),
          maxTime: DateTime(2100, 12, 31),
          onConfirm: (date) {
            _controller.text = _dateFormat.format(date);
            // _postBody['dateDelivery'] = date.toIso8601String();
            context
                .read<CheckOutBloc>()
                .add(DeliveryDateChange(date.toIso8601String()));
          },
          currentTime: DateTime.now(),
          locale: LocaleType.en,
        );
      },
      prefixIcon: const Icon(Icons.calendar_today),
      suffixIcon: _suffixIcon,
    );
  }
}
