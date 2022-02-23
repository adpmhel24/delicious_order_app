import 'package:delicious_ordering_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _expanded ? 650 : 150,
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
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        '${widget.order.id}',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: const Color(0xFF632626),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      Text(
                        'Transaction Date: ',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        DateFormat('MM/dd/yyyy').format(widget.order.transdate),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: const Color(0xFF632626),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
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
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: const Color(0xFF632626),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
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
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: const Color(0xFF632626),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Order Status: ',
                      ),
                      Text(
                        widget.order.getOrderStatus(),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: const Color(0xFF632626),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
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
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded ? 500 : 0,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                                  .bodyText2!
                                  .copyWith(
                                      color: const Color(0xFF632626),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
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
                                  .bodyText2!
                                  .copyWith(
                                      color: const Color(0xFF632626),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(thickness: 1),
                        ...widget.order.rows!
                            .map(
                              (prod) => Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0,
                                        color: Colors.lightBlue.shade900),
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      // flex: 2,
                                      child: SizedBox(
                                        width:
                                            (SizeConfig.screenWidth - 10) * .60,
                                        child: Text(
                                          prod['item_code'],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: SizedBox(
                                        width:
                                            (SizeConfig.screenWidth - 10) * .40,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Quantity: ${formatStringToDecimal(
                                                prod['quantity'].toString(),
                                              )}',
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              'Price: ${formatStringToDecimal(
                                                prod['unit_price'].toString(),
                                                hasCurrency: true,
                                              )}',
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              "Discount: ${prod['discprcnt']}%",
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 179, 43, 33),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              "Subtotal: ${formatStringToDecimal(
                                                prod['subtotal'].toString(),
                                                hasCurrency: true,
                                              )}",
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        const Divider(thickness: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Subtotal',
                            ),
                            Text(
                              formatStringToDecimal(
                                (widget.order.doctotal -
                                        widget.order.delfee -
                                        widget.order.otherfee)
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
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order Total',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              formatStringToDecimal(
                                widget.order.doctotal.toString(),
                                hasCurrency: true,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.bold),
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
