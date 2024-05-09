import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


import '../components/RFHotelListComponent.dart';
import '../components/RFPremiumServiceComponent.dart';
import '../models/RoomFinderModel.dart';
import '../utils/RFColors.dart';
import '../utils/RFDataGenerator.dart';
import '../utils/RFWidget.dart';

class RFRecentlyViewedScreen extends StatelessWidget {
  final List<RoomFinderModel> hotelListData = hotelList();
  final bool showHeight = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, showLeadingIcon: false, title: 'Recently Viewed', roundCornerShape: true, appBarHeight: 80),
      body: SingleChildScrollView(
        child: Column(
          children: [
            24.height,
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: hotelListData.length,
              itemBuilder: (BuildContext context, int index) {
                return RFHotelListComponent(hotelData: hotelListData[index], showHeight: true);
              },
            ),
            Container(
              margin: EdgeInsets.all(16),
              decoration: boxDecorationWithRoundedCorners(backgroundColor: rf_selectedCategoryBgColor),
              padding: EdgeInsets.all(16),
              child: RFPremiumServiceComponent(),
            ),
          ],
        ),
      ),
    );
  }
}
