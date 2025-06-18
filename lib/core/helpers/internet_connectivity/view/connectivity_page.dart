import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/config/styles/colors.dart';
import '../../../utils/shared/component/widgets/custom_button.dart';
import '../../../utils/shared/component/widgets/custom_text.dart';
import '../../../utils/shared/constant/assets_path.dart';
import '../../routes/app_route_path.dart';
import '../controller/internet_connectivity_provider.dart';

class ConnectivityPage extends StatefulWidget {
  const ConnectivityPage({Key? key}) : super(key: key);

  @override
  State<ConnectivityPage> createState() => _ConnectivityPageState();
}

class _ConnectivityPageState extends State<ConnectivityPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<ConnectivityProvider>(
      builder: (context, connectivityProvider, child) {
        if (connectivityProvider.isConnected) {
          Future.microtask(() => context.go(RoutesPath.home));
          return const SizedBox.shrink();
        }

        return Scaffold(
          body: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsPath.appBackground),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                width: size.width < 600
                    ? size.width * 0.65
                    : (size.width < 1024
                        ? size.width * 0.50
                        : size.width * 0.30),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: AppColor.dividerColor, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColor.dividerColor,
                      child: Icon(
                        Icons.warning_amber,
                        size: 25,
                        color: AppColor.drawerColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const CustomText(
                      text: "No internet connectivity",
                      fontSize: 18,
                      fontFamily: 'poppinsSemiBold',
                      color: AppColor.drawerColor,
                    ),
                    const SizedBox(height: 10),
                    const CustomText(
                      text: "Something went wrong, Please Login Again..!",
                      fontSize: 12,
                      fontFamily: 'poppinsRegular',
                      color: Colors.black,
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: 'Login',
                      txtColor: Colors.white,
                      btnColor: AppColor.drawerColor,
                      borderRadious: 8,
                      width: 60,
                      height: 25,
                      onPressed: () async {
                        const url =
                            'https://uatapp.manappuram.net/MaaPortal/login';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          Future.microtask(() => ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text('Could not launch URL'))));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
