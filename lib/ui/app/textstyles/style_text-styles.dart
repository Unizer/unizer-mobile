import 'package:Unizer/packages.dart';

const InputDecoration kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.only(
    bottom: 3.0,
  ),
  hintText: '',
  hintStyle: TextStyle(
    color: UniColors.hintText,
    fontSize: kHintTextSize,
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      width: kDefaultBorderSize,
      color: UniColors.underlineBorder,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      width: kDefaultBorderSize,
      color: UniColors.underlineBorder,
    ),
  ),
);

const TextStyle kDefaultTextField = TextStyle(
  fontSize: kBodyTextSize,
  color: UniColors.bodyText,
  fontWeight: FontWeight.w400,
);

const TextStyle kH1 = TextStyle(
  fontSize: kH1TextSize,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
  color: UniColors.h1,
);

const TextStyle kH2 = TextStyle(
  fontSize: kH2TextSize,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  color: UniColors.h2,
);

const TextStyle kFooterText = TextStyle(
  fontSize: kFooterTextSize,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w100,
  color: UniColors.footer,
);

const TextStyle kButtonText = TextStyle(
  fontSize: kButtonTextSize,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
  color: Colors.white,
  letterSpacing: 0.5,
);

const TextStyle kLinkText = TextStyle(
  fontSize: kLinkTextSize,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  color: UniColors.linkText,
);

const TextStyle kTopMenubarTitle = TextStyle(
  fontSize: kH1TextSize,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
  color: UniColors.h2,
);
