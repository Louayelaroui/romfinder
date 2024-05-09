import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/RFPremiumServiceComponent.dart';
import '../utils/RFColors.dart';
import '../utils/RFImages.dart';
import '../utils/RFWidget.dart';

class RFAboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, showLeadingIcon: false, title: 'About Us', roundCornerShape: true, appBarHeight: 80),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            rfCommonCachedNetworkImage(rf_aboutUs, fit: BoxFit.cover, height: 150, width: context.width()),
            Container(
              decoration: boxDecorationRoundedWithShadow(8, backgroundColor: context.cardColor),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About the Company', style: boldTextStyle()),
                  8.height,
                  Text(" louay is her louay is her louay is her louay is her louay is her louay is her this is a long text  " , style: secondaryTextStyle()),
                  16.height,
                  Text('About the Members', style: boldTextStyle()),
                  8.height,
                  Text(
                    " louay is her louay is her louay is her louay is her louay is her louay is her this is a long text  " ,
                    style: secondaryTextStyle(),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 24),
              decoration: boxDecorationWithRoundedCorners(
                backgroundColor: rf_selectedCategoryBgColor,
              ),
              padding: EdgeInsets.all(16),
              child: RFPremiumServiceComponent(),
            ),
          ],
        ),
      ),
    );
  }
}


