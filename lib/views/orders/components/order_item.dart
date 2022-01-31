import 'package:delicious_ordering_app/utils/currency_formater.dart';

import '/data/models/models.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final OrderModel order;

  const OrderItem(this.order, {Key? key}) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    var deviceInfo = MediaQuery.of(context);
    var width = deviceInfo.size.width;
    var height = deviceInfo.size.height;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _expanded
          ? min((20 * 20) + (widget.order.rows!.length) * 39, 800)
          : 200,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              // title:
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Order #: ',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        '${widget.order.id}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Transaction Date: ',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        DateFormat('MM/dd/yyyy').format(widget.order.transdate),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Delivery Date: ',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        DateFormat('MM/dd/yyyy')
                            .format(widget.order.deliveryDate),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Customer: ',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        '${widget.order.custCode}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  Text(
                    'Delivery Address : ${widget.order.address}',
                    style: TextStyle(
                      fontSize: (height - width) * .03,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      'Remarks : ${widget.order.remarks}',
                      style: TextStyle(
                        fontSize: (height - width) * .03,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded
                  ? min((7 * 20) + (widget.order.rows!.length) * 39, 700)
                  : 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const Divider(thickness: 1),
                        ...widget.order.rows!
                            .map(
                              (prod) => Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: deviceInfo.size.width * .02),
                                    padding: EdgeInsets.all(
                                        deviceInfo.size.width * .012),
                                    child: SizedBox(
                                      width: deviceInfo.size.width * .350,
                                      child: Text(
                                        prod['item_code'],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: deviceInfo.size.width * .02),
                                    padding: EdgeInsets.all(
                                        deviceInfo.size.width * .012),
                                    child: SizedBox(
                                      width: deviceInfo.size.width * .2,
                                      child: Text(
                                        '${formatStringToDecimal(
                                          prod['quantity'].toString(),
                                        )} x ${formatStringToDecimal(
                                          prod['unit_price'].toString(),
                                          hasCurrency: true,
                                        )}',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: deviceInfo.size.width * .02),
                                    padding: EdgeInsets.all(
                                        deviceInfo.size.width * .012),
                                    child: SizedBox(
                                      width: deviceInfo.size.width * .17,
                                      child: Text(
                                        formatStringToDecimal(
                                          prod['linetotal'].toString(),
                                          hasCurrency: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                        const Divider(thickness: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount',
                            ),
                            Text(
                              formatStringToDecimal(
                                (widget.order.doctotal - widget.order.delfee)
                                    .toString(),
                                hasCurrency: true,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Delivery Fee',
                            ),
                            Text(
                              formatStringToDecimal(
                                widget.order.delfee.toString(),
                                hasCurrency: true,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Net Amount',
                            ),
                            Text(
                              formatStringToDecimal(
                                widget.order.doctotal.toString(),
                                hasCurrency: true,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  //
                  // Flexible(
                  //   child: ,
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
