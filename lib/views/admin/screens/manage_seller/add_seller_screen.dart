import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/models/verification_form.dart';
import 'package:dpl_ecommerce/repositories/verification_form_repo.dart';
import 'package:dpl_ecommerce/services/storage_services/storage_service.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/admin/manage_seller_view_model.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:dpl_ecommerce/views/admin/screens/manage_seller/add_basic_infor.dart';
import 'package:dpl_ecommerce/views/admin/screens/manage_seller/add_legal_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddSellerScreen extends StatefulWidget {
  AddSellerScreen({super.key});

  @override
  State<AddSellerScreen> createState() => _AddSellerScreenState();
}

class _AddSellerScreenState extends State<AddSellerScreen> {
  VerificationFormRepo verificationFormRepo = VerificationFormRepo();
  StorageService storageService = StorageService();
  Future<void> onPressAdd(
      BuildContext context,
      ManageSellerViewModel manageSellerViewModel,
      AuthViewModel authViewModel) async {
    bool isSuccess = await storageService.uploadFile(
      filePath: manageSellerViewModel.taxPaperPath!,
      fileName: manageSellerViewModel.taxPaperName!,
      rootRef: 'verifications',
      secondRef: manageSellerViewModel.shop!.id,
    );
    if (isSuccess) {
      String url = await storageService.downloadURL(
        filePath: manageSellerViewModel.taxPaperPath!,
        fileName: manageSellerViewModel.taxPaperName!,
        rootRef: 'verifications',
        secondRef: manageSellerViewModel.shop!.id,
      );
      manageSellerViewModel.updateVerification(url);
      // ignore: use_build_context_synchronously
      await verificationFormRepo.addSellerByAdmin(
          context: context,
          email: manageSellerViewModel.seller!.email!,
          pass: manageSellerViewModel.password!,
          firstName: manageSellerViewModel.seller!.firstName!,
          city: manageSellerViewModel
              .seller!.userInfor!.sellerInfor!.contactAddress!.city!,
          disctrict: manageSellerViewModel
              .seller!.userInfor!.sellerInfor!.contactAddress!.district!,
          ward: manageSellerViewModel
              .seller!.userInfor!.sellerInfor!.contactAddress!.ward!,
          country: manageSellerViewModel
              .seller!.userInfor!.sellerInfor!.contactAddress!.country!,
          number: manageSellerViewModel
              .seller!.userInfor!.sellerInfor!.contactAddress!.number!,
          shopName: manageSellerViewModel.shop!.name!);
      await verificationFormRepo
          .sendVerificationForm(manageSellerViewModel.legalInfor!);
      await verificationFormRepo
          .confirmSellerRequest(manageSellerViewModel.legalInfor!);
      manageSellerViewModel.reset();
      Navigator.of(context).pop();
    }
  }

  int currentStep = 0;

  void continueStep() {
    if (currentStep < 1) {
      setState(() {
        currentStep++;
      });
    }
  }

  void onCacelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void onStepTapped(int index) {
    setState(() {
      currentStep = index;
    });
  }

