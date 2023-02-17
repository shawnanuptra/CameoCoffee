import 'package:flutter/material.dart';
import '../util/constants.dart';

class PrimaryButton extends StatelessWidget {
  final void Function() onClick;
  final String text;

  const PrimaryButton({
    Key? key,
    required this.onClick,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kButtonMargin),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: onClick,
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white),
          ),
          style: TextButton.styleFrom(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(kButtonHeight)),
        ),
      ),
    );
  }
}


class SecondaryButton extends StatelessWidget {
  final void Function() onClick;
  final String text;

  const SecondaryButton({
    Key? key,
    required this.onClick,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: onClick,
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: kPrimaryColor),
          ),
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: kPrimaryColor, width: 1),
              minimumSize: const Size.fromHeight(50)),
        ),
      ),
    );
  }
}
