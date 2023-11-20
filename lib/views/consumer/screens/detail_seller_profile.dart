import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/repositories/category_repo.dart';
import 'package:flutter/material.dart';

class ProfileSeller extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<ProfileSeller> {
  List<Category>? listCategory = CategoryRepo().list;

  Shop shop = Shop(
      name: "Sports World",
      addressInfor: AddressInfor(
          city: "Phan Thiet",
          country: "Viet Nam",
          isDefaultAddress: false,
          latitude: 10.931838,
          longitude: 108.103235,
          name: "My Address 9",
          district: "Phan Thiet City"),
      contactPhone: "0917123456",
      id: "shop09",
      shopDescription:
          "Cultivate your love for gardening with Green Thumb Nursery. We offer a variety of plants, gardening tools, and expert advice to help you create a vibrant and thriving garden.",
      logo:
          "https://t3.ftcdn.net/jpg/01/22/72/98/360_F_122729880_a4rHgPGiwVktwwsovKfL2iqrd2vM042R.jpg",
      rating: 4.0,
      shopView: 70);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop details'),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(shop.logo!),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop.name!,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 230, 207, 6),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(shop.rating != null ? shop.rating.toString() : ""),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: listCategory!.map((category) {
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: category.logo!,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: imageProvider),
                        ),
                      );
                    },
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  title: Text(category.name!),
                );
              }).toList(),
            ),
          ),
        ),
      ]),
    );
  }
}
