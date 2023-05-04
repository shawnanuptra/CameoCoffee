import 'package:coffee_cameo/model/menu_item_model.dart';
import 'package:coffee_cameo/util/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../screens/item_screen.dart';
import '../util/constants.dart';

class MenuListTile extends StatelessWidget {
  MenuListTile({
    Key? key,
    required this.item,
    this.onClick,
  }) : super(key: key);

  final MenuItem item;
  void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ItemScreen(item)));
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                    color: Colors.yellow[100]),
                child: Center(
                    child: SvgPicture.asset(
                        'assets/${item.name.toKebabCase()}.svg'))),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text('${item.name}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 18)),
                      ),
                      Text(
                          '${NumberFormat.simpleCurrency(locale: 'en-GB').format(item.price)}'),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: Text('${item.description}',
                              style: Theme.of(context).textTheme.bodySmall))
                    ],
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
  const SpecialCard({Key? key, required this.item}) : super(key: key);

  final MenuItem item;

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
            item.name,
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
