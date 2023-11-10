import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_text_style.dart';
import 'package:dpl_ecommerce/utils/constants/size_utils.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_item_widget1.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:dpl_ecommerce/views/seller/detail_seller_profile.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});
}

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin{
  String searchQuery = '';
  int isSelected = 0;
  late TabController _tabController;
  List<Category> categories = [
    Category(name: 'Category 1', icon: Icons.category),
    Category(name: 'Category 2', icon: Icons.category),
    Category(name: 'Category 3', icon: Icons.category),
    Category(name: 'Category 4', icon: Icons.category),
    Category(name: 'Category 5', icon: Icons.category),
  ];
  int selectedIndex = -1;
  
  @override
  void initState()
  {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }
  _handleTabSelection()
  {
    if(_tabController.indexIsChanging)
    {
      setState(() {
        
      });
    }
  }

  @override
  void dispose()
  {
    _tabController.dispose();
    super.dispose();

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Row(
          children: [
            //Icon(Icons.search),
            //SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            //SizedBox(width: 8.0),

            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Row(
                      children: [
                        GestureDetector(
                           onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileSeller(),
                              ),
                            ),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                                "https://s3.o7planning.com/images/boy-128.png"),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                           onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileSeller(),
                              ),
                            ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tan Official MALL >",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Online ",
                                textAlign: TextAlign.left,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                  color: Color.fromARGB(255, 230, 207, 6),),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("4.9/5"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("|"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  //Text("900k followers")
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  onPrimary: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {
                                  // TODO: Add button press logic
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.chat,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Chat',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TabBar(
                      controller: _tabController,
                      labelColor:  Colors.blue,
                      unselectedLabelColor: Colors.black,
                      isScrollable: true,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width:3,
                          color: Colors.blue,
                          ),
                          insets: EdgeInsets.symmetric(horizontal: 16)
                          ),
                          labelPadding: EdgeInsets.symmetric(horizontal: 20),
                          labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                      tabs: [
                        Tab(text: "Shop"),
                        Tab(text: "Products"),
                        Tab(text: "Product category"),
                        //Tab(text: "Live"),
                      ]),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: [
                          Container(
                            //color: Colors.pink,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 50,),
                                  
                                  Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.h, vertical: 6),
                            child: _buildDealOfTheDay(
                              context,
                              dealOfTheDayText: "Recommend",
                              viewAllText: "View all",
                            ),
                          ),
                          _buildDealOfTheDayRow(context),
                          SizedBox(height: 26.v),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Shop Tan",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                Text("- Providing reputable and high quality products",textAlign:TextAlign.left,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                Text("- Providing reputable and high quality products",textAlign:TextAlign.left,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                Text("- Providing reputable and high quality products",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                Text("- Providing reputable and high quality products",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                
                              ],
                            )),
                            Padding(
                              padding: EdgeInsets.only(bottom: 5.v, left: 10.v),
                              child: Column(
                                children: [
                                  Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.h,),
                                  //padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: _buildDealOfTheDay(
                                    context,
                                    dealOfTheDayText: "",
                                    viewAllText: "",
                                  ),
                                                      ),
                              _buildProductSmallList1(context),
                                ],
                              ),
                            ),
                          //SizedBox(height: 16.v),
                        

                                ],
                              ),
                            ),
                            
                            //color: Colors.white,
                            
                          ),
                          Container(
                            //color: Colors.red,
                             child: Padding(
                              padding: EdgeInsets.only(bottom: 5.v, left: 10.v),
                              child: Column(
                                children: [
                                  Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.h,),
                                  //padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: _buildDealOfTheDay(
                                    context,
                                    dealOfTheDayText: "",
                                    viewAllText: "",
                                  ),
                                                      ),
                              _buildProductSmallList1(context),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            //color: Colors.red,
                            child: Column(
                              children: categories.map((category) {
            return ListTile(
              leading: Icon(category.icon),
              title: Text(category.name),
            );
          }).toList(),
                            ),
                          ),
                          
                        ][_tabController.index],
                      ),
                    
                  
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _buildProductCategory({required int index, required String name}) =>
  // GestureDetector(
  //   onTap: () => setState(() => isSelected = index),
  //   child: Container(
  //     width: 100,
  //     height: 40,
  //     margin:  const EdgeInsets.only(top: 10, right: 10),
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       color: isSelected == index ? Colors.red :Colors.red.shade300,
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Text(name,
  //     style: const TextStyle(color: Colors.white,),),
  //   ),
  // );
  //  Widget buildProductCategory({required int index, required String name}) {
  //   return GestureDetector(
  //     onTap: () => setState(() => isSelected = index),
  //     child: Container(
  //       width: 100,
  //       height: 40,
  //       margin: const EdgeInsets.only(top: 10, right: 10),
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         color: isSelected == index ? Colors.red : Colors.red.shade300,
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: Text(
  //         name,
  //         style: TextStyle(
  //           color: isSelected == index ? Colors.white : Colors.black,
  //         ),
  //       ),
  //     ),
  //   );
  // }
 

}
Widget _buildDealOfTheDay(
    BuildContext context, {
    required String dealOfTheDayText,
    required String viewAllText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.v),
          child: Text(
            dealOfTheDayText,
            style: theme.textTheme.titleSmall!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 3.v),
          child: TextButton(
            onPressed: () {
              // go to see all
            },
            child: Text(
              viewAllText,
              style: CustomTextStyles.bodySmallGray600.copyWith(
                color: appTheme.gray600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDealOfTheDayRow(BuildContext context) {
    return SizedBox(
      height: 220.v,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 16.h),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            width: 16.h,
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return ProductItemWidget();
        },
      ),
    );
  }
  Widget _buildProductSmallList1(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(right: 10.h),
    child: GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 283.v,
        // childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) {
        return Productsmalllist1ItemWidget();
      },
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
    ),
  );
}



