import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  final String name1;

  Category({required this.name, required this.icon, required this.name1});
}

class ProfileSeller extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<ProfileSeller> {
  List<Category> categories = [
    Category(name: 'Evaluate', icon: Icons.star_border_outlined,name1: '100'),
    Category(name: 'Products ', icon: Icons.propane_outlined,name1: '100'),
    Category(name: 'Address', icon: Icons.location_pin,name1: '100'),
    Category(name: 'Category ', icon: Icons.category,name1: '100'),
    Category(name: 'Category ', icon: Icons.category,name1: '100'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop details'),
         centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         SizedBox(height: 10,),
           Row(
             children: [
               SizedBox(width: 10,),
               CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(
                                    "https://s3.o7planning.com/images/boy-128.png"),
                              ),
                              SizedBox(
                          width: 12,
                        ),
                        Column(
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
                                  Text("900k followers")
                                ],
                              ),
                            ],
                          ),
             ],
           ),
          Container(
            width: 200,
            height: 300,
            child: Column(
              children: categories.map((category) {
                return ListTile(
                  leading: Icon(category.icon),

                  title: Text(category.name),
                  trailing: Text(category.name1,style: TextStyle(color: Colors.blue),),
                  
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}