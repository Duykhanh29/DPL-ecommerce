import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/helpers/shimmer_helper.dart';
import 'package:dpl_ecommerce/helpers/string_helper.dart';
import 'package:dpl_ecommerce/models/flash_sale.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/product_small_list_item1_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class FlashDealProducts extends StatefulWidget {
  FlashDealProducts({Key? key, required this.list}) : super(key: key);
  List<Product> list;

  @override
  _FlashDealProductsState createState() => _FlashDealProductsState();
}

class _FlashDealProductsState extends State<FlashDealProducts> {
  TextEditingController _searchController = new TextEditingController();

  late List<Product> _searchList;
  late List<Product> _fullList;
  ScrollController? _scrollController;

  String timeText(String txt, {default_length = 3}) {
    var blank_zeros = default_length == 3 ? "000" : "00";
    var leading_zeros = "";
    if (txt != null) {
      if (default_length == 3 && txt.length == 1) {
        leading_zeros = "00";
      } else if (default_length == 3 && txt.length == 2) {
        leading_zeros = "0";
      } else if (default_length == 2 && txt.length == 1) {
        leading_zeros = "0";
      }
    }

    var newtxt = (txt == null || txt == "" || txt == null.toString())
        ? blank_zeros
        : txt;

    if (default_length > txt.length) {
      newtxt = leading_zeros + newtxt;
    }

    return newtxt;
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _future =
  //       ProductRepository().getFlashDealProducts(id: widget.flash_deal_id);
  //   _searchList = [];
  //   _fullList = [];
  //   super.initState();
  // }

  _buildSearchList(search_key) async {
    _searchList.clear();

    if (search_key.isEmpty) {
      _searchList.addAll(_fullList);
      setState(() {});
      //print("_searchList.length on empty " + _searchList.length.toString());
      //print("_fullList.length on empty " + _fullList.length.toString());
    } else {
      for (var i = 0; i < _fullList.length; i++) {
        if (StringHelper().stringContains(_fullList[i].name, search_key)!) {
          _searchList.add(_fullList[i]);
          setState(() {});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        //  Scaffold(
        //   backgroundColor: Colors.white,
        //   appBar: buildAppBar(context),
        // body:
        _buildProductSmallList1(context, widget.list);
    // );
  }

  bool? shouldProductBoxBeVisible(product_name, search_key) {
    if (search_key == "") {
      return true; //do not check if the search key is empty
    }
    return StringHelper().stringContains(product_name, search_key);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 75,
      leading: Builder(builder: (context) => CustomArrayBackWidget()),
      title: Container(
        width: 250,
        child: TextField(
          controller: _searchController,
          onChanged: (txt) {
            print(txt);
            // _buildSearchList(txt);
            // print(_searchList.toString());
            // print(_searchList.length);
          },
          onTap: () {},
          autofocus: true,
          decoration: InputDecoration(
              hintText:
                  // "${AppLocalizations.of(context)!.search_products_from} : " +
                  //     widget.flash_deal_name!,
                  "",
              hintStyle: TextStyle(fontSize: 14.0, color: Colors.blueGrey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey, width: 0.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey, width: 0.0),
              ),
              contentPadding: EdgeInsets.all(0.0)),
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: IconButton(
            icon: Icon(Icons.search, color: Colors.blueGrey),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  buildProductList(context) {
    return
        // FutureBuilder(
        //     future: _future,
        //     builder: (context, AsyncSnapshot<ProductMiniResponse> snapshot) {
        //       if (snapshot.hasError) {
        //         //snapshot.hasError
        //         //print("product error");
        //         //print(snapshot.error.toString());
        //         return Container();
        //       } else if (snapshot.hasData) {
        //         var productResponse = snapshot.data;
        //         if (_fullList.length == 0) {
        //           _fullList.addAll(productResponse!.products!);
        //           _searchList.addAll(productResponse!.products!);
        //         }

        //print('called');

        // return
        Container(
      color: Colors.green,
      height: MediaQuery.of(context).size.height * 0.9,
      padding: EdgeInsets.all(5),
      child: Expanded(
        child:
            // buildFlashDealsBanner(context),
            GridView.builder(
          // shrinkWrap: false,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            // Product product = Product(
            //   availableQuantity: 100,
            //   categoryID: "cacd",
            //   colors: ["Red", "Yellow"],
            //   createdAt: DateTime(2023, 11, 4),
            //   description: "This is a clothe",
            //   id: "productID01",
            //   images: [
            //     "https://t3.ftcdn.net/jpg/06/49/51/82/360_F_649518247_J27irz9TezhqqHS6EpF0AQY7bFdVAIn8.jpg",
            //     "https://images.unsplash.com/photo-1541963463532-d68292c34b19?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
            //     "https://images.unsplash.com/photo-1575936123452-b67c3203c357?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
            //     "https://images.pexels.com/photos/11061877/pexels-photo-11061877.jpeg?cs=srgb&dl=pexels-bailey-dill-11061877.jpg&fm=jpg"
            //   ],
            //   name: "Cloth",
            //   price: 12345,
            //   purchasingCount: 123,
            //   rating: 4.3,
            //   ratingCount: 100,
            //   reviewIDs: [
            //     "reviewID01",
            //     "reviewID02",
            //     "reviewID03",
            //   ],
            //   shopID: "shopID01",
            //   shopLogo:
            //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpJQq_-DhuwRXiRIHcypaS8QpphdlR_4nJW-mlHakPX5JiJLqLQI18ypV-8vxLkfqS4D8&usqp=CAU",
            //   shopName: "DK",
            //   updatedAt: DateTime.now(),
            // );
            return
                //  Text("data");
                index >= widget.list.length
                    ? Productsmalllist1ItemWidget(product: widget.list[0])
                    : Productsmalllist1ItemWidget(product: widget.list[index]);
          },
          itemCount: 15,
          //     )
          //   ],
          // ),
        ),
      ),
    );
    //   } else {
    //     return SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           headerShimmer(context),
    //           ShimmerHelper()
    //               .buildProductGridShimmer(scontroller: _scrollController),
    //         ],
    //       ),
    //     );
    //   }
    // });
  }

  /// Section Widget
  Widget _buildProductSmallList1(BuildContext context, List<Product> list) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 283,
          // childAspectRatio: 3 / 2,
        ),
        itemBuilder: (context, index) {
          return Productsmalllist1ItemWidget(
            product: list[index],
          );
        },
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.length,
      ),
    );
  }

  // Container buildFlashDealsBanner(BuildContext context) {
  //   return Container(
  //     //color: MyTheme.amber,
  //     height: 215,
  //     child: TimerCountdown(
  //       timeTextStyle: TextStyle(
  //           color: Colors.red, fontSize: 22, fontWeight: FontWeight.w500),
  //       enableDescriptions: false,
  //       endTime: widget.flashSale!.releasedDate!,
  //       format: CountDownTimerFormat.daysHoursMinutesSeconds,
  //       onEnd: () {
  //         // disappear this flashsale
  //       },
  // ),
  // CountdownTimer(
  //   controller: widget.countdownTimerController,
  //   widgetBuilder: (_, CurrentRemainingTime? time) {
  //     return Stack(
  //       children: [
  //         buildFlashDealBanner(),
  //         Positioned(
  //           bottom: 0,
  //           left: 0,
  //           right: 0,
  //           child: Container(
  //             width: MediaQuery.of(context).size.width,
  //             margin: EdgeInsets.symmetric(horizontal: 18),
  //             decoration:
  //                 BoxDecoration(borderRadius: BorderRadius.circular(5)),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   child: Center(
  //                       child: time == null
  //                           ? Text(
  //                               // AppLocalizations.of(context)!.ended_ucf,
  //                               "end",
  //                               style: TextStyle(
  //                                   color: Colors.lightBlueAccent,
  //                                   fontSize: 16.0,
  //                                   fontWeight: FontWeight.w600),
  //                             )
  //                           : buildTimerRowRow(time)),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     );
  //   },
  // ),
  // );
  // }

  headerShimmer(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // color: MyTheme.amber,
      height: 215,
      child: Stack(
        children: [
          buildFlashDealBannerShimmer(context),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(),
              child: Container(
                child: buildTimerRowRowShimmer(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Container buildFlashDealBanner(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //   return Container(
  //     child: FadeInImage.assetNetwork(
  //       placeholder: 'assets/placeholder_rectangle.png',
  //       image: widget.flashSale!.coverImage!,
  //       fit: BoxFit.cover,
  //       width: size.width,
  //       height: 180,
  //     ),
  //   );
  // }

  Widget buildFlashDealBannerShimmer(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ShimmerHelper().buildBasicShimmerCustomRadius(
        width: size.width, height: 180, color: Colors.lightGreen);
  }

  Widget buildTimerRowRow(DateTime time) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.watch_later_outlined,
            color: Colors.amberAccent,
          ),
          SizedBox(
            width: 10,
          ),
          timerContainer(
            Text(
              timeText(time.day.toString(), default_length: 3),
              style: TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          timerContainer(
            Text(
              timeText(time.hour.toString(), default_length: 2),
              style: TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          timerContainer(
            Text(
              timeText(time.minute.toString(), default_length: 2),
              style: TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          timerContainer(
            Text(
              timeText(time.second.toString(), default_length: 2),
              style: TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Image.network(
            "https://d38b044pevnwc9.cloudfront.net/cutout-nuxt/enhancer/2.jpg",
            height: 20,
            color: Colors.amberAccent,
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget buildTimerRowRowShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.watch_later_outlined,
            color: Colors.amberAccent,
          ),
          SizedBox(
            width: 10,
          ),
          ShimmerHelper().buildBasicShimmerCustomRadius(
              height: 30,
              width: 30,
              radius: BorderRadius.circular(6),
              color: Colors.lightBlueAccent),
          SizedBox(
            width: 4,
          ),
          ShimmerHelper().buildBasicShimmerCustomRadius(
              height: 30,
              width: 30,
              radius: BorderRadius.circular(6),
              color: Colors.lightBlueAccent),
          SizedBox(
            width: 4,
          ),
          ShimmerHelper().buildBasicShimmerCustomRadius(
              height: 30,
              width: 30,
              radius: BorderRadius.circular(6),
              color: Colors.lightBlueAccent),
          SizedBox(
            width: 4,
          ),
          ShimmerHelper().buildBasicShimmerCustomRadius(
              height: 30,
              width: 30,
              radius: BorderRadius.circular(6),
              color: Colors.lightBlueAccent),
          SizedBox(
            width: 10,
          ),
          Image.asset(
            "assets/flash_deal.png",
            height: 20,
            color: Colors.lightBlueAccent,
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget timerContainer(Widget child) {
    return Container(
      constraints: BoxConstraints(minWidth: 30, minHeight: 24),
      child: child,
      alignment: Alignment.center,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.lightBlueAccent,
      ),
    );
  }
}
