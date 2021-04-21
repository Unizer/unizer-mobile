import 'package:flutter/material.dart';
import 'package:unizer/connector.dart';

class UnizerCardWidget extends StatelessWidget {
  const UnizerCardWidget({Key? key, this.image, this.name, this.date})
      : super(key: key);

  final String? image;
  final String? name;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipOval(
                child: Image.asset(
                  image!,
                  width: 70.0,
                  height: 70.0,
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name!,
                      style: kH1.copyWith(color: UniColors.blue),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          BoxIcons.bxs_group,
                          color: UniColors.subheader,
                          size: kH5TextSize + 2,
                        ),
                        SizedBox(
                          width: kTextFieldVerticalSpace,
                        ),
                        Text(
                          'Unizer sinds',
                          style: kH5,
                        ),
                        SizedBox(
                          width: kTextFieldVerticalSpace,
                        ),
                        Text(
                          date!,
                          style: kH5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              BoxIcons.bx_message,
              color: UniColors.buttonGreen,
              size: 22.0,
            ),
          ),
        ],
      ),
    );
  }
}
