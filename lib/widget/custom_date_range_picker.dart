import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

customDateRangePicker({
  required BuildContext context,
  required TextEditingController startDateController,
  required TextEditingController endDateController,
  PickerDateRange? initialDateRange,
  required Function onSubmit,
}) {
  showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .5,
          child: SfDateRangePicker(
            headerHeight: 60,
            headerStyle: const DateRangePickerHeaderStyle(
              backgroundColor: Color.fromARGB(255, 52, 221, 57),
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            startRangeSelectionColor: Colors.lightGreen,
            endRangeSelectionColor: Colors.orangeAccent,
            selectionMode: DateRangePickerSelectionMode.range,
            // onSelectionChanged:
            onSubmit: (value) {
              if (value is PickerDateRange) {
                final DateTime rangeStartDate = value.startDate!;
                final DateTime rangeEndDate = value.endDate ?? value.startDate!;
                startDateController.text =
                    DateFormat('MM/dd/yyyy').format(rangeStartDate);
                endDateController.text =
                    DateFormat('MM/dd/yyyy').format(rangeEndDate);
                onSubmit();
              }
            },
            onCancel: () {
              Navigator.of(context).pop();
            },
            showActionButtons: true,
            initialSelectedRange: initialDateRange ??
                PickerDateRange(
                  DateTime.now(),
                  DateTime.now().add(const Duration(days: 4)),
                ),
          ),
        ),
      );
    },
  );
}
