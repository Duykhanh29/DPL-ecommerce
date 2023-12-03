import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_elevate_button.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_photo_view.dart';
import 'package:dpl_ecommerce/customs/custom_text_form_field.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore_for_file: must_be_immutable
class ProfileSettingScreen extends StatelessWidget {
  ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: CustomArrayBackWidget(),
          title: Text("Profile setting"),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 108,
                width: 103,
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
                                ),
                                body: CustomPhotoView(
                                    urlImage: value.userModel!.avatar),
                              );
                            },
                          ));
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(value.userModel!.avatar!),
                        ),
                      );
                    }),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blueAccent),
                        padding: const EdgeInsets.all(2),
                        child: Icon(Icons.edit),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 91),
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
                        return "Input again";
                      }
                      return null;
                    },
                    controller: value.firstNameEditTextController,
                    decoration: InputDecoration(
                      hintText: "first name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<UserViewModel>(
                builder: (context, value, child) {
                  return TextFormField(
                    onChanged: (value) {
                      // userProvider.changeTempLastName(value);
                    },
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Input again";
                      }
                      return null;
                    },
                    controller: value.lastNameEditTextController,
                    decoration: InputDecoration(
                      hintText: "last name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<UserViewModel>(
                builder: (context, value, child) {
                  return TextFormField(
                    onChanged: (value) {
                      // userProvider.changeTempPhone(value);
                    },
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Input again";
                      }
                      return null;
                    },
                    controller: value.phoneEditTextController,
                    decoration: InputDecoration(
                      hintText: "phone",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<UserViewModel>(
                builder: (context, value, child) {
                  return TextFormField(
                    onChanged: (value) {
                      // userProvider.changeTempEmail(value);
                    },
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Input again";
                      }
                      return null;
                    },
                    controller: value.emailEditTextController,
                    decoration: InputDecoration(
                      hintText: "email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 80,
              ),
              _buildSaveChangeButton(context, userProvider),
              const SizedBox(
                height: 20,
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
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.06,
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      width: size.width * 0.9,
      padding: EdgeInsets.only(
        right: 10,
        left: 10,
      ),
      child: ElevatedButton(
        onPressed: () {
          var isValid = _formKey.currentState!.validate();
          if (isValid) {
            print("New email: ${userProvider.emailEditTextController!.text}");
            print(
                "New firstName: ${userProvider.firstNameEditTextController!.text}");
            print(
                "New lastName: ${userProvider.lastNameEditTextController!.text}");
            print("New phone: ${userProvider.phoneEditTextController!.text}");
            userProvider.updateInfor(
                email: userProvider.emailEditTextController!.text,
                firstName: userProvider.firstNameEditTextController!.text,
                lastName: userProvider.lastNameEditTextController!.text,
                phone: userProvider.phoneEditTextController!.text);
            Navigator.of(context).pop();
          } else {
            print("object");
          }
        },
        child: const Text("Save"),
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)))),
      ),
    );
  }
}
