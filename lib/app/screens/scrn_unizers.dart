import 'package:flutter/material.dart';
import 'package:unizer/connector.dart';

class UnizerScreen extends StatefulWidget {
  static const String screenID = 'unizers';

  @override
  _UnizerScreenState createState() => _UnizerScreenState();
}

class _UnizerScreenState extends State<UnizerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainTitleBar(
        title: tr('lbl_unizers'),
      ),
      drawer: LeftMenu(),
      body: Container(
        decoration: kBoxScreenDecoration,
        constraints: BoxConstraints.expand(),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                UniInfoBox(
                  screenID: UnizerScreen.screenID,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          tr('msg_unizer-home-info'),
                          style: kH2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: kTextFieldVerticalSpace),
                        child: UniOutlineButton(
                          icon: BoxIcons.bx_bulb,
                          color: UniColors.buttonGreen,
                          topMargin: 10.0,
                          label: tr('btn_invite-more-friends'),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                UnizerCardWidget(
                  image: 'images/Annebeth.jpg',
                  name: 'Annebeth Broer-van Gent',
                  date: '25 aug 2018',
                ),
                UnizerCardWidget(
                  image: 'images/Karel.png',
                  name: 'J Karel Broer',
                  date: '12 mrt 2010',
                ),
                UnizerCardWidget(
                  image: 'images/Anthon.jpg',
                  name: 'Anthon Geersing',
                  date: '1 jan 2019',
                ),
                UnizerCardWidget(
                  image: 'images/Kars.jpeg',
                  name: 'Kars Zijlstra',
                  date: '1 jan 2019',
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomBar(),
    );
  }
}
