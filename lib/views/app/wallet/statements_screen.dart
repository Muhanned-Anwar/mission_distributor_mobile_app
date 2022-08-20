import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_distributor/controllers/getX/payment_gateway_getX_controller.dart';
import 'package:mission_distributor/models/missions/transaction.dart';
import 'package:mission_distributor/models/payment/payout.dart';

import '../../../controllers/getX/do_mission_getX_controller.dart';
import '../../../controllers/getX/mission_getX_controller.dart';
import '../../../core/res/mission_distributor_colors.dart';
import '../../../core/res/routes.dart';
import '../../../core/widgets/MyElevatedButton.dart';

class StatementsScreen extends StatefulWidget {
  const StatementsScreen({Key? key}) : super(key: key);

  @override
  State<StatementsScreen> createState() => _StatementsScreenState();
}

class _StatementsScreenState extends State<StatementsScreen> {
  late double width;
  late double height;
  double buttonHeight = 803 / 20;

  List<Transaction> transactions = [
    Transaction(),
    Transaction(points: 160),
    Transaction(points: 200, title: 'Play Zone', status: 'Play Quiz'),
    Transaction(points: 200, title: 'Free Coins', status: 'Scratch Coin Win'),
    Transaction(points: 300, title: 'Paytm Redeem', status: 'REDEEM'),
    Transaction(),
    Transaction(points: 160),
    Transaction(points: 200, title: 'Play Zone', status: 'Play Quiz'),
    Transaction(points: 200, title: 'Free Coins', status: 'Scratch Coin Win'),
    Transaction(points: 300, title: 'Paytm Redeem', status: 'REDEEM'),
    Transaction(),
    Transaction(points: 160),
    Transaction(points: 200, title: 'Play Zone', status: 'Play Quiz'),
    Transaction(points: 200, title: 'Free Coins', status: 'Scratch Coin Win'),
    Transaction(points: 300, title: 'Paytm Redeem', status: 'REDEEM'),
  ];

  TextStyle textStyle = const TextStyle(
    color: MissionDistributorColors.primaryColor,
    fontSize: 15,
  );

  final PaymentGatewayGetXController _paymentGatewayGetXController =
      Get.put(PaymentGatewayGetXController());

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MissionDistributorColors.secondaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MissionDistributorColors.primaryColor,
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
              color: MissionDistributorColors.primaryColor,
              size: 18,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Statements',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
          return ListView(
            children: [
              SizedBox(height: height / 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyElevatedButton(
                    onPressed: () async {
                      // Navigator.pushNamed(context, Routes.rankScreen);
                    },
                    child: Text(
                      '${MissionGetXController.to.money} \$',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: MissionDistributorColors.primaryColor,
                      ),
                    ),
                    height: buttonHeight,
                    width: width / 2.36,
                    borderRadiusGeometry: BorderRadius.circular(27),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                    gradient: const LinearGradient(colors: [
                      Colors.white,
                      Colors.white,
                    ]),
                  ),
                  SizedBox(width: width / 90),
                  MyElevatedButton(
                    onPressed: () async {
                      // Navigator.pushNamed(context, Routes.statementsScreen);
                    },
                    child: Text(
                      MissionGetXController.to.points.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: MissionDistributorColors.primaryColor,
                      ),
                    ),
                    height: buttonHeight,
                    width: width / 2.36,
                    borderRadiusGeometry: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white,
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 32),
              GetX<PaymentGatewayGetXController>(
                builder: (controller) {
                  List<Payout> payouts = controller.payouts.value;
                  if(payouts.isNotEmpty){
                    return SizedBox(
                      height: height / 1.3,
                      child: ListView.builder(
                        itemCount: payouts.length,
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 15, vertical: height / 40),
                        itemBuilder: (context, index) {
                          return walletTransactionItem(context, index, payouts);
                        },
                      ),
                    );
                  }else{
                    return const Center(
                      child: Text('Not exist any statements',style: TextStyle(
                        fontSize: 16,
                        color: MissionDistributorColors.primaryColor,
                      ),),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget walletTransactionItem(BuildContext context, int index,List<Payout> payouts) {
    return Container(
      height: height / 10,
      margin: EdgeInsetsDirectional.only(bottom: height / 150),
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payouts[index].data ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      color: MissionDistributorColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: height / 100),
                  Row(
                    children: [
                      Text(
                        payouts[index].approved == '1'? 'approved':'Non approved',
                        style: const TextStyle(
                          fontSize: 12,
                          color: MissionDistributorColors.primaryColor,
                        ),
                      ),
                      Text(' - ', style: textStyle),
                      Text(
                        payouts[index].updatedAt.toString().substring(0,10),
                        style: const TextStyle(
                          fontSize: 12,
                          color: MissionDistributorColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Container(
                  width: width / 5,
                  height: height / 25.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MissionDistributorColors.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  margin: EdgeInsetsDirectional.only(start: width / 10.5),
                  alignment: Alignment.center,
                  child: Text(
                    '+ ${payouts[index].amount.toString()}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: MissionDistributorColors.primaryColor,
            thickness: 0.8,
          ),
        ],
      ),
    );
  }
}
