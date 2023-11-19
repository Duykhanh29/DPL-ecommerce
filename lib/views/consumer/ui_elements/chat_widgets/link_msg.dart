import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/helpers/cache_image_helper.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/message.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/repositories/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

class LinkMsg extends StatefulWidget {
  LinkMsg({super.key, required this.chat, this.message});
  Message? message;
  Chat? chat;

  @override
  State<LinkMsg> createState() => _LinkMsgState();
}

class _LinkMsgState extends State<LinkMsg> {
  String imageURL = '';
  String title = '';
  UserModel userModel = AuthRepo().user;
  Future getLinkPreview() async {
    http.Response response =
        await http.get(Uri.parse(widget.message!.content!));
    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);
      dom.Element? ogImage =
          document.querySelector('meta[property="og:image"]');
      dom.Element? ogTitle =
          document.querySelector('meta[property="og:title"]');
      String domain = await getDomain(widget.message!.content!);
      if (mounted) {
        setState(() {
          setState(() {
            imageURL = ogImage?.attributes['content'] ?? '';
            title = ogTitle?.attributes['content'] ?? '';
            if (title == '') {
              title = domain;
            }
          });
        });
      }
    }
  }

  Future<String> getDomain(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      var domain = uri.host;
      return domain.startsWith('www.') ? domain.substring(4) : domain;
    }
    return '';
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getLinkPreview();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.15,
      width: size.width * 0.65,
      child: Row(
        mainAxisAlignment: (widget.message!.senderID == userModel.id &&
                (userModel.userInfor!.sellerInfor == null ||
                    !userModel.userInfor!.sellerInfor!.shopIDs!
                        .contains(widget.chat!.shopID)))
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              await launchUrl(Uri.parse(widget.message!.content!));
            },
            child: Container(
              constraints: const BoxConstraints(maxHeight: 220),
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border: Border.all(color: Colors.black54)
                  //   color: Colors.yellow,
                  ),
              child: imageURL == "" || title == ""
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        // if (imageURL == "" || title == "") ...{

                        // } else ...{
                        Container(
                          constraints: const BoxConstraints(maxHeight: 60),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.red, Colors.red],
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Center(
                            child: Text(
                              imageURL,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        imageURL != ""
                            ? CacheImageHelper.showCacheImage(
                                url: imageURL,
                                height: size.height * 0.06,
                                width: size.width * 0.6)
                            : CacheImageHelper.showCacheImage(
                                url:
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhKg8c8MF1uOoEeivmSKS520qWZinQGU3Ojwnc__JYPIAQ92bj3YTQkpFjWd4lH4aew_E&usqp=CAU",
                                height: size.height * 0.06,
                                width: size.width * 0.6),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.cyanAccent, Colors.cyanAccent],
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          height: 48,
                          // constraints:
                          //     const BoxConstraints(maxHeight: 48),
                          child: Text(
                            title,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                        //  }
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
