import 'package:delicious_ordering_app/utils/constant.dart';
import 'package:delicious_ordering_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '/global_bloc/ph_location_bloc/brgy_bloc/bloc.dart';
import '/data/repositories/repositories.dart';
import '/widget/custom_choices_modal.dart';
import '/widget/custom_error_dialog.dart';
import '/widget/custom_text_field.dart';

brgyModalSelection({
  required BuildContext context,
  required PhLocationRepo phLocationRepo,
  required TextEditingController brgyController,
}) {
  var heightSized = MediaQuery.of(context).size.height;
  return CustomFieldModalChoices(
    controller: brgyController,
    labelText: 'Barangay',
    onTap: () {
      context.read<BrgyBloc>().add(FetchBrgyFromApi());
      showMaterialModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
        ),
        builder: (_) => BlocConsumer<BrgyBloc, BrgyState>(
          listener: (_, state) {
            if (state is BrgyErrorState) {
              customErrorDialog(context, state.message);
            }
          },
          builder: (_, state) {
            if (state is BrgyLoadedState) {
              return SafeArea(
                child: SizedBox(
                  height: (SizeConfig.screenHeight * .75).h,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                          child: CustomTextField(
                            labelText: 'Search by keyword',
                            onChanged: (value) {
                              context.read<BrgyBloc>().add(
                                    SearchBrgyByKeyword(value),
                                  );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.brgys.length,
                          itemBuilder: (_, index) {
                            return ListTile(
                              title: Text(state.brgys[index].name),
                              selectedColor: Constant.onSelectedColor,
                              selected: brgyController.text ==
                                  state.brgys[index].name,
                              onTap: () {
                                brgyController.text = state.brgys[index].name;

                                Navigator.of(context).pop();
                              },
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const Divider(
                              thickness: 1,
                              color: Color(0xFFBDBDBD),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is BrgyLoadingState) {
              return SizedBox(
                height: (SizeConfig.screenHeight * .75).h,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return SizedBox(
              height: (heightSized * .75).h,
              child: const Center(
                child: Text('No data!'),
              ),
            );
          },
        ),
      );
    },
    prefixIcon: const Icon(LineIcons.building),
    suffixIcon: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () async {
            context.read<BrgyBloc>().add(FetchBrgyFromApi());
            brgyController.clear();
          },
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            brgyController.clear();
          },
        ),
      ],
    ),
  );
}
