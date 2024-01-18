import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_photo_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_form_field.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/models/seller_infor.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/services/storage_services/storage_service.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore_for_file: must_be_immutable
class AdminSettingProfilePage extends StatelessWidget {
  AdminSettingProfilePage({Key? key}) : super(key: key);
  StorageService storageService = StorageService();
  UserRepo userRepo = UserRepo();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    final userInfo = user!.userInfor;
    final sellerInfo = userInfo!.sellerInfor;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
              centerTitle: true,
              context: context,
              title: LangText(context: context).getLocal()!.profile_setting)
          .show(),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 5.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                height: 100.h,
                width: 100.w,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Consumer<UserViewModel>(builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return Scaffold(
                                appBar: AppBar(
                                  leading: CustomArrayBackWidget(),
                                  actions: [
                                    value.userModel!.avatar != null
                                        ? IconButton(
                                            onPressed: () async {
                                              await storageService
                                                  .downloadAndSaveImage(
                                                      value.userModel!.avatar!,
                                                      context);
                                            },
                                            icon: Icon(
                                              Icons.download_outlined,
                                              size: 20.h,
                                            ))
                                        : Container()
                                  ],
                                ),
                                body: CustomPhotoView(
                                    urlImage: value.userModel!.avatar),
                              );
                            },
                          ));
                        },
                        child: value.userModel!.avatar != null
                            ? CircleAvatar(
                                radius: 60.r,
                                backgroundImage:
                                    NetworkImage(value.userModel!.avatar!),
                              )
                            : CircleAvatar(
                                radius: 60.r,
                                backgroundImage:
                                    AssetImage(ImageData.circelAvatar),
                              ),
                      );
                    }),
                    InkWell(
                      onTap: () async {
                        final result = await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.custom,
                            allowedExtensions: ['png', 'jpg']);
                        if (result != null) {
                          final path = result.files.single.path;
                          final fileName = result.files.single.name;
                          // String type = 'images';
                          bool isSuccess = await storageService.uploadFile(
                            filePath: path!,
                            fileName: fileName,
                            secondRef: user.id!,
                            rootRef: 'avatars',
                          );
                          if (isSuccess) {
                            String url = await storageService.downloadURL(
                              filePath: path,
                              fileName: fileName,
                              secondRef: user.id!,
                              rootRef: 'avatars',
                            );
                            await userRepo.updateAvatar(
                                uid: user.id!, avatar: url);
                            userProvider.updateAvatar(url);
                          }
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blueAccent),
                        padding: EdgeInsets.all(2.h),
                        child: Icon(
                          Icons.edit,
                          size: 20.h,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 90.h),
              BuildForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildForm extends StatefulWidget {
  BuildForm({super.key});
  // UserViewModel provider;
  @override
  State<BuildForm> createState() => _BuildFormState();
}

class _BuildFormState extends State<BuildForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserRepo userRepo = UserRepo();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   firstNameEditTextController.text = widget.provider.firstName!;
  //   lastNameEditTextController.text = widget.provider.lastName!;
  //   phoneEditTextController.text = widget.provider.phone!;
  //   emailEditTextController.text = widget.provider.email!;
  // }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context, listen: false);
    print("Check test");
    final user = userProvider.currentUser;
    final userInfo = user!.userInfor;
    final sellerInfo = userInfo!.sellerInfor;
    // firstNameEditTextController =
    //     TextEditingController(text: userProvider.firstName);
    // lastNameEditTextController =
    //     TextEditingController(text: userProvider.lastName);
    // emailEditTextController = TextEditingController(text: userProvider.email);
    // phoneEditTextController = TextEditingController(text: userProvider.phone);
    return Form(
      key: _formKey,
      child: Consumer<UserViewModel>(
        builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<UserViewModel>(
                builder: (context, value, child) {
                  return TextFormField(
                    onChanged: (value) {
                      // userProvider.changeTempFirstName(value);
                    },
                    validator: (value) {
                      if (value == null || value == "") {
                        return LangText(context: context)
                            .getLocal()!
                            .input_again;
                      }
                      return null;
                    },
                    controller: value.firstNameEditTextController,
                    decoration: InputDecoration(
                      hintText:
                          LangText(context: context).getLocal()!.first_name,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              Consumer<UserViewModel>(
                builder: (context, value, child) {
                  return TextFormField(
                    onChanged: (value) {
                      // userProvider.changeTempLastName(value);
                    },
                    // validator: (value) {
                    //   if (value == null || value == "") {
                    //     return "Input again";
                    //   }
                    //   return null;
                    // },
                    controller: value.lastNameEditTextController,
                    decoration: InputDecoration(
                      hintText:
                          LangText(context: context).getLocal()!.last_name,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              Consumer<UserViewModel>(
                builder: (context, value, child) {
                  return TextFormField(
                    onChanged: (value) {
                      // userProvider.changeTempPhone(value);
                    },
                    // validator: (value) {
                    //   if (value == null || value == "") {
                    //     return "Input again";
                    //   }
                    //   return null;
                    // },
                    keyboardType: TextInputType.phone,
                    controller: value.phoneEditTextController,
                    decoration: InputDecoration(
                      hintText: LangText(context: context)
                          .getLocal()!
                          .phone_number_ucf,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              Consumer<UserViewModel>(
                builder: (context, value, child) {
                  return TextFormField(
                    onChanged: (value) {
                      // userProvider.changeTempEmail(value);
                    },
                    validator: (value) {
                      if (value == null || value == "") {
                        return LangText(context: context)
                            .getLocal()!
                            .input_again;
                      }
                      return null;
                    },
                    readOnly: true,
                    keyboardType: TextInputType.emailAddress,
                    controller: value.emailEditTextController,
                    decoration: InputDecoration(
                      hintText:
                          LangText(context: context).getLocal()!.email_ucf,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 45.h,
              ),
              // buildTaxPaper(context, sellerInfo!),
              // SizedBox(
              //   height: 60.h,
              // ),
              _buildSaveChangeButton(context, userProvider),
              SizedBox(
                height: 20.h,
              ),
            ],
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildSaveChangeButton(
      BuildContext context, UserViewModel userProvider) {
    final userProvider = Provider.of<UserViewModel>(context, listen: false);
    print("Check test");
    final user = userProvider.currentUser;
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.06,
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      width: size.width * 0.9,
      // padding: EdgeInsets.only(
      //   right: 10.w,
      //   left: 10.w,
      // ),
      child: ElevatedButton(
        onPressed: () async {
          var isValid = _formKey.currentState!.validate();
          if (isValid) {
            // print("New email: ${userProvider.emailEditTextController!.text}");
            // print(
            //     "New firstName: ${userProvider.firstNameEditTextController!.text}");
            // print(
            //     "New lastName: ${userProvider.lastNameEditTextController!.text}");
            // print("New phone: ${userProvider.phoneEditTextController!.text}");
            userProvider.updateInfor(
                email: userProvider.emailEditTextController.text,
                firstName: userProvider.firstNameEditTextController.text,
                lastName: userProvider.lastNameEditTextController.text,
                phone: userProvider.phoneEditTextController.text);
            //     UserModel userModel=UserModel(avatar: );
            await userRepo.updateUserInfor(
                userModel: user!,
                email: userProvider.emailEditTextController.text,
                name: userProvider.firstNameEditTextController.text,
                phone: userProvider.phoneEditTextController.text);
            Navigator.of(context).pop();
          } else {
            print("object");
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MyTheme.accent_color),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r)))),
        child: Text(LangText(context: context).getLocal()!.save_ucf),
      ),
    );
  }

  Widget buildTaxPaper(BuildContext context, SellerInfor sellerInfor) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.24,
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Text(AppLocalizations.of(context)!.tax_paper_ucf,
                style: TextStyle(
                    color: MyTheme.font_grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp)),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.24,
              width: MediaQuery.of(context).size.width * 0.9,
              // padding: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: MyTheme.dark_grey, width: 0.5)),
              child: sellerInfor.taxPaper != null
                  ? CachedNetworkImage(
                      placeholder: (context, url) =>
                          Image.asset(ImageData.circelAvatar),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        size: 28.h,
                      ),
                      imageUrl: sellerInfor.taxPaper!,
                      height: MediaQuery.of(context).size.height * 0.06,
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      ImageData.placeHolder,
                      fit: BoxFit.contain,
                    )),
        ],
      ),
    );
  }
}
