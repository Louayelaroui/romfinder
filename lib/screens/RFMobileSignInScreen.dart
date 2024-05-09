import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/RFCommonAppComponent.dart';
import '../utils/RFColors.dart';
import '../utils/RFString.dart';
import '../utils/RFWidget.dart';
import '../utils/country_code_picker.dart';
import 'RFEmailSignInScreen.dart';
import 'RFResetPasswordScreen.dart';
import 'RFSignUpScreen.dart';


class RFMobileSignIn extends StatefulWidget {
  @override
  _RFMobileSignInState createState() => _RFMobileSignInState();
}

class _RFMobileSignInState extends State<RFMobileSignIn> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    // setStatusBarColor(rf_primaryColor, statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RFCommonAppComponent(
          title: RFAppName,
          subTitle: RFAppSubTitle,
          cardWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Mobile Number', style: boldTextStyle(size: 18)),
              16.height,
              Text(
                'Please enter your phone number. We will send you 4-digit code to verify your account.',
                style: primaryTextStyle(),
                maxLines: 4,
                textAlign: TextAlign.center,
              ).flexible(),
              16.height,
              Container(
                padding: EdgeInsets.only(left: 15),
                decoration: boxDecoration(showShadow: false, bgColor: context.cardColor, radius: 8, color: context.dividerColor),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CountryCodePicker(onChanged: print, padding: EdgeInsets.all(0), showFlag: false),
                    Container(
                      height: 25.0,
                      width: 1.0,
                      color: context.dividerColor,
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(border: InputBorder.none, hintText: "Phone Number"),
                      onChanged: (value) {},
                    ).expand(),
                  ],
                ),
              ),
              24.height,
              AppButton(
                color: rf_primaryColor,
                child: Text('Send Code', style: boldTextStyle(color: white)),
                width: context.width(),
                elevation: 0,
                onTap: () {
                  RFEmailSignInScreen().launch(context);
                },
              ),
              8.height,
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    child: Text("Reset Password?", style: primaryTextStyle()),
                    onPressed: () {
                      RFResetPasswordScreen().launch(context);
                    }),
              ),
            ],
          ),
          subWidget: socialLoginWidget(
            context,
            title1: "New Member? ",
            title2: "Sign up Here",
            callBack: () {
              RFSignUpScreen().launch(context);
            },
          ),
        ),
      ),
    );
  }
}
BoxDecoration boxDecoration({double radius = 2, Color color = Colors.transparent, Color? bgColor, var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ,
    boxShadow: showShadow ? defaultBoxShadow(shadowColor: shadowColorGlobal) : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}