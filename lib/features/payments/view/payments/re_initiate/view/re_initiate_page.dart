import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../../../../core/helpers/encryption/encryption_value.dart';
import '../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../core/utils/shared/constant/assets_path.dart';
import '../../../../../bread_crumbs/view/bread_crumbs.dart';

class ReInitiatePage extends StatelessWidget {
  final String encryptedUserId; // Change to String to handle encrypted input
  final String encryptedUserName; // Change to String to handle encrypted input

  const ReInitiatePage({
    super.key,
    required this.encryptedUserId,
    required this.encryptedUserName,
  });

  @override
  Widget build(BuildContext context) {
    final decryptHelper = AppEncryptionHelper();

    // Decrypt values
    final userId = decryptHelper.decryptData(
      data: encryptedUserId,
        baseKey:EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString
    );

    final userName = decryptHelper.decryptData(
      data: encryptedUserName,
        baseKey:EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString
    );

    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsPath.appBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BreadCrumbs(
              title: 'Re-initiate',
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                width: size.width,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  border: Border.all(width: 1, color: AppColor.dividerColor),
                  borderRadius: BorderRadius.circular(8.0),
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
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {
                                context.pop();
                              },
                              icon: const Icon(
                                color: AppColor.drawerColor,
                                Icons.arrow_back,
                                size: 24,
                              )),
                        )
                      ],
                    ),
                    Center(
                      child: Text(
                        'Name: $userName, ID: $userId',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
