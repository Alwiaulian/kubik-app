import 'package:flutter/material.dart';
import 'package:kubik/ui/theme/theme.dart';

class ConfirmDialog extends StatelessWidget {
  final String bodyText;
  final Function yesPress;
  final Function noPress;

  const ConfirmDialog({
    Key? key,
    required this.bodyText,
    required this.noPress,
    required this.yesPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withAlpha(200),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * .8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          bodyText,
                          style: AppTextStyle.regularTextStyle,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  noPress;
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.grey.withOpacity(0.5),
                                ),
                                child: Text(
                                  'No',
                                  style: AppTextStyle.boldTextStyle
                                      .copyWith(color: Colors.blueAccent),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  yesPress;
                                },
                                child: Text(
                                  'Yes',
                                  style: AppTextStyle.boldTextStyle
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