  Widget controllerBuilder(BuildContext context, ControlsDetails detail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            onPressed: detail.onStepContinue,
            child: Text(LangText(context: context).getLocal()!.next_ucf)),
        ElevatedButton(
            onPressed: detail.onStepCancel,
            child: Text(LangText(context: context).getLocal()!.cancel_ucf)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);
    final manageSellerProvider = Provider.of<ManageSellerViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LangText(context: context).getLocal()!.add_seller,
          style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              color: MyTheme.white),
        ),
        backgroundColor: MyTheme.accent_color,
        elevation: 15,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          child: InkWell(
            onTap: () {
              manageSellerProvider.reset();
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: MyTheme.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Consumer<ManageSellerViewModel>(
                builder: (context, value, child) => Stepper(
                  currentStep: currentStep,
                  onStepCancel: onCacelStep,
                  controlsBuilder: (context, details) {
                    return controllerBuilder(context, details);
                  },
                  onStepContinue: continueStep,
                  steps: [
                    Step(
                        isActive: value.seller != null,
                        title: Text(
                            LangText(context: context).getLocal()!.step_one),
                        content: value.seller != null
                            ?
                            // Consumer<ManageSellerViewModel>(
                            //   builder: (context, value, child) {
                            // if (value.seller != null) {
                            Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => AddBasicInfor(),
                                    ));
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        color: MyTheme.background,
                                        border: Border.all(color: Colors.blue)),
                                    child: Center(
                                      child: Text(LangText(context: context)
                                          .getLocal()!
                                          .add_basic_infor),
                                    ),
                                  ),
                                ),
                              )
                            :
                            // } else {
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddBasicInfor(),
                                  ));
                                },
                                child: Container(
                                  height: 40.h,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: MyTheme.grey_153,
                                      border: Border.all(color: MyTheme.red)),
                                  child: Center(
                                    child: Text(LangText(context: context)
                                        .getLocal()!
                                        .add_basic_infor),
                                  ),
                                ),
                              )
                        // }
                        // },
                        // ),
                        ),
                    Step(
                        isActive: value.seller != null,
                        title: Text(
                            LangText(context: context).getLocal()!.step_two),
                        content:
                            // Consumer<ManageSellerViewModel>(
                            //   builder: (context, value, child) {
                            //     if (value.seller != null) {
                            //       return
                            value.legalInfor != null
                                ? GestureDetector(
                                    onTap: () {
                                      if (value.seller == null) {
                                        ToastHelper.showDialog(
                                            LangText(context: context)
                                                .getLocal()!
                                                .you_need_enter_basic_info_for_seller,
                                            gravity: ToastGravity.BOTTOM);
                                      } else {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const AddLegalInfo(),
                                        ));
                                      }
                                    },
                                    child: Container(
                                      height: 40.h,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: MyTheme.background,
                                          border:
                                              Border.all(color: Colors.blue)),
                                      child: Center(
                                        child: Text(LangText(context: context)
                                            .getLocal()!
                                            .add_legal_info),
                                      ),
                                    ),
                                  )
                                :
                                // } else {
                                // return
                                GestureDetector(
                                    onTap: () {
                                      if (value.seller == null) {
                                        ToastHelper.showDialog(
                                            LangText(context: context)
                                                .getLocal()!
                                                .you_need_enter_basic_info_for_seller,
                                            gravity: ToastGravity.BOTTOM);
                                      } else {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const AddLegalInfo(),
                                        ));
                                      }
                                    },
                                    child: Container(
                                      height: 40.h,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: MyTheme.grey_153,
                                          border:
                                              Border.all(color: MyTheme.red)),
                                      child: Center(
                                        child: Text(LangText(context: context)
                                            .getLocal()!
                                            .add_legal_info),
                                      ),
                                    ),
                                  )
                        //   }
                        // },
                        // ),
                        ),
                  ],
                ),
              )
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.04,
              // ),
              // Consumer<ManageSellerViewModel>(
              //   builder: (context, value, child) {
              //     if (value.seller == null) {
              //       return Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: [
              //           Padding(
              //             padding: EdgeInsets.symmetric(
              //                 vertical: 5.h, horizontal: 5.w),
              //             child: Text(LangText(context: context)
              //                 .getLocal()!
              //                 .you_need_enter_basic_info_for_seller),
              //           ),
              //         ],
              //       );
              //     } else {
              //       return Container();
              //     }
              //   },
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.04,
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        child: Consumer<ManageSellerViewModel>(
          builder: (context, value, child) => GestureDetector(
            onTap: () async {
              if (value.legalInfor != null && value.seller != null) {
                await onPressAdd(context, value, authProvider);
              } else if (value.legalInfor == null && value.seller != null) {
                ToastHelper.showDialog(
                    LangText(context: context)
                        .getLocal()!
                        .you_need_enter_legal_info_for_seller,
                    gravity: ToastGravity.BOTTOM);
              } else if (value.legalInfor != null && value.seller == null) {
                ToastHelper.showDialog(
                    LangText(context: context)
                        .getLocal()!
                        .you_need_enter_basic_info_for_seller,
                    gravity: ToastGravity.BOTTOM);
              } else {
                ToastHelper.showDialog(
                    LangText(context: context).getLocal()!.add_full_infor,
                    gravity: ToastGravity.BOTTOM);
              }
            },
            child: Container(
              height: 45.h,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: value.legalInfor != null && value.seller != null
                      ? MyTheme.accent_color
                      : MyTheme.borderColor),
              child: Center(
                child: Text(
                  LangText(context: context).getLocal()!.add_ucf,
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: MyTheme.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
