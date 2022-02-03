import 'package:delicious_ordering_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '/widget/custom_error_dialog.dart';
import '/data/repositories/repositories.dart';
import '/global_bloc/ph_location_bloc/province_bloc/bloc.dart';
import '/widget/custom_choices_modal.dart';
import '/widget/custom_text_field.dart';

provinceModalSelection({
  required BuildContext context,
  required PhLocationRepo phLocationRepo,
  required TextEditingController provinceController,
  Widget? suffixIcon,
}) {
  var heightSized = MediaQuery.of(context).size.height;
  return CustomFieldModalChoices(
    controller: provinceController,
    onTap: () {
      context.read<ProvinceBloc>().add(FetchProvinceFromLocal());
      showMaterialModalBottomSheet(
        context: context,
        enableDrag: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
        ),
        builder: (_) => BlocConsumer<ProvinceBloc, ProvinceState>(
          listener: (_, state) {
            if (state is ProvinceErrorState) {
              customErrorDialog(context, state.message);
            }
          },
          builder: (_, state) {
            if (state is ProvinceLoadedState) {
              return SafeArea(
                child: SizedBox(
                  height: (heightSized * .75).h,
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
                              context.read<ProvinceBloc>().add(
                                    SearchProvinceByKeyword(value),
                                  );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 200));
                            context
                                .read<ProvinceBloc>()
                                .add(FetchProvinceFromApi());
                          },
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.provinces.length,
                            itemBuilder: (_, index) {
                              return ListTile(
                                title: Text(state.provinces[index].name!),
                                selectedColor: Constant.onSelectedColor,
                                selected: provinceController.text ==
                                    state.provinces[index].name!,
                                onTap: () {
                                  provinceController.text =
                                      state.provinces[index].name!;

                                  phLocationRepo.selectedProvinceCode = {
                                    "code": state.provinces[index].code!,
                                    "isDistrict":
                                        state.provinces[index].isDistrict ??
                                            false
                                  };

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
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ProvinceLoadingState) {
              return SizedBox(
                height: (heightSized * .75).h,
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
    labelText: 'Province',
    prefixIcon: const Icon(LineIcons.city),
    suffixIcon: suffixIcon,
  );
}
