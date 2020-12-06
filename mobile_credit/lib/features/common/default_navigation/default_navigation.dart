import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_credit/features/common/utils/app_colors.dart';

class DefaultNavigation extends StatelessWidget {
  final String title;
  final bool isColorTitle;
  final bool isBackButton;
  
  DefaultNavigation(
      {this.title,
      this.isColorTitle = true, 
      this.isBackButton = true});

  build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isBackButton ? 
        IconButton(
          color: AppColors.primaryTextColor,
          icon: Image.asset('images/back.png'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ) : SizedBox.shrink(),
        Padding(
          padding: EdgeInsets.only(left: 24),
          child: Text(title,
              style: TextStyle(
                  fontSize: 30,
                  color: isColorTitle ? AppColors.primaryTextColor: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }
}

