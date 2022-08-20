import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_distributor/controllers/getX/do_mission_getX_controller.dart';
import 'package:mission_distributor/controllers/getX/mission_getX_controller.dart';
import 'package:mission_distributor/controllers/getX/payment_gateway_getX_controller.dart';
import 'package:mission_distributor/core/res/assets.dart';
import 'package:mission_distributor/core/res/routes.dart';
import 'package:mission_distributor/models/network_link.dart';

import '../../../core/res/mission_distributor_colors.dart';
import '../../../core/widgets/MyElevatedButton.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late double width;
  late double height;
  double buttonHeight = 803 / 20;

  final Uri _url = Uri.parse('https://flutter.dev');
  bool isGoButtonVisible = true;

  TextStyle textStyle = const TextStyle(
    color: MissionDistributorColors.primaryColor,
    fontSize: 15,
  );

  final PaymentGatewayGetXController _paymentGatWayGetXController =
      Get.put(PaymentGatewayGetXController());

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MissionDistributorColors.secondaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsetsDirectional.only(start: 10),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
              size: 18,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Wallet',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: MissionDistributorColors.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            buttonHeight = height / 18;
          } else {
            buttonHeight = height / 8;
          }
          return Obx(() => ListView(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(Assets.wallet1Image),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(top: height / 6),
                        height: height / 1.3,
                        alignment: AlignmentDirectional.topCenter,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              MissionDistributorColors.primaryColor,
                              MissionDistributorColors.thirdColor,
                            ],
                          ),
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(69),
                            topEnd: Radius.circular(19),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // SizedBox(height: height / 15.43),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     MyElevatedButton(
                            //       onPressed: () async {
                            //         Navigator.pushNamed(context, Routes.walletEarningScreen);
                            //       },
                            //       child: const Text(
                            //         'My Earnings',
                            //         style: TextStyle(
                            //           fontSize: 18,
                            //           fontWeight: FontWeight.w300,
                            //         ),
                            //       ),
                            //       height: buttonHeight,
                            //       width: width / 2.36,
                            //       borderRadiusGeometry: BorderRadius.circular(27),
                            //       borderSide: const BorderSide(
                            //         color: Colors.white,
                            //         width: 2,
                            //       ),
                            //     ),
                            //     SizedBox(width: width / 90),
                            //     MyElevatedButton(
                            //       onPressed: () async {
                            //         Navigator.pushNamed(context, Routes.walletTransactionScreen);
                            //       },
                            //       child: const Text(
                            //         'Transactions',
                            //         style: TextStyle(
                            //           fontSize: 18,
                            //           fontWeight: FontWeight.w300,
                            //           color: MissionDistributorColors.primaryColor,
                            //         ),
                            //       ),
                            //       height: buttonHeight,
                            //       width: width / 2.36,
                            //       borderRadiusGeometry: BorderRadius.circular(20),
                            //       gradient: const LinearGradient(
                            //         colors: [
                            //           Colors.white,
                            //           Colors.white,
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: height / 20),
                            const Text(
                              'Total Earnings',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '\$ ${MissionGetXController.to.money}',
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: height / 30),
                            const Text(
                              'Total Coins',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              MissionGetXController.to.points.toString(),
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: height / 30),
                            const Text(
                              'Select Your Payout Option!!',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: height / 30),
                            SizedBox(
                              height: height / 5,
                              child: ListView.builder(
                                itemCount: _paymentGatWayGetXController
                                    .paymentGatWays.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(top: height / 50),
                                    width: width / 2,
                                    height: height / 20,
                                    child: _paymentGatWayGetXController
                                        .paymentGatWays.isNotEmpty
                                        ? Image.network(
                                      NetworkLink(
                                          link:
                                          _paymentGatWayGetXController
                                              .paymentGatWays[
                                          index]
                                              .image ??
                                              '')
                                          .link,
                                    )
                                        : Image.asset(Assets.payTmWalletImage),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: height / 30),
                            MyElevatedButton(
                              onPressed: () async {
                                Navigator.pushNamed(
                                    context, Routes.statementsScreen);
                              },
                              child: const Text(
                                'Statements',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              height: buttonHeight,
                              width: width / 2.2,
                              borderRadiusGeometry: BorderRadius.circular(27),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ));
        },
      ),
    );
  }
}
