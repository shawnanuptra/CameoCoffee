import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../util/constants.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
  }) : super(key: key);

  final String name;
  final String description;
  final double price;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // todo: add menu item screen
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kMainScreenHorizontalPadding, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${name}'),
                      Text(
                          '${NumberFormat.simpleCurrency(locale: 'en-GB').format(price)}'),
                    ],
                  ),
                  Row(
                    children: [Text('${description}')],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpecialCard extends StatelessWidget {
  const SpecialCard({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 10, 5.0),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            text,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey,
        ),
      ),
    );
  }
}

class MenuCategory extends StatelessWidget {
  const MenuCategory({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(15),
            right: Radius.circular(15),
          ),
          border: Border.all(color: Colors.black87)),
    );
  }
}
