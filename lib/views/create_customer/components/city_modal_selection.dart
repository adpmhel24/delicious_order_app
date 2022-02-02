import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '/global_bloc/ph_location_bloc/city_bloc/bloc.dart';
import '/data/repositories/repositories.dart';
import '/views/create_customer/bloc/bloc.dart';
import '/widget/custom_choices_modal.dart';
import '/widget/custom_text_field.dart';

cityModalSelection({
  required BuildContext context,
  required PhLocationRepo phLocationRepo,
  required TextEditingController provinceController,
  required TextEditingController cityController,
  required TextEditingController municipalityController,
  required TextEditingController brgyController,
}) {
  return CustomFieldModalChoices(
    controller: cityController,
    labelText: 'City',
    onTap: () {
      context.read<CityBloc>().add(FetchCityFromApi());
      showMaterialModalBottomSheet(
        context: context,
        builder: (_) => BlocBuilder<CityBloc, CityState>(
          builder: (_, state) {
            if (state is CityLoadedState) {
              return SafeArea(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                        child: CustomTextField(
                          labelText: 'Search by keyword',
                          onChanged: (value) {
                            context.read<CityBloc>().add(
                                  SearchCityByKeyword(value),
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
                        itemCount: state.cities.length,
                        itemBuilder: (_, index) {
                          return ListTile(
                            title: Text(state.cities[index].name),
                            selectedColor: const Color(0xFFD67D3E),
                            selected:
                                cityController.text == state.cities[index].name,
                            onTap: () {
                              cityController.text = state.cities[index].name;

                              context
                                  .read<AddCustomerBloc>()
                                  .add(ChangeProvinceCityMunicipalityBrgy(
                                    province: provinceController,
                                    city: cityController,
                                    municipality: municipalityController,
                                    brgy: brgyController,
                                  ));

                              phLocationRepo.selectedCityCode =
                                  state.cities[index].code;

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
              );
            } else if (state is CityLoadingState) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * .5,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: const Center(
                child: Text('No data!'),
              ),
            );
          },
        ),
      );
    },
    prefixIcon: const Icon(LineIcons.city),
    suffixIcon: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () async {
            context.read<CityBloc>().add(FetchCityFromApi());
            cityController.clear();
          },
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            cityController.clear();
            phLocationRepo.selectedCityCode = '';
            context
                .read<AddCustomerBloc>()
                .add(ChangeProvinceCityMunicipalityBrgy(
                  province: provinceController,
                  city: cityController,
                  municipality: municipalityController,
                  brgy: brgyController,
                ));
          },
        ),
      ],
    ),
  );
}
