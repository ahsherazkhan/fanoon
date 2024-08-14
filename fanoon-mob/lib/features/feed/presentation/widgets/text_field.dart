import 'package:flutter/material.dart';

import '../../../../app/utils/dynamic_size.dart';

class ReuseableField extends StatelessWidget {
  final String name;
  final String? leading;
  final IconData? trailing;
  final bool isSmall;

  const ReuseableField(
      {required this.name,
      Key? key,
      this.leading,
      this.trailing,
      this.isSmall = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon? leadingIcon;
    switch (leading) {
      case 'email':
        leadingIcon = Icon(
          Icons.email,
          color: Theme.of(context).primaryColor,
        );
        break;
      case 'password':
        leadingIcon = Icon(
          Icons.visibility_off,
          color: Theme.of(context).primaryColor,
        );
        break;
    }

    return SizedBox(
      width: isSmall
          ? SizeConfig.screenWidth! * 0.4
          : SizeConfig.screenWidth! * 0.7,
      height: isSmall
          ? SizeConfig.screenHeight! * 0.05
          : SizeConfig.screenHeight! * 0.1,
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(
            trailing,
            size: 15,
          ),
          contentPadding: const EdgeInsets.only(left: 15, top: 5),
          border: OutlineInputBorder(
            //gapPadding: 5,
            borderRadius: BorderRadius.circular(25),
          ),
          prefixIconColor: Colors.purple,
          filled: true,
          hintStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontSize: 12),
          hintText: name,
          fillColor: Theme.of(context).backgroundColor,
          prefixIcon: leadingIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(width: 1, color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.red, //of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
