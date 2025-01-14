import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payments_application/features/bank_reconcilation/view/bank_reconcilation.dart';
import 'package:payments_application/features/home/view/home_page.dart';
import 'package:payments_application/features/others/view/email/view/email_page.dart';
import 'package:payments_application/features/others/view/interest_certificate/view/interest_certificate.dart';
import 'package:payments_application/features/others/view/others_page.dart';
import 'package:payments_application/features/otp_based/view/otp_based_page.dart';
import 'package:payments_application/features/payments/view/payments/branch_imps_bank/view/branch_imps_page.dart';
import 'package:payments_application/features/payments/view/payments/bulk_reinitiate/view/bulk_reinitite_page.dart';
import 'package:payments_application/features/payments/view/payments/debit_advice_branch/view/advise_branch_page.dart';
import 'package:payments_application/features/payments/view/payments_page.dart';
import 'package:payments_application/features/payments/view/report/imps_inquiry/view/imps_inquiry.dart';
import 'package:payments_application/features/payments/view/report/neft_details/view/neft_details.dart';
import 'package:payments_application/features/payments/view/report/payment_ogl_report/view/payment_ogl_report.dart';
import 'package:payments_application/features/payments/view/report/payment_report/view/payment_report_page.dart';
import 'package:payments_application/features/payments/view/report/payment_status/view/payment_status.dart';
import 'package:payments_application/features/payments/view/report/payment_status/view/payment_status_report/view/payment_status_report.dart';
import 'package:payments_application/features/sbi/view/report/sbi_portal_report/view/sbi_portal_report.dart';
import 'package:payments_application/features/sbi/view/sbi/imps_switch_over/view/imps_switch_over.dart';
import 'package:payments_application/features/sbi/view/sbi/manuel_entry/view/manuel_entry.dart';
import 'package:payments_application/features/sbi/view/sbi_page.dart';
import 'package:payments_application/features/splash_screen/view/spalsh_screen.dart';
import 'package:provider/provider.dart';
import '../../../features/bank_reconcilation/view/bank_reconcilation/brs_mismatch_update/view/brs_mismatch_updart.dart';
import '../../../features/bank_reconcilation/view/bank_reconcilation/brs_updation/view/brs_updation.dart';
import '../../../features/bank_reconcilation/view/bank_reconcilation/brs_wrong_updation_reversal/view/brs_wrong_updation_reversal.dart';
import '../../../features/bank_reconcilation/view/bank_reconcilation/yes_bank_file_upload_fee_and_charges/view/yes_bank_file_upload_fee_and_charges.dart';
import '../../../features/bank_reconcilation/view/bank_reconcilation/yes_bank_neft_response_file_upload/view/yes_bank_neft_respoonse_file_upload.dart';
import '../../../features/bank_reconcilation/view/bank_reconcilation/yes_bank_statement_file_upload/view/yes_bank_statement_file_upload.dart';
import '../../../features/bank_reconcilation/view/ho_report/unreconciled_report_consolidated/view/unreconciled_report_consolidated.dart';
import '../../../features/bank_reconcilation/view/new_report/bank_statement/view/bank_statement.dart';
import '../../../features/bank_reconcilation/view/new_report/reconciled_report_consolidated/view/resonciled_report_conslidated.dart';
import '../../../features/bank_reconcilation/view/new_report/unreconciled_report_consolidated/view/unreconciled_report_consolidated.dart';
import '../../../features/bank_reconcilation/view/reports/bank_reconciled_report/view/bank_reconciled_report.dart';
import '../../../features/bank_reconcilation/view/reports/bank_statement_missing_report/view/bank_statement_missing_report.dart';
import '../../../features/bank_reconcilation/view/reports/bank_unreconciled_report/view/bank_unreconciled_report.dart';
import '../../../features/bank_reconcilation/view/reports/bank_unreconiled_consolidated_report/view/bank_unreconciled_consolidated_report.dart';
import '../../../features/bread_crumbs/controller/breadcrumbs_controller.dart';
import '../../../features/home/view/shell/main_shell.dart';
import '../../../features/otp_based/view/fund_transfer/approval/view/approval.dart';
import '../../../features/otp_based/view/fund_transfer/cgm_sgm_approval/view/cgm_sgm_approval.dart';
import '../../../features/otp_based/view/fund_transfer/crn_updation/view/crn_updation.dart';
import '../../../features/otp_based/view/fund_transfer/mis_file_upload/view/mis_file_upload.dart';
import '../../../features/otp_based/view/payments/beneficiary_download/view/beneficiary_download.dart';
import '../../../features/otp_based/view/payments/beneficiary_upload/view/beneficiary_upload.dart';
import '../../../features/otp_based/view/payments/remove_registration/view/remove_registration.dart';
import '../../../features/otp_based/view/payments/verification/view/verification.dart';
import '../../../features/otp_based/view/reports/crn_excel_report/view/crn_excel_report.dart';
import '../../../features/otp_based/view/reports/live_employee_report/view/live_employee_report.dart';
import '../../../features/otp_based/view/reports/registration_report/view/registration_report.dart';
import '../../../features/otp_based/view/reports/transaction_report/view/transaction_report.dart';
import '../../../features/payments/view/payments/advise_block/view/advise_block_page.dart';
import '../../../features/payments/view/payments/payment_debit_advise/view/payment_advise_page.dart';
import '../../../features/payments/view/payments/re_approval/view/re_approval_page.dart';
import '../../../features/payments/view/payments/re_initiate/view/re_initiate_page.dart';
import '../../../features/payments/view/payments/re_request/view/re_request_page.dart';
import '../../../features/payments/view/report/debit_advise_report/view/debit_advise_report.dart';
import '../../../features/sbi/view/sbi/rejected_manuel_debit_advise/view/rejected_manuel_debit_advise.dart';
import 'app_route_name.dart';
import 'app_route_path.dart';

