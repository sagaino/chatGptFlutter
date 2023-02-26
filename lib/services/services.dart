import 'package:flutter/material.dart';
import 'package:inogpt/constants/constants.dart';
import 'package:inogpt/widgets/drop_down.dart';
import 'package:inogpt/widgets/text_widget.dart';

class Services {
  static Future<void> showModelSheet({
    required BuildContext context,
  }) async {
    await showModalBottomSheet(
      backgroundColor: scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Flexible(
                child: TextWidget(
                  label: "Chosen Model:",
                  fontSize: 16,
                ),
              ),
              Flexible(
                flex: 2,
                child: ModelsDropDownWidget(),
              ),
            ],
          ),
        );
      },
    );
  }
}
