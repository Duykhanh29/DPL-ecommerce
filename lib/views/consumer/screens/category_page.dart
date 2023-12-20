import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/views/consumer/screens/category_detail.dart';
import 'package:dpl_ecommerce/views/consumer/screens/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => __CategoryPageState();
}

class __CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(143, 4, 20, 243),
      appBar: AppBar(
          title: Text("Categories",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFFF6F6F6),
              ))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //SizedBox(height: 10.h,),
            _buildcate(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildcate(BuildContext context) {
  List<Category>? list = [
    Category(
        id: "Cate1", name: "Clothe", logo: 'https://picsum.photos/250?image=9'),
    Category(
        id: "Cate2",
        name: "Clothe2",
        logo: 'https://picsum.photos/250?image=9'),
    Category(
        id: "Cate3",
        name: "Clothe3",
        logo: 'https://picsum.photos/250?image=9'),
    Category(
        id: "Cate4",
        name: "Clothe4",
        logo: 'https://picsum.photos/250?image=9'),
    Category(
        id: "Cate5",
        name: "Clothe5",
        logo: 'https://picsum.photos/250?image=9'),
    Category(
        id: "Cate6",
        name: "Clothe6",
        logo: 'https://picsum.photos/250?image=9'),
    Category(
        id: "Cate7",
        name: "Clothe7",
        logo: 'https://picsum.photos/250?image=9'),
  ];
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: list!.length,
    itemBuilder: (BuildContext context, int index) {
      return SingleChildScrollView(
        child: GestureDetector(
           onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryDetail(),
                              ),
                            ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Container(
              height: 100.h,
              width: 343.w,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(8),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 100.h,
                      width: 172.w,
                      color: Colors.blue,
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
                    Spacer(),
                    Image.network(
                      list[index].logo!,
                      height: 100.h,
                      width: 160.w,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
