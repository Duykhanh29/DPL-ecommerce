import 'dart:io';
import 'package:dpl_ecommerce/customs/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

class RatingScreen extends StatefulWidget {
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<RatingScreen> {
  double rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Rate Product",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,

        //leading: Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            RatingSection(),
            SizedBox(
              height: 30,
            ),
            CommentSection(),
            SizedBox(
              height: 30,
            ),
            ImageUploadSection(),
          ],
        ),
      ),
    );
  }
}

class RatingSection extends StatefulWidget {
  @override
  _RatingSectionState createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  double rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Icon(Icons.gif_box_outlined),
            // Text('Submit your review'),
          ],
        ),
        RatingBar.builder(
          initialRating: rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (newRating) {
            setState(() {
              rating = newRating;
            });
          },
        ),
      ],
    );
  }
}

class CommentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Text('Comment:',style: TextStyle(fontSize: 24),),
          // Thêm TextField hoặc TextFormField cho phần bình luận tại đây
          // Để đơn giản, ở đây chỉ sử dụng một TextFormField để nhập bình luận
          Container(
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(14)),
            child: TextFormField(
              decoration: InputDecoration(
                hintText:
                    ' Would you like to write anything about this product?',
                hintStyle: TextStyle(color: Colors.black87),
              ),
              maxLines: 4,
            ),
          ),
          SizedBox(height: 16),
          // ElevatedButton(
          //   onPressed: () {
          //     // Xử lý khi người dùng nhấn nút gửi bình luận
          //     // Có thể lưu bình luận vào cơ sở dữ liệu hoặc thực hiện các hành động khác
          //   },
          //   child: Text('Gửi bình luận'),
          // ),
        ],
      ),
    );
  }
}

class ImageUploadSection extends StatefulWidget {
  @override
  _ImageUploadSectionState createState() => _ImageUploadSectionState();
}

class _ImageUploadSectionState extends State<ImageUploadSection> {
  File? _image;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Text('Đăng ảnh:'),
        _image == null
            ? Icon(
                Icons.add_a_photo_outlined,
                size: 40,
                color: Colors.black38,
              )
            : Image.file(
                _image!,
                height: 200,
              ),
        SizedBox(
          height: 60,
        ),

        CustomIconButton(
          width: 360,
          height: 80,
          onTap: () {
            getImage();
          },
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add A Photo',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        CustomIconButton(
          width: 360,
          height: 80,
          onTap: () {},
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Submit Review',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
