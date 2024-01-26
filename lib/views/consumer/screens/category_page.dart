import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/consumer/screens/category_detail_page.dart';
import 'package:dpl_ecommerce/views/consumer/screens/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({super.key, this.fromHome = false});
  bool fromHome;
  @override
  State<CategoryPage> createState() => __CategoryPageState();
}

class __CategoryPageState extends State<CategoryPage> {
  List<Category>? listCategory;
  bool isLoading = true;
  CategoryRepo categoryRepo = CategoryRepo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    listCategory = await categoryRepo.getListCategory();
    isLoading = false;
    setState(() {});
  }

  Future<void> onRefresh() async {
    await reset();
    await fetchData();
  }

  Future<void> reset() async {
    listCategory = [];
    isLoading = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(143, 4, 20, 243),
      appBar: CustomAppBar(
              isLeading: widget.fromHome ? true : false,
              centerTitle: true,
              context: context,
              title: LangText(context: context).getLocal()!.categories_ucf)
          .show(),
      body: RefreshIndicator(
        onRefresh: () async {
          await onRefresh();
        },
        child: SingleChildScrollView(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    //SizedBox(height: 10.h,),
                    _buildListCategory(context, listCategory),
                  ],
                ),
        ),
      ),
    );
  }
}

Widget _buildListCategory(BuildContext context, List<Category>? list) {
  // List<Category>? list = [
  //   Category(
  //       id: "Cate1", name: "Clothe", logo: 'https://picsum.photos/250?image=9'),
  //   Category(
  //       id: "Cate2",
  //       name: "Clothe2",
  //       logo: 'https://picsum.photos/250?image=9'),
  //   Category(
  //       id: "Cate3",
  //       name: "Clothe3",
  //       logo: 'https://picsum.photos/250?image=9'),
  //   Category(
  //       id: "Cate4",
  //       name: "Clothe4",
  //       logo: 'https://picsum.photos/250?image=9'),
  //   Category(
  //       id: "Cate5",
  //       name: "Clothe5",
  //       logo: 'https://picsum.photos/250?image=9'),
  //   Category(
  //       id: "Cate6",
  //       name: "Clothe6",
  //       logo: 'https://picsum.photos/250?image=9'),
  //   Category(
  //       id: "Cate7",
  //       name: "Clothe7",
  //       logo: 'https://picsum.photos/250?image=9'),
  // ];
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: list!.length,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetail(categoryID: list[index].id!),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 5.h),
          child: Container(
            height: 100.h,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: MyTheme.accent_color_2,
              // border: Border.all(color: Colors.yellow),
              // borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100.h,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    // borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      list[index].name!,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFF6F6F6),
                      ),
                    ),
                  ),
                ),
                // Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(10.r),
                      ),
                  child: Image.network(
                    list[index].logo!,
                    height: 100.h,
                    width: MediaQuery.of(context).size.width * 0.4,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
