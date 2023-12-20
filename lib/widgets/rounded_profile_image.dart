import 'package:flutter/material.dart';

class RoundedProfileImage extends StatelessWidget {
  const RoundedProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 45,
        height: 45,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Image.asset(
          "assets/images/user.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