class AppRoutes {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  late final GoRouter appRouter;

  AppRoutes() {
    appRouter = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: RoutesPath.splash,
      routes: [
        GoRoute(
          name: RoutesName.splash,
          path: '/splash/session=:session/token=:token',
          pageBuilder: (context, state) {
            final curSession = state.pathParameters['session'] ?? '';
            final curToken = state.pathParameters['token'] ?? '';
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: SplashScreen(
                session: curSession,
                token: curToken,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            );
          },
        ),
        ShellRoute(
          builder: (context, state, child) {
            return MainShell(child: child);
          },
          routes: [
            GoRoute(
              name: RoutesName.home,
              path: RoutesPath.home,
              pageBuilder: (context, state) {
                _removeBreadCrumbs(context);
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const HomePage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                );
              },
              routes: [
                GoRoute(
                    name: RoutesName.payments,
                    path: 'payments',
                    pageBuilder: (context, state) {
                      _addBreadCrumbs(context, 'Payments');
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: const PaymentsPage(),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      );
                    },
                    routes: [
                      GoRoute(
                        name: RoutesName.reInitiate,
                        path: 're_initiate/userId=:userId/userName=:userName',
                        pageBuilder: (context, state) {
                          final encryptedUserId =
                              state.pathParameters['userId'] ?? '';
                          final encryptedUserName =
                              state.pathParameters['userName'] ?? '';

                          _addBreadCrumbs(context, "Re-initiate");

                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: ReInitiatePage(
                              encryptedUserId: encryptedUserId,
                              encryptedUserName: encryptedUserName,
                            ),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.reRequest,
                        path: 're_request',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context,
                              'Re-initiate Successful Payment - Request');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const ReRequestPage(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.reApproval,
                        path: 're_approval',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context,
                              'Re-initiate Successful Payment - Approval');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const ReApprovalPage(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.debitAdvise,
                        path: 'debit_advise',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Debit Advise Block');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const DebitAdvisePage(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.changeDebitAdviseBranch,
                        path: 'change_debit_advise_branch',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(
                              context, 'Change Debit Advice Branch');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const ChangeDebitAdviseBranch(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.changeBranchImpsBank,
                        path: 'change_branch_imps_bank',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Change Branch IMPS Bank');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const BranchImpsBank(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.bulkReinitiate,
                        path: 'bulk_reinitiate',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(
                              context, 'Bulk Re-initiate Debit Advice Pending');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const BulkReinitiatePage(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.paymentDebitAdvise,
                        path: 'payment_debit_advise',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(
                              context, "Successful Payment to Debit Advice");
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const PaymentDebitAdvise(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.paymentReport,
                        path: 'payment_report',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Payment Report');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const PaymentReportPage(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.paymentOglReport,
                        path: 'payment_ogl_report',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Payment OGL Report');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const PaymentOglReport(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.paymentDebitAdviseReport,
                        path: 'payment_debit_advise_report',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(
                              context, 'Payment Debit Advise Report');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const DebitAdviseReport(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                          name: RoutesName.paymentStatus,
                          path: 'payment_status',
                          pageBuilder: (context, state) {
                            _addBreadCrumbs(context, 'Payment Status');
                            return CustomTransitionPage<void>(
                              key: state.pageKey,
                              child: const PaymentStatus(),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  FadeTransition(
                                      opacity: animation, child: child),
                            );
                          },
                          routes: [
                            GoRoute(
                              name: RoutesName.paymentStatusReport,
                              path: 'payment_status_report',
                              pageBuilder: (context, state) {
                                _addBreadCrumbs(
                                    context, 'Payment Status Report');
                                return CustomTransitionPage<void>(
                                  key: state.pageKey,
                                  child: const PaymentStatusReport(),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      FadeTransition(
                                          opacity: animation, child: child),
                                );
                              },
                            ),
                          ]),
                      GoRoute(
                        name: RoutesName.impsInquiry,
                        path: 'imps_inquiry',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Imps Inquiry');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const ImpsInquiry(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.neftDeatils,
                        path: 'neft_deatils',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Customer NEFT Details');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const NeftDetails(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                    ]),
                GoRoute(
                    name: RoutesName.bankRecon,
                    path: 'bank_reconciliation',
                    pageBuilder: (context, state) {
                      _addBreadCrumbs(context, 'Bank Reconciliation');
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: BankReconPage(),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      );
                    },
                    routes: [
                      GoRoute(
                        name: RoutesName.brs_updation,
                        path: 'brs_updation',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'BRS Updation');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const BrsUpadationPage(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.brs_mismatch_update,
                        path: 'brs_mismatch_update',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'BRS Mismatch Update');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const BrsMismatchUpdation(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.brs_wrong_updation_reversal,
                        path: 'brs_wrong_updation_reversal',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(
                              context, 'Brs Wrong Updation Reversal');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const BrsWrongUpdationReversal(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.yes_bank_statement_file_upload,
                        path: 'yes_bank_statement_file_upload',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(
                              context, 'Yes Bank Statement File Upload');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const YesBankStatementFileUpload(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.yes_bank_neft_response_file_upload,
                        path: 'yes_bank_neft_response_file_upload',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(
                              context, 'Yes Bank Neft Response File Upload');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const YesBankNeftResponseFileUpload(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.yes_bank_file_upload_fee_and_changes,
                        path: 'yes_bank_file_upload_fee_and_changes',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(
                              context, 'Yes Bank File Upload Fee And Charges');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const YesBankFileUploadFeeAndCharges(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.bank_unreconciled_report,
                        path: 'bank_unreconciled_report',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Bank Unreconciled Report');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const BankUnreconciledReport(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.bank_reconciled_report,
                        path: 'bank_reconciled_report',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Bank Reconciled Report');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const BankReconciledReport(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.bank_reconciled_consolidated_report,
                        path: 'bank_reconciled_consolidated_report',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(
                              context, 'Bank reconciled Consolidated Report');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const BankUnreconciledConsolidatedReport(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.bank_statement_missing_report,
                        path: 'bank_statement_missing_report',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(
                              context, 'Bank Statement Missing Report');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const BankStatementMissingReport(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.reconciled_report_consolidated,
                        path: 'reconciled_report_consolidated',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(
                              context, 'Reconciled Report Consolidated');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const ReconciledReportConsolidated(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.unreconciled_report_consolidated,
                        path: 'unreconciled_report_consolidated',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(
                              context, 'Unreconciled Report Consolidated');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const UnreconciledReportConsolidated(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.bank_statement,
                        path: 'bank_statement',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Bank Statement');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const BankStatement(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.hounreconciled_report_consolidated,
                        path: 'hounreconciled_report_consolidated',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(
                              context, 'Unreconciled Report Consolidated');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const HounreconciledReportConsolidated(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                    ]),
                GoRoute(
                    name: RoutesName.others,
                    path: 'others',
                    pageBuilder: (context, state) {
                      _addBreadCrumbs(context, 'Others');
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: const OthersPage(),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      );
                    },
                    routes: [
                      GoRoute(
                        name: RoutesName.email,
                        path: 'email',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Email');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: EmailPage(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.insertCertificate,
                        path: 'insert_certificate',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Interest Certificate');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: InterestCertificatePage(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                    ]),
                GoRoute(
                    name: RoutesName.otp_based,
                    path: 'otp_based',
                    pageBuilder: (context, state) {
                      _addBreadCrumbs(context, 'Otp Based Cash Withdrawal');
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: OtpBasedPage(),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      );
                    },
                    routes: [
                      GoRoute(
                        name: RoutesName.verification,
                        path: 'verification',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Verification');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const Verification(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.beneficiary_download,
                        path: 'beneficiary_download',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Beneficiary Download');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const BeneficiaryDownload(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.beneficial_upload,
                        path: 'beneficial_upload',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Beneficial Upload');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const BeneficiaryUpload(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.remove_registration,
                        path: 'remove_registration',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Remove Registration');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const RemoveRegistration(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.approval,
                        path: 'approval',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Approval');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const Approval(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.cgm_sgm_approval,
                        path: 'cgm_sgm_approval',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'CGM/SGM Approval');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const CgmSgmApproval(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.crn_updation,
                        path: 'crn_updation',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'CRN Updation');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const CrnUpdation(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.mis_file_upload,
                        path: 'mis_file_upload',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'MIS File Upload');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const MisFileUpload(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.registration_report,
                        path: 'registration_report',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Registration Report');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const RegistrationReport(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.transaction_report,
                        path: 'transaction_report',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Transaction Report');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const TransactionReport(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.crn_excel_report,
                        path: 'crn_excel_report',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'CRN Excel Report');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const CrnExcelReport(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.live_employee_report,
                        path: 'live_employee_report',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'Live Employee Report');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const LiveEmployeeReport(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                    ]),
                GoRoute(
                    name: RoutesName.sbi,
                    path: 'sbi',
                    pageBuilder: (context, state) {
                      _addBreadCrumbs(context, 'SBI');
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: const SbiPage(),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      );
                    },
                    routes: [
                      GoRoute(
                        name: RoutesName.sbiPortalReport,
                        path: 'sbi_portal_report',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'SBI Portal Report');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const SbiPortalReport(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.rejectedManuelDebitAdvise,
                        path: 'rejected_manuel_debit_advise',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context,
                              'SBI Portal Rejected Manuel Debit Advise');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const RejectedManuelDebitAdvise(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.sbiManuelEntry,
                        path: 'sbi_manuel_entry',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'SBI Manuel Entry');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const ManuelEntry(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.impsSwitchOver,
                        path: 'imps_switch_over',
                        pageBuilder: (context, state) {
                          _addBreadCrumbs(context, 'SBI to IMPS Switch Over');
                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const ImpsSwitchOver(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                    ]),
              ],
            ),
          ],
        ),
      ],
    );
  }
  void _addBreadCrumbs(BuildContext context, String title) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BreadCrumbsProvider>().addBreadcrumb(title);
    });
  }

  void _removeBreadCrumbs(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BreadCrumbsProvider>().clearBreadcrumbs();
    });
  }
}
