import 'package:delicious_ordering_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '/global_bloc/ph_location_bloc/city_municipality_bloc/bloc.dart';
import '/data/repositories/repositories.dart';
import '/widget/custom_choices_modal.dart';
import '/widget/custom_error_dialog.dart';
import '/widget/custom_text_field.dart';

cityMunicipalityModalSelection({
  required BuildContext context,
  required PhLocationRepo phLocationRepo,
  required TextEditingController cityMunicipalityController,
  Widget? suffixIcon,
}) {
  var heightSized = MediaQuery.of(context).size.height;
  return CustomFieldModalChoices(
    controller: cityMunicipalityController,
    labelText: 'City / Municipality',
    onTap: () {
      context.read<CityMunicipalityBloc>().add(FetchCityMunicipalityFromApi());
      showMaterialModalBottomSheet(
        enableDrag: false,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
        ),
        builder: (_) =>
            BlocConsumer<CityMunicipalityBloc, CityMunicipalityState>(
          listener: (context, state) {
            if (state is CityMunicipalityErrorState) {
              customErrorDialog(context, state.message);
            }
          },
          builder: (_, state) {
            if (state is CityMunicipalityLoadedState) {
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
                              context.read<CityMunicipalityBloc>().add(
                                    SearchCityMunicipalityByKeyword(value),
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
                                .read<CityMunicipalityBloc>()
                                .add(FetchCityMunicipalityFromApi());
                          },
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.citiesMunicipalities.length,
                            itemBuilder: (_, index) {
                              return ListTile(
                                title: Text(
                                    state.citiesMunicipalities[index].name),
                                selectedColor: Constant.onSelectedColor,
                                selected: cityMunicipalityController.text ==
                                    state.citiesMunicipalities[index].name,
                                onTap: () {
                                  cityMunicipalityController.text =
                                      state.citiesMunicipalities[index].name;

                                  phLocationRepo.selectedCityMunicipalityCode =
                                      state.citiesMunicipalities[index].code;

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
            } else if (state is CityMunicipalityLoadingState) {
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
    prefixIcon: const Icon(LineIcons.city),
    suffixIcon: suffixIcon,
  );
}
