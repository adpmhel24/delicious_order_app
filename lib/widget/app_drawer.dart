import 'package:auto_route/auto_route.dart';
import '/router/router.gr.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/global_bloc/auth_bloc/bloc.dart';
import '/data/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final AuthRepository _authRepo = AppRepo.authRepository;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _createHeader(_authRepo),
          _createDrawerItem(
            icon: Icons.list_alt,
            text: 'Ordering',
            onTap: () {
              AutoRouter.of(context).popAndPush(const CreateOrderScreenRoute());
            },
          ),
          _createDrawerItem(
            icon: Icons.list_alt,
            text: 'My Orders',
            onTap: () {},
          ),
          _createDrawerItem(
            icon: Icons.list_alt_rounded,
            text: 'Orders For Dispo',
            onTap: () {},
          ),
          // _createDrawerItem(
          //   icon: Icons.sell,
          //   text: 'Orders',
          //   onTap: () {
          //     Get.offAllNamed(OrdersPage.routeName);
          //   },
          // ),
          // ExpansionTile(
          //   title: Text("Orders"),
          //   children: <Widget>[
          //     _createDrawerItem(
          //       icon: Icons.menu_open,
          //       text: 'Orders',
          //       onTap: () {
          //         // Get.offAndToNamed(SalesOrderPage.routeName);
          //       },
          //     ),
          //     _createDrawerItem(
          //       icon: Icons.pending,
          //       text: 'Orders',
          //       onTap: () {
          //         // Get.offAndToNamed(SalesOrderPage.routeName);
          //       },
          //     ),
          //   ],
          // ),
          _createDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              context.read<AuthBloc>().add(LoggedOut());
            },
          ),
        ],
      ),
    );
  }
}

Widget _createHeader(AuthRepository _authRepo) {
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    decoration: BoxDecoration(
      color: Colors.green[200],
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage('assets/images/empty_user.png'),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${_authRepo.currentUser.username}'),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            'Main Menu',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 15.sp,
            ),
          )
        ],
      ),
    ),
  );
}

Widget _createDrawerItem(
    {required IconData icon, required String text, GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
