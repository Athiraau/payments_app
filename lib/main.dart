import 'package:flutter/material.dart';
import 'package:payments_application/features/others/controller/others_controller.dart';
import 'package:payments_application/features/otp_based/controller/opt_based_controller.dart';
import 'package:payments_application/features/payments/controller/payments_controller.dart';
import 'package:payments_application/features/payments/view/report/imps_inquiry/controller/imps_inquiry_controller.dart';
import 'package:payments_application/features/sbi/controller/sbi_controller.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'package:url_strategy/url_strategy.dart';
import 'features/bank_reconcilation/controller/bank_reco_controller.dart';
import 'features/bread_crumbs/controller/breadcrumbs_controller.dart';
import 'features/drawer/controller/drawer_controller.dart';
import 'features/home/controller/home_controller.dart';
import 'features/payments/view/report/payment_report/controlller/payment_report_controller.dart';
import 'features/payments/view/report/payment_status/controller/payment_status_controller.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => SliderProvider()),
        ChangeNotifierProvider(create: (_) => BreadCrumbsProvider()),
        ChangeNotifierProvider(create: (_) => PaymentsProvider()),
        ChangeNotifierProvider(create: (_) => OthersProvider()),
        ChangeNotifierProvider(create: (_) => SbiProvider()),
        ChangeNotifierProvider(create: (_) => OtpBasedProvider()),
        ChangeNotifierProvider(create: (_) => BankRecoProvider()),
        ChangeNotifierProvider(create: (_) => PaymentReportProvider()),
        ChangeNotifierProvider(create: (_) => PaymentStatusProvider()),
        ChangeNotifierProvider(create: (_) => ImpsInquiryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
