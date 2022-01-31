// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:intl/intl.dart';

// import 'package:delicious_ordering/data/models/models.dart';
// import 'package:delicious_ordering/presentation/pages/add_customer/bloc/bloc.dart';
// import 'package:delicious_ordering/presentation/widgets/custom_text_field.dart';

// class CustomerDetailsForm extends StatefulWidget {
//   const CustomerDetailsForm(
//       {Key? key, required List<CustomerDetailsModel> details})
//       : _details = details,
//         super(key: key);
//   final List<CustomerDetailsModel> _details;
//   @override
//   _CustomerDetailsFormState createState() => _CustomerDetailsFormState();
// }

// class _CustomerDetailsFormState extends State<CustomerDetailsForm> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _firstNameController = TextEditingController();
//   TextEditingController _middleInitialController = TextEditingController();
//   TextEditingController _lastNameController = TextEditingController();
//   TextEditingController _birthdateController = TextEditingController();
//   TextEditingController _landlineNumberController = TextEditingController();
//   TextEditingController _mobileNumberController = TextEditingController();
//   TextEditingController _addressController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();

//   DateFormat _dateFormat = DateFormat("MM/dd/yyyy");

//   Map<String, dynamic> _data = {};

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: Padding(
//         padding:
//             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 'Add Customer Details',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20.0,
//                     letterSpacing: 1.0,
//                     color: Colors.grey),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               CustomTextField(
//                 controller: _firstNameController,
//                 labelText: 'First Name',
//                 prefixIcon: Icon(Icons.person_add),
//               ),
//               CustomTextField(
//                 controller: _middleInitialController,
//                 labelText: 'Middle Name',
//                 prefixIcon: Icon(Icons.person_add),
//               ),
//               CustomTextField(
//                 controller: _lastNameController,
//                 labelText: 'Last Name',
//                 prefixIcon: Icon(Icons.person_add),
//               ),
//               TextFormField(
//                 textInputAction: TextInputAction.next,
//                 controller: _birthdateController,
//                 showCursor: false,
//                 readOnly: true,
//                 onTap: () {
//                   DatePicker.showDatePicker(
//                     context,
//                     showTitleActions: true,
//                     minTime: DateTime(1920, 1, 1),
//                     maxTime: DateTime(2100, 12, 31),
//                     onConfirm: (date) {
//                       _birthdateController.text = '${_dateFormat.format(date)}';
//                       _data['birthday'] = date.toIso8601String();
//                     },
//                     currentTime: DateTime.now(),
//                     locale: LocaleType.en,
//                   );
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Birthday',
//                   prefixIcon: Icon(Icons.calendar_today),
//                 ),
//               ),
//               CustomTextField(
//                 controller: _landlineNumberController,
//                 labelText: 'Landline',
//                 prefixIcon: Icon(Icons.phone),
//                 keyBoardType: TextInputType.phone,
//               ),
//               CustomTextField(
//                 controller: _mobileNumberController,
//                 labelText: 'Mobile Number',
//                 prefixIcon: Icon(Icons.phone_android),
//                 keyBoardType: TextInputType.phone,
//               ),
//               CustomTextField(
//                 controller: _addressController,
//                 labelText: 'Address',
//                 minLines: 3,
//                 maxLines: 5,
//                 prefixIcon: Icon(Icons.person_add),
//                 keyBoardType: TextInputType.multiline,
//               ),
//               CustomTextField(
//                 controller: _emailController,
//                 labelText: 'Email',
//                 prefixIcon: Icon(Icons.email),
//                 keyBoardType: TextInputType.emailAddress,
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   // Validate returns true if the form is valid, or false otherwise.
//                   if (_formKey.currentState!.validate()) {
//                     // If the form is valid, display a snackbar. In the real world,
//                     // you'd often call a server or save the information in a database.
//                     _data.addAll({
//                       'first_name': this._firstNameController.text,
//                       'middle_initial': this._middleInitialController.text,
//                       'last_name': this._lastNameController.text,
//                       'landline_number': this._landlineNumberController.text,
//                       'mobile_number': this._mobileNumberController.text,
//                       'address': this._addressController.text,
//                       'email': this._emailController.text,
//                     });
//                     widget._details.add(CustomerDetailsModel.fromJson(_data));
//                     context.read<AddCustomerBloc>()
//                       ..add(AddCustomerDetails(widget._details));
//                     Navigator.of(context).pop();
//                   }
//                 },
//                 child: const Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
