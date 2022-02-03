import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/utils/currency_formater.dart';
import '/data/models/models.dart';

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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _expanded ? 500 : 150,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              // title:
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Text(
                        'Order #: ',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        '${widget.order.id}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: const Color(0xFF632626),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      Text(
                        'Transaction Date: ',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        DateFormat('MM/dd/yyyy').format(widget.order.transdate),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: const Color(0xFF632626),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Delivery Date: ',
                      ),
                      Text(
                        DateFormat('MM/dd/yyyy')
                            .format(widget.order.deliveryDate),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: const Color(0xFF632626),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Customer: ',
                      ),
                      Text(
                        '${widget.order.custCode}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: const Color(0xFF632626),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
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
              height: _expanded ? 380 : 0,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Wrap(
                          children: [
                            const Text(
                              'Delivery Address: ',
                            ),
                            Text(
                              '${widget.order.address}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: const Color(0xFF632626),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            const Text(
                              'Remarks: ',
                            ),
                            Text(
                              '${widget.order.remarks}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: const Color(0xFF632626),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
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
                              'Other Fee',
                            ),
                            Text(
                              formatStringToDecimal(
                                widget.order.otherfee.toString(),
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
