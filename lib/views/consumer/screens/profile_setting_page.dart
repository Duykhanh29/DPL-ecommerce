import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_photo_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_form_field.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/services/storage_services/storage_service.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore_for_file: must_be_immutable
class ProfileSettingScreen extends StatelessWidget {
  ProfileSettingScreen({Key? key}) : super(key: key);
  StorageService storageService = StorageService();
  UserRepo userRepo = UserRepo();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
              title: LangText(context: context).getLocal()!.profile_setting,
              centerTitle: true,
              context: context)
          .show(),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 5.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 20.h,
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
                                  backgroundColor: MyTheme.accent_color,
                                  leading: CustomArrayBackWidget(),
                                  actions: [
                                    IconButton(
                                        onPressed: () async {
                                          await storageService
                                              .downloadAndSaveImage(
                                                  value.userModel!.avatar!,
                                                  context);
                                        },
                                        icon: Icon(
                                          Icons.download_rounded,
                                          color: MyTheme.white,
                                          size: 20.h,
                                        ))
                                  ],
                                ),
                                body: CustomPhotoView(
                                    urlImage: value.userModel!.avatar),
                              );
                            },
                          ));
                        },
                        child: CircleAvatar(
                          radius: 60.r,
                          backgroundImage:
                              NetworkImage(value.userModel!.avatar!),
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
                          String type = 'images';
                          bool isSuccess = await storageService.uploadFile(
                            filePath: path!,
                            fileName: fileName,
                            secondRef: user!.id!,
                            rootRef: 'avatars',
                          );
                          if (isSuccess) {
                            String url = await storageService.downloadURL(
                              filePath: path!,
                              fileName: fileName,
                              secondRef: user!.id!,
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
              BuildForm(provider: userProvider),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildForm extends StatefulWidget {
  BuildForm({super.key, required this.provider});
  UserViewModel provider;
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
                    validator: (value) {
                      if (value == null || value == "") {
                        return LangText(context: context)
                            .getLocal()!
                            .input_again;
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value == null || value == "") {
                        return LangText(context: context)
                            .getLocal()!
                            .input_again;
                      }
                      return null;
                    },
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
                height: 80.h,
              ),
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
        child: Text(
          LangText(context: context).getLocal()!.save_ucf,
          style: TextStyle(color: MyTheme.white),
        ),
      ),
    );
  }
}
