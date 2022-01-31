import 'package:delicious_ordering_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../bloc/bloc.dart';

class CheckOutForm extends StatefulWidget {
  const CheckOutForm({Key? key}) : super(key: key);

  @override
  _CheckOutFormState createState() => _CheckOutFormState();
}

class _CheckOutFormState extends State<CheckOutForm> {
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _deliveryMethod = TextEditingController();
  final TextEditingController _paymentMethod = TextEditingController();
  final TextEditingController _orderNotes = TextEditingController();

  DateFormat dateFormat = DateFormat("MM/dd/yyyy");

  @override
  void dispose() {
    _deliveryMethod.dispose();
    _paymentMethod.dispose();
    _orderNotes.dispose();
    _dateTimeController.dispose();
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
              labelText: 'Delivery Methods',
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
              labelText: 'Payment Methods',
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
            height: 10.h,
          ),
          DeliveryDateField(
            controller: _dateTimeController,
            dateFormat: dateFormat,
          ),
          SizedBox(
            height: 10.h,
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

  const DeliveryDateField({
    Key? key,
    required TextEditingController controller,
    required DateFormat dateFormat,
  })  : _controller = controller,
        _dateFormat = dateFormat,
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
    );
  }
}
