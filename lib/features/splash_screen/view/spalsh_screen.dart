import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:payments_application/core/utils/config/styles/colors.dart';
import 'package:payments_application/core/utils/shared/constant/assets_path.dart';
import 'package:provider/provider.dart';
import '../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../core/helpers/routes/app_route_name.dart';
import '../../home/controller/home_controller.dart';

class SplashScreen extends StatefulWidget {
  final String? session;
  final String? token;
  const SplashScreen({super.key, required this.session, required this.token});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false)
          .sessionApi(context: context);
    });
  }

  final decryptHelper = AppEncryptionHelper();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(color: AppColor.primaryColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: size.width,
            height: 300,
            child: Image.asset(AssetsPath.appLogo).animate().fade().slideY(
                duration: const Duration(milliseconds: 500),
                begin: 1,
                curve: Curves.easeInSine),
          ),
          const SizedBox(height: 20),
          const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: AppColor.drawerColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
