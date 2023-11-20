// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
// import 'package:dpl_ecommerce/repositories/category_repo.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:dpl_ecommerce/models/category.dart';

// import 'package:intl/intl.dart' as intl;

// enum ImageSource {
//   /// Opens up the device camera, letting the user to take a new picture.
//   camera,

//   /// Opens the user's photo gallery.
//   gallery,
// }
// class NewProduct extends StatefulWidget {
//   const NewProduct({Key? key}) : super(key: key);

//   @override
//   State<NewProduct> createState() => _NewProductState();
// }

// class _NewProductState extends State<NewProduct> {
//   // double variables

//   String _statAndEndTime = "Select Date";

//   double mHeight = 0.0, mWidht = 0.0;
//   int _selectedTabIndex = 0;
//   bool isColorActive = false;
//   bool isRefundable = false;
//   bool isCashOnDelivery = false;
//   bool isProductQuantityMultiply = false;
//  // bool isFeatured = false;
//   bool isTodaysDeal = false;


//   List<Category> categories = [];
//   List<CommonDropDownItem> brands = [];
//   List<VatTaxViewModel> vatTaxList = [];
//   List<CommonDropDownItem> videoType = [];
//   List<CommonDropDownItem> addToFlashType = [];
//   List<CommonDropDownItem> discountTypeList = [];
//   List<CommonDropDownItem> colorList = [];
//   List<CommonDropDownItem> selectedColors = [];
//   List<AttributesModel> attribute = [];
//   List<AttributesModel> selectedAttributes = [];
//   List<VariationModel> productVariations = [];
//   List<CustomRadioModel> shippingConfigurationList = [];
//   List<CustomRadioModel> stockVisibilityStateList = [];
//   late CustomRadioModel selectedShippingConfiguration;
//   late CustomRadioModel selectedstockVisibilityState;

//   Category? selectedCategory;
//   CommonDropDownItem? selectedBrand;

//   CommonDropDownItem? selectedVideoType;
//   CommonDropDownItem? selectedAddToFlashType;
//   CommonDropDownItem? selectedFlashDiscountType;
//   CommonDropDownItem? selectedProductDiscountType;
//   CommonDropDownItem? selectedColor;
//   AttributesModel? selectedAttribute;

//   //Product value

//   String? productName,
//       categoryId,
//       brandId,
//       unit,
//       weight,
//       minQuantity,
//       refundable,
//       barcode,
//       photos,
//       thumbnailImg,
//       videoProvider,
//       videoLink,
//       colorsActive,
//       unitPrice,
//       dateRange,
//       discount,
//       discountType,
//       currentStock,
//       sku,
//       externalLink,
//       externalLinkBtn,
//       description,
//       pdf,
//       metaTitle,
//       metaDescription,
//       metaImg,
//       shippingType,
//       flatShippingCost,
//       lowStockQuantity,
//       stockVisibilityState,
//       cashOnDelivery,
//       estShippingDays,
//       button;
//   var tagMap=[];
//   List<String?>? tags = [],
//       colors,
//       choiceAttributes,
//       choiceNo,
//       choice,
//       choiceOptions2,
//       choiceOptions1,
//       taxId,
//       tax,
//       taxType;

//   Map choice_options = Map();

//   ImagePicker pickImage = ImagePicker();

//   List<FileInfo> productGalleryImages = [];
//   FileInfo? thumbnailImage;
//   FileInfo? metaImage;
//   FileInfo? pdfDes;

//   DateTimeRange? dateTimeRange =
//       DateTimeRange(start: DateTime.now(), end: DateTime.now());

//   //Edit text controller
//   TextEditingController productNameEditTextController = TextEditingController();
//   TextEditingController unitEditTextController = TextEditingController();
//   TextEditingController weightEditTextController =
//       TextEditingController(text: "0.0");
//   TextEditingController minimumEditTextController =
//       TextEditingController(text: "1");
//   TextEditingController tagEditTextController = TextEditingController();
//   TextEditingController barcodeEditTextController = TextEditingController();
//   TextEditingController taxEditTextController = TextEditingController();
//   TextEditingController videoLinkEditTextController = TextEditingController();
//   TextEditingController metaTitleEditTextController = TextEditingController();
//   TextEditingController metaDescriptionEditTextController =
//       TextEditingController();
//   TextEditingController shippingDayEditTextController = TextEditingController();
//   TextEditingController productDiscountEditTextController =
//       TextEditingController(text: "0");
//   TextEditingController flashDiscountEditTextController =
//       TextEditingController();
//   TextEditingController unitPriceEditTextController =
//       TextEditingController(text: "0");
//   TextEditingController productQuantityEditTextController =
//       TextEditingController(text: "0");
//   TextEditingController skuEditTextController = TextEditingController();
//   TextEditingController externalLinkEditTextController =
//       TextEditingController();
//   TextEditingController externalLinkButtonTextEditTextController =
//       TextEditingController();
//   TextEditingController stockLowWarningTextEditTextController =
//       TextEditingController();
//   TextEditingController variationPriceTextEditTextController =
//       TextEditingController();
//   TextEditingController variationQuantityTextEditTextController =
//       TextEditingController();
//   TextEditingController variationSkuTextEditTextController =
//       TextEditingController();
//   TextEditingController flatShippingCostTextEditTextController =
//       TextEditingController();
//   TextEditingController lowStockQuantityTextEditTextController =
//       TextEditingController(text: "1");
//   TextEditingController _TextEditTextController = TextEditingController();

//   GlobalKey<FlutterSummernoteState> productDescriptionKey = GlobalKey();

//   getCategories() async {
//     var categoryResponse = await CategoryRepo().list;
//     setState(() {});
//   }





//   // getColors() async {
//   //   var colorRes = await ProductRepository().getColorsRes();
//   //   colorRes.data!.forEach((element) {
//   //     colorList.add(CommonDropDownItem("${element.code}", "${element.name}"));
//   //   });

//   //   setState(() {});
//   // }



 
  
//   fetchAll() {
//     getCategories();
//     // getBrands();
//     // getTaxType();
//     // getColors();
//     // getAttributes();
//     // setConstDropdownValues();
//   }

//   pickGalleryImages() async {
//     var tmp = productGalleryImages;
//     List<FileInfo>? images = await Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => UploadFile(
//                   fileType: "image",
//                   canSelect: true,
//                   canMultiSelect: true,
//                   prevData: tmp,
//                 )));
//     // print(images != null);
//     if (images != null) {
//       productGalleryImages = images;
//       setChange();
//     }
//   }

//   Future<XFile?> pickSingleImage() async {
//     return await pickImage.pickImage(source: ImageSource.gallery);
//   }
  

 
 

//   setProductPhotoValue() {
//     photos = "";
//     for (int i = 0; i < productGalleryImages.length; i++) {
//       if (i != (productGalleryImages.length - 1)) {
//         photos = "$photos "+"${productGalleryImages[i].id},";
//       } else {
//         photos = "$photos "+"${productGalleryImages[i].id}";
//       }
//     }
//   }

//   // setColors() {
//   //   colors = [];
//   //   selectedColors.forEach((element) {
//   //     colors!.add(element.key);
//   //   });
//   // }

//   setChoiceAtt() {
//     choiceAttributes = [];
//     choiceNo = [];
//     choice = [];
//     if (choice_options != null) choice_options.clear();

//     selectedAttributes.forEach((element) {
//       choiceAttributes!.add(element.name.key);
//       choiceNo!.add(element.name.key);
//       choice!.add(element.name.value);

//       List<String?> tmpValue = [];
//       element.selectedAttributeItems.forEach((attributes) {
//         tmpValue.add(attributes.value);
//       });
//       choice_options.addAll({"choice_options_${element.name.key}": tmpValue});
//     });

//     choiceAttributes!.sort();
//   }



//   setProductValues() async {
//     productName = productNameEditTextController.text.trim();
//     categoryId = selectedCategory!.id;

//     if (selectedBrand != null) brandId = selectedBrand!.key;

//     unit = unitEditTextController.text.trim();
//     weight = weightEditTextController.text.trim();
//     minQuantity = minimumEditTextController.text.trim();

//     tagMap.clear();
//     tags!.forEach((element) {
//       tagMap.add(jsonEncode({"value":'$element'}));
//     });
//     // add product photo
//     setProductPhotoValue();
//     if (thumbnailImage != null) thumbnailImg = "${thumbnailImage!.id}";
//     videoProvider = selectedVideoType!.key;
//     videoLink = videoLinkEditTextController.text.trim().toString();
//     //Set colors
//     setColors();
//     colorsActive = isColorActive ? "1" : "0";
//     unitPrice = unitPriceEditTextController.text.trim().toString();
//     dateRange =
//         dateTimeRange!.start.toString() + " to " + dateTimeRange!.end.toString();
//     discount = productDiscountEditTextController.text.trim().toString();
//     discountType = selectedProductDiscountType!.key;
//     currentStock = productVariations.isEmpty
//         ? productQuantityEditTextController.text.trim().toString()
//         : "0";
//     sku = productVariations.isEmpty
//         ? skuEditTextController.text.trim().toString()
//         : null;
//     externalLink = externalLinkEditTextController.text.trim().toString();
//     externalLinkBtn =
//         externalLinkButtonTextEditTextController.text.trim().toString();

//     if (productDescriptionKey.currentState != null) {
//       description = await productDescriptionKey.currentState!.getText() ?? "";
//       description = await productDescriptionKey.currentState!.getText() ?? "";
//     }

//     if (pdfDes != null) pdf = "${pdfDes!.id}";
//     metaTitle = metaTitleEditTextController.text.trim().toString();
//     metaDescription = metaDescriptionEditTextController.text.trim().toString();
//     if (metaImage != null) metaImg = "${metaImage!.id}";
//     shippingType = selectedShippingConfiguration.key;
//     flatShippingCost =
//         flatShippingCostTextEditTextController.text.trim().toString();
//     lowStockQuantity =
//         lowStockQuantityTextEditTextController.text.trim().toString();
//     stockVisibilityState = selectedstockVisibilityState.key;
//     cashOnDelivery = isCashOnDelivery ? "1" : "0";
//     estShippingDays = shippingDayEditTextController.text.trim().toString();
//     // get taxes
//     refundable = isRefundable ? "1" : "0";
//   }

//   bool requiredFieldVerification() {
//     if (productNameEditTextController.text.trim().toString().isEmpty) {
//       // ToastComponent.showDialog("Product Name Required", gravity: Toast.center);
//       return false;
//     } else if (selectedCategory == null) {
//       // ToastComponent.showDialog("Product Category Required",gravity: Toast.center);
//       return false;
//     } else if (minimumEditTextController.text.trim().toString().isEmpty) {
//       // ToastComponent.showDialog("Product Minimum Quantity Required",gravity: Toast.center);
//       return false;
//     } else if (unitEditTextController.text.trim().toString().isEmpty) {
//       // ToastComponent.showDialog("Product Unit Required",gravity: Toast.center);
//       return false;
//     }
//     return true;
//   }

//   submitProduct(String button) async {
//     if (!requiredFieldVerification()) {
//       return;
//     }

//     // Loading().show();

//   await  setProductValues();
//     setChoiceAtt();
//     Map postValue = Map();
//     postValue.addAll({
//       "name": productName,
//       "category_id": categoryId,
//       "brand_id": brandId,
//       "unit": unit,
//       "weight": weight,
//       "min_qty": minQuantity,
//       "tags": [tagMap.toString()],
//       "photos": photos,
//       "thumbnail_img": thumbnailImg,
//       "video_provider": videoProvider,
//       "video_link": videoLink,
//       "colors": colors,
//       "colors_active": colorsActive,
//       "choice_attributes": choiceAttributes,
//       "choice_no": choiceNo,
//       "choice": choice
//     });

//     postValue.addAll(choice_options);
   

//     postValue.addAll({
//       "unit_price": unitPrice,
//       "date_range": int.parse(discount!)<=0?null:dateRange,
//       "discount": discount,
//       "discount_type": discountType,
//       "current_stock": currentStock,
//       "sku": sku,
//       "external_link": externalLink,
//       "external_link_btn": externalLinkBtn,
//     });
//     postValue.addAll(makeVariationMap());


//     postValue.addAll({
//       "description": description,
//       "pdf": pdf,
//       "meta_title": metaTitle,
//       "meta_description": metaDescription,
//       "meta_img": metaImg,
//       "low_stock_quantity": lowStockQuantity,
//       "stock_visibility_state": stockVisibilityState,
//       "cash_on_delivery": cashOnDelivery,
//       "est_shipping_days": estShippingDays,
//       "tax_id": taxId,
//       "tax": tax,
//       "tax_type": taxType,
//       "button": button,
//     });

//     var postBody = jsonEncode(postValue);

//     var response = await ProductRepository().addProductResponse(postBody);

//     if (response.result !=null &&response.result! ) {
//       ToastComponent.showDialog(response.message, gravity: Toast.center);

//       Navigator.pop(context);
//     } else {
//       dynamic errorMessages = response.message;
//       if(errorMessages.runtimeType == String){
//         // ToastComponent.showDialog(errorMessages, gravity: Toast.center);
//       }else {
//         // ToastComponent.showDialog(
//             // errorMessages.join(","), gravity: Toast.center);
//       }
//     }
//   }

//   Map makeVariationMap() {
//     Map variation = Map();
//     productVariations.forEach((element) {
//       variation.addAll({
//         "price_" + element.name!.replaceAll(" ", "-"):
//             element.priceEditTextController.text.trim().toString() ?? null,
//         "sku_" + element.name!.replaceAll(" ", "-"):
//             element.skuEditTextController.text.trim().toString() ?? null,
//         "qty_" + element.name!.replaceAll(" ", "-"):
//             element.quantityEditTextController.text.trim().toString() ?? null,
//         "img_" + element.name!.replaceAll(" ", "-"):
//             element.photo == null ? null : element.photo!.id,
//       });
//     });
//     return variation;
//   }

//   @override
//   void initState() {

//     fetchAll();

//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     mHeight = MediaQuery.of(context).size.height;
//     mWidht = MediaQuery.of(context).size.width;
//     return  Scaffold(
//         appBar: AppBar(
//           leading: CustomArrayBackWidget(),
//           title: const Text("Add new product"),
//         ),
//         body: SingleChildScrollView(child: buildBodyContainer()),
//         bottomNavigationBar: buildBottomAppBar(context),
      
//     );
//   }

//   Widget buildBodyContainer() {
//     return changeMainContent(_selectedTabIndex);
//   }

//   BottomAppBar buildBottomAppBar(BuildContext context) {
//     return BottomAppBar(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//               color: Colors.green,
//               width: mWidht / 2,
//               child: Buttons(onPressed: () async {
//                 submitProduct("unpublish");
//               },
//                   child: Text(
//                     LangText(context: context)
//                         .getLocal()!
//                         .save_n_unpublish_ucf,
//                     style: TextStyle(color: MyTheme.white),
//                   ))),
//           Container(
//               color: MyTheme.app_accent_color,
//               width: mWidht / 2,
//               child: Buttons(onPressed: () async {
//                 submitProduct("publish");
//               },
//                child:   Text(
//                       LangText(context: context)
//                           .getLocal()!
//                           .save_n_publish_ucf,
//                       style: TextStyle(color: MyTheme.white))))
//         ],
//       ),
//     );
//   }

//   changeMainContent(int index) {
//     switch (index) {
//       case 0:
//         return buildGeneral();
//         break;
//       case 1:
//         return buildMedia();
//         break;
//       case 2:
//         return buildPriceNStock();
//         break;
//       case 3:
//         return buildSEO();
//         break;
//       default:
//         return SizedBox();
//     }
//   }

//   Widget buildGeneral() {
//     return buildTabViewItem(
//       "Product infor",
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           buildEditTextField(
//             "product name",
//             "product name",
//             productNameEditTextController,
//             isMandatory: true,
//           ),
//           itemSpacer(),
//           _buildCategoryDropDown(
//               "Category",
//               (value) {
//             selectedCategory = value;
//             setChange();
//           }, selectedCategory, categories, isMandatory: true),
         
//           itemSpacer(),
       
   
        
//           buildGroupItems(
//               "product description",
//               summerNote("product description")),
//           itemSpacer(),
          
//         ],
//       ),
//     );
//   }

//   Widget buildVatTax(title, TextEditingController controller, onChangeDropDown,
//       CommonDropDownItem? selectedDropdown, List<CommonDropDownItem> iteams) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 24.0),
//       child: Row(
//         children: [
//           SizedBox(
//             width: (mWidht / 2) - 25,
//             child: buildEditTextField(title, "0", controller),
//           ),
//           Spacer(),
//           _buildDropDownField("", (newValue) {
//             onChangeDropDown(newValue);
//             setChange();
//           }, selectedDropdown, iteams, width: (mWidht / 2) - 25),
//         ],
//       ),
//     );
//   }

//   Widget buildMedia() {
//     return buildTabViewItem(
//       LangText(context: context).getLocal()!.product_images_ucf,
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           chooseGalleryImageField(),
//           itemSpacer(),
//           chooseSingleImageField(
//               LangText(context: context)
//                   .getLocal()!
//                   .thumbnail_image_300_ucf,
//               LangText(context: context)
//                   .getLocal()!
//                   .thumbnail_image_300_des, (onChosenImage) {
//             thumbnailImage = onChosenImage;
//             setChange();
//           }, thumbnailImage),
//           itemSpacer(),
//           buildGroupItems(
//               LangText(context: context)
//                   .getLocal()!
//                   .product_videos_ucf,
//               _buildDropDownField(
//                   LangText(context: context)
//                       .getLocal()!
//                       .video_provider_ucf, (newValue) {
//                 selectedVideoType = newValue;
//                 setChange();
//               }, selectedVideoType, videoType)),
//           itemSpacer(),
//           buildEditTextField(
//               LangText(context: context)
//                   .getLocal()!
//                   .video_link_ucf,
//               LangText(context: context)
//                   .getLocal()!
//                   .video_link_ucf,
//               videoLinkEditTextController),
//           itemSpacer(height: 10),
//           smallTextForMessage(LangText(context: context)
//               .getLocal()!
//               .video_link_des),
//           itemSpacer(),
//           buildGroupItems(
//               LangText(context: context)
//                   .getLocal()!
//                   .pdf_description_ucf,
//               chooseSingleFileField(
//                   LangText(context: context)
//                       .getLocal()!
//                       .pdf_specification_ucf,
//                   "", (onChosenFile) {
//                 pdfDes = onChosenFile;
//                 setChange();
//               }, pdfDes)),
//           itemSpacer()
//         ],
//       ),
//     );
//   }

//   Widget buildPriceNStock() {
//     return buildTabViewItem(
//       "",
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           buildPriceEditTextField(
//               'Giá Bán Lẻ',
//               "0"),
//           itemSpacer(),
//           buildGroupItems(
//               "Phạm Vi Ngày Giảm Giá",
//               Container(
//                 height: 45,
//                 width: mWidht,
//                 // decoration: MDecoration.decoration1(),
//                 child: ElevatedButton(
//                 onPressed:   () async {
//                     dateTimeRange = await _buildPickDate();

//                     _statAndEndTime = intl.DateFormat('MM/d/y')
//                             .format(dateTimeRange!.start)
//                             .toString() +
//                         " - " +
//                         intl.DateFormat('MM/d/y')
//                             .format(dateTimeRange!.end)
//                             .toString();
//                     setChange();
//                   },
                 
//                  child: Text(
//                     _statAndEndTime,
//                     style: TextStyle(fontSize: 12),
//                   ),
//                 ),
//               )),

//           itemSpacer(),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 width: (mWidht / 2) - 20,
//                 child: buildEditTextField(
//                     'Giảm Giá',
//                     "0",
//                     productDiscountEditTextController,
//                     isMandatory: true),
//               ),
//               Spacer(),
//               SizedBox(
//                 width: (mWidht / 2) - 20,
//                 child: _buildDropDownField('', (onchange) {
//                   selectedProductDiscountType = onchange;
//                   setChange();
//                 }, selectedProductDiscountType, discountTypeList),
//               ),
//             ],
//           ),

//           if (productVariations.isEmpty)
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 itemSpacer(),
//                 buildEditTextField(
//                     'quantity',
//                     "0",
//                     productQuantityEditTextController,
//                     isMandatory: true),
//                 itemSpacer(),
               
//               ],
//             ),
//           itemSpacer(),
         
         
          
         
        
           
//           buildGroupItems(
//               LangText(context: context)
//                   .getLocal()!
//                   .product_variation_ucf,
//               SizedBox()),
//           // if (false)
//           Row(
//             children: [
//               buildFieldTitle(LangText(context: context)
//                   .getLocal()!
//                   .colors_ucf),
//               Spacer(),
//               Switch(
//                   activeColor: MyTheme.green,
//                   value: isColorActive,
//                   onChanged: (onChanged) {
//                     isColorActive = onChanged;
//                     selectedColors.clear();
//                     selectedColor = null;
//                     createProductVariation();
//                     setChange();
//                   })
//             ],
//           ),
//           if (isColorActive)
//             Column(
//               children: [
//                 _buildColorDropDown((value) {
//                   selectedColor = value;
//                   if (!selectedColors.contains(value)) {
//                     selectedColors.add(value);
//                   }
//                   setChange();
//                   createProductVariation();
//                 }, selectedColor, colorList),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 buildShowSelectedOptions(selectedColors, (index) {
//                   selectedColors.removeAt(index);
//                   setChange();
//                   createProductVariation();
//                 })
//               ],
//             ),

//           itemSpacer(),
//           buildCommonSingleField(
//               LangText(context: context)
//                   .getLocal()!
//                   .attributes_ucf,
//               Container(
//                 width: mWidht,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//                 decoration: MDecoration.decoration1(),
//                 child: DropdownButton<AttributesModel>(
//                   isDense: true,
//                   underline: Container(),
//                   isExpanded: true,
//                   onChanged: (AttributesModel? value) {
//                     selectedAttribute = value;

//                     var tmp = selectedAttributes
//                         .where((element) => element.name.key == value!.name.key);

//                     if (tmp.isEmpty) {
//                       selectedAttributes.add(AttributesModel(
//                           value!.name, value.attributeItems, [], null));
//                     }
//                     createProductVariation();
//                     setChange();
//                   },
//                   icon: const Icon(Icons.arrow_drop_down),
//                   value: selectedAttribute,
//                   items: attribute
//                       .map(
//                         (value) => DropdownMenuItem<AttributesModel>(
//                           value: value,
//                           child: Text(
//                             value.name.value!,
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               )),

//           if (selectedAttributes.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(top: 14.0),
//               child: Column(
//                 children: List.generate(selectedAttributes.length, (index) {
//                   return buildAttributeModelView(
//                       index,
//                       selectedAttributes[index].name.value,
//                       selectedAttributes[index].attributeItems,
//                       selectedAttributes[index].selectedAttributeItem,
//                       (onchange) {
//                     selectedAttributes[index].selectedAttributeItem = onchange;
//                     if (!selectedAttributes[index]
//                         .selectedAttributeItems
//                         .contains(onchange)) {
//                       selectedAttributes[index]
//                           .selectedAttributeItems
//                           .add(onchange);
//                     }
//                     setChange();
//                     createProductVariation();
//                   }, (removeIndex) {
//                     selectedAttributes.removeAt(removeIndex);
//                     setChange();
//                     createProductVariation();
//                   });
//                 }),
//               ),
//             ),

//           itemSpacer(),

//           ListView.separated(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemBuilder: (context, index) => variationViewModel(index),
//               separatorBuilder: (context, index) => itemSpacer(),
//               itemCount: productVariations.length),
//           itemSpacer()
//         ],
//       ),
//     );
//   }

//   Widget buildSEO() {
//     return buildTabViewItem(
//       LangText(context: context).getLocal()!.seo_all_capital,
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           buildEditTextField(
//             LangText(context: context).getLocal()!.meta_title_ucf,
//             LangText(context: context).getLocal()!.meta_title_ucf,
//             metaTitleEditTextController,
//             isMandatory: false,
//           ),
//           itemSpacer(),
//           buildGroupItems(
//             LangText(context: context)
//                 .getLocal()!
//                 .description_ucf,
//             Container(
//                 padding: EdgeInsets.all(8),
//                 height: 150,
//                 width: mWidht,
//                 decoration: MDecoration.decoration1(),
//                 child: TextField(
//                     controller: metaDescriptionEditTextController,
//                     keyboardType: TextInputType.multiline,
//                     minLines: 1,
//                     maxLines: 50,
//                     enabled: true,
//                     style: TextStyle(fontSize: 12),
//                     decoration: InputDecoration.collapsed(
//                         hintText: LangText(context: context)
//                             .getLocal()!
//                             .description_ucf))),
//           ),
//           itemSpacer(),
//           chooseSingleImageField(
//               LangText(context: context)
//                   .getLocal()!
//                   .meta_image_ucf,
//               "", (onChosenImage) {
//             metaImage = onChosenImage;
//             setChange();
//           }, metaImage),
//           itemSpacer()
//         ],
//       ),
//     );
//   }

//   Widget buildShipping() {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(
//             left: AppStyles.itemMargin,
//             right: AppStyles.itemMargin,
//             top: AppStyles.itemMargin,
//           ),
//           child: Container(
//             width: DeviceInfo(context).getWidth(),
//             padding: EdgeInsets.all(AppStyles.itemMargin),
//             decoration: MDecoration.decoration1(),
//             child: buildGroupItems(
//                 LangText(context: context)
//                     .getLocal()!
//                     .shipping_configuration_ucf,
//               shipping_type.$?
//                 Column(
//                   children: [
//                     Column(
//                       children: List.generate(
//                           shippingConfigurationList.length,
//                           (index) => buildSwitchField(
//                                   shippingConfigurationList[index].title,
//                                   shippingConfigurationList[index].isActive,
//                                   (changedValue) {
//                                 shippingConfigurationList.forEach((element) {
//                                   if (element.key ==
//                                       shippingConfigurationList[index].key) {
//                                     shippingConfigurationList[index].isActive =
//                                         true;
//                                   } else {
//                                     element.isActive = false;
//                                   }
//                                 });
//                                 selectedShippingConfiguration =
//                                     shippingConfigurationList[index];
//                                 setChange();
//                                 print(selectedShippingConfiguration.key);
//                               })),
//                     ),
//                     if (selectedShippingConfiguration.key == "flat_rate")
//                       Row(
//                         children: [
//                           Text(LangText(context: context)
//                               .getLocal()!
//                               .shipping_cost_ucf),
//                           Spacer(),
//                           Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 color: MyTheme.white),
//                             width: (mWidht * 0.5),
//                             height: 46,
//                             child: TextField(
//                               keyboardType: TextInputType.number,
//                               controller:
//                                   flatShippingCostTextEditTextController,
//                               decoration:
//                                   InputDecorations.buildInputDecoration_1(
//                                       fillColor: MyTheme.noColor,
//                                       hint_text: "0",
//                                       borderColor: MyTheme.light_grey,
//                                       hintTextColor: MyTheme.grey_153),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           )
//                         ],
//                       )
//                   ],
//                 ):Container(child: Text(LangText(context: context).getLocal()!.shipping_configuration_is_maintained_by_admin,style: MyTextStyle.normalStyle(),),)),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(
//             left: AppStyles.itemMargin,
//             right: AppStyles.itemMargin,
//             top: AppStyles.itemMargin,
//           ),
//           child: Container(
//             padding: EdgeInsets.all(AppStyles.itemMargin),
//             decoration: MDecoration.decoration1(),
//             child: buildGroupItems(
//                 LangText(context: context)
//                     .getLocal()!
//                     .estimate_shipping_time_ucf,
//                 buildGroupItems(
//                   LangText(context: context)
//                       .getLocal()!
//                       .shipping_days_ucf,
//                   MyWidget().myContainer(
//                       width: DeviceInfo(context).getWidth(),
//                       height: 46,
//                       borderRadius: 6.0,
//                       borderColor: MyTheme.light_grey,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: mWidht / 2,
//                             padding: const EdgeInsets.only(left: 14.0),
//                             child: TextField(
//                               keyboardType: TextInputType.number,
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.allow(
//                                     RegExp(r'[0-9]'))
//                               ],
//                               controller: shippingDayEditTextController,
//                               style: TextStyle(
//                                   fontSize: 12, color: MyTheme.font_grey),
//                               decoration:
//                                   InputDecoration.collapsed(hintText: "0"),
//                             ),
//                           ),
//                           Container(
//                               alignment: Alignment.center,
//                               height: 46,
//                               width: 80,
//                               color: MyTheme.light_grey,
//                               child: Text(
//                                 "Days",
//                                 style: TextStyle(
//                                     fontSize: 12, color: MyTheme.grey_153),
//                               )),
//                         ],
//                       )),
//                 )),
//           ),
//         )
//       ],
//     );
//   }
// /*
//   Widget buildMarketing() {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(
//             left: AppStyles.itemMargin,
//             right: AppStyles.itemMargin,
//             top: AppStyles.itemMargin,
//           ),
//           child: Container(
//             padding: EdgeInsets.all(AppStyles.itemMargin),
//             decoration: MDecoration.decoration1(),
//             child: buildGroupItems(
//               LangText(context: context).getLocal().product_add_screen_featured,
//               Container(
//                 child: Column(
//                   children: [
//                     buildSwitchField(
//                         LangText(context: context)
//                             .getLocal()
//                             .product_add_screen_status,
//                         isFeatured, (changedValue) {
//                       isFeatured = changedValue;
//                       setChange();
//                     }),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(
//             left: AppStyles.itemMargin,
//             right: AppStyles.itemMargin,
//             top: AppStyles.itemMargin,
//           ),
//           child: Container(
//             padding: EdgeInsets.all(AppStyles.itemMargin),
//             decoration: MDecoration.decoration1(),
//             child: buildGroupItems(
//                 LangText(context: context)
//                     .getLocal()
//                     .product_add_screen_todays_deal,
//                 Container(
//                   child: Column(
//                     children: [
//                       buildSwitchField(
//                           LangText(context: context)
//                               .getLocal()
//                               .product_add_screen_status,
//                           isTodaysDeal, (changedValue) {
//                         isTodaysDeal = changedValue;
//                         setChange();
//                       }),
//                     ],
//                   ),
//                 )),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(
//             left: AppStyles.itemMargin,
//             right: AppStyles.itemMargin,
//             top: AppStyles.itemMargin,
//           ),
//           child: Container(
//             padding: EdgeInsets.all(AppStyles.itemMargin),
//             decoration: MDecoration.decoration1(),
//             child: buildGroupItems(
//               LangText(context: context)
//                   .getLocal()
//                   .product_add_screen_flash_deal,
//               Column(
//                 children: [
//                   _buildFlatDropDown(
//                       LangText(context: context)
//                           .getLocal()
//                           .product_add_screen_add_to_flash, (onchange) {
//                     selectedAddToFlashType = onchange;
//                     setChange();
//                   }, selectedAddToFlashType, addToFlashType),
//                   itemSpacer(),
//                   buildFlatEditTextField(
//                       LangText(context: context)
//                           .getLocal()
//                           .product_add_screen_discount,
//                       "0",
//                       flashDiscountEditTextController),
//                   itemSpacer(),
//                   _buildFlatDropDown(
//                       LangText(context: context)
//                           .getLocal()
//                           .product_add_screen_discount_type, (onchange) {
//                     selectedFlashDiscountType = onchange;
//                     setChange();
//                   }, selectedFlashDiscountType, discountTypeList),
//                   itemSpacer(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         itemSpacer()
//       ],
//     );
//   }*/

//   Widget buildTabViewItem(String title, Widget children) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: AppStyles.itemMargin,
//         right: AppStyles.itemMargin,
//         top: AppStyles.itemMargin,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (title.isNotEmpty)
//             Text(
//               title,
//               style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: MyTheme.font_grey),
//             ),
//           const SizedBox(
//             height: 16,
//           ),
//           children,
//         ],
//       ),
//     );
//   }

//   Widget buildAttributeModelView(
//       index,
//       attributeName,
//       List<CommonDropDownItem> attributesValues,
//       selectedValue,
//       dynamic onchange,
//       dynamic remove) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(
//                 width: mWidht * 0.15, child: buildFieldTitle(attributeName)),
//             Container(
//               width: mWidht * 0.6,
//               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//               decoration: MDecoration.decoration1(),
//               child: DropdownButton<CommonDropDownItem>(
//                 isDense: true,
//                 underline: Container(),
//                 isExpanded: true,
//                 onChanged: (CommonDropDownItem? value) {
//                   onchange(value);
//                 },
//                 icon: const Icon(Icons.arrow_drop_down),
//                 value: selectedValue,
//                 items: attributesValues
//                     .map(
//                       (value) => DropdownMenuItem<CommonDropDownItem>(
//                         value: value,
//                         child: Text(
//                           value.value!,
//                         ),
//                       ),
//                     )
//                     .toList(),
//               ),
//             ),
//             Container(
//               width: mWidht * 0.10,
//               child: IconButton(
//                   onPressed: () {
//                     remove(index);
//                   },
//                   icon: Icon(
//                     Icons.delete,
//                     color: MyTheme.red,
//                   )),
//             )
//           ],
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         buildShowSelectedOptions(
//             selectedAttributes[index].selectedAttributeItems, (deleteIndex) {
//           selectedAttributes[index]
//               .selectedAttributeItems
//               .removeAt(deleteIndex);
//           setChange();
//           createProductVariation();
//         })
//       ],
//     );
//   }

//   Widget buildGroupItems(groupTitle, Widget children) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildGroupTitle(groupTitle),
//         itemSpacer(height: 14.0),
//         children,
//       ],
//     );
//   }

//   Text buildGroupTitle(title) {
//     return Text(
//       title,
//       style: const TextStyle(
//           fontSize: 14, fontWeight: FontWeight.bold, color: MyTheme.font_grey),
//     );
//   }

//   Widget chooseGalleryImageField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               LangText(context: context)
//                   .getLocal()!
//                   .gallery_images_600,
//               style: TextStyle(
//                   fontSize: 12,
//                   color: MyTheme.font_grey,
//                   fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Buttons(
//               padding: EdgeInsets.zero,
//               onPressed: () {
//                 pickGalleryImages();
//               },
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6)),
//               child: MyWidget().myContainer(
//                   width: DeviceInfo(context).getWidth(),
//                   height: 46,
//                   borderRadius: 6.0,
//                   borderColor: MyTheme.light_grey,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 14.0),
//                         child: Text(
//                           "Choose file",
//                           style:
//                               TextStyle(fontSize: 12, color: MyTheme.grey_153),
//                         ),
//                       ),
//                       Container(
//                           alignment: Alignment.center,
//                           height: 46,
//                           width: 80,
//                           color: MyTheme.light_grey,
//                           child: Text(
//                             "Browse",
//                             style: TextStyle(
//                                 fontSize: 12, color: MyTheme.grey_153),
//                           )),
//                     ],
//                   )),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Text(
//           LangText(context: context)
//               .getLocal()!
//               .these_images_are_visible_in_product_details_page_gallery_600,
//           style: TextStyle(fontSize: 8, color: MyTheme.grey_153),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         if (productGalleryImages.isNotEmpty)
//           Wrap(
//             children: List.generate(
//               productGalleryImages.length,
//               (index) => Stack(
//                 children: [
//                   MyWidget.imageWithPlaceholder(
//                       height: 60.0,
//                       width: 60.0,
//                       url: productGalleryImages[index].url),
//                   Positioned(
//                     top: 0,
//                     right: 5,
//                     child: Container(
//                       height: 15,
//                       width: 15,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           color: MyTheme.white),
//                       child: InkWell(
//                         onTap: () {
//                           print(index);
//                           productGalleryImages.removeAt(index);
//                           setState(() {});
//                         },
//                         child: Icon(
//                           Icons.close,
//                           size: 12,
//                           color: MyTheme.red,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget chooseSingleImageField(String title, String shortMessage,
//       dynamic onChosenImage, FileInfo? selectedFile) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                   fontSize: 12,
//                   color: MyTheme.font_grey,
//                   fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             imageField(shortMessage, onChosenImage, selectedFile)
//           ],
//         ),
//       ],
//     );
//   }

//   Widget chooseSingleFileField(String title, String shortMessage,
//       dynamic onChosenFile, FileInfo? selectedFile) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                   fontSize: 12,
//                   color: MyTheme.font_grey,
//                   fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             fileField("document", shortMessage, onChosenFile, selectedFile)
//           ],
//         ),
//       ],
//     );
//   }

//   Widget buildShowSelectedOptions(
//       List<CommonDropDownItem> options, dynamic remove) {
//     return SizedBox(
//       width: DeviceInfo(context).getWidth() - 34,
//       child: Wrap(
//         children: List.generate(
//             options.length,
//             (index) => Container(
//                 decoration: BoxDecoration(
//                     color: MyTheme.white,
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(width: 2, color: MyTheme.grey_153)),
//                 constraints: BoxConstraints(
//                     maxWidth: (DeviceInfo(context).getWidth() - 50) / 4),
//                 margin: const EdgeInsets.only(right: 5, bottom: 5),
//                 child: Stack(
//                   children: [
//                     Container(
//                         padding: const EdgeInsets.only(
//                             left: 10, right: 20, top: 5, bottom: 5),
//                         constraints: BoxConstraints(
//                             maxWidth:
//                                 (DeviceInfo(context).getWidth() - 50) / 4),
//                         child: Text(
//                           options[index].value.toString(),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(fontSize: 12),
//                         )),
//                     Positioned(
//                       right: 2,
//                       child: InkWell(
//                         onTap: () {
//                           remove(index);
//                         },
//                         child: Icon(Icons.highlight_remove,
//                             size: 15, color: MyTheme.red),
//                       ),
//                     )
//                   ],
//                 ))),
//       ),
//     );
//   }

//   Widget imageField(
//       String shortMessage, dynamic onChosenImage, FileInfo? selectedFile) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Buttons(
//           padding: EdgeInsets.zero,
//           onPressed: () async {
//             // XFile chooseFile = await pickSingleImage();
//             List<FileInfo> chooseFile = await (Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const UploadFile(
//                           fileType: "image",
//                           canSelect: true,
//                         ))) as FutureOr<List<FileInfo>>);
//             print("chooseFile.url");
//             print(chooseFile.first.url);
//             if (chooseFile.isNotEmpty) {
//               onChosenImage(chooseFile.first);
//             }
//           },
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//           child: MyWidget().myContainer(
//             width: DeviceInfo(context).getWidth(),
//             height: 46,
//             borderRadius: 6.0,
//             borderColor: MyTheme.light_grey,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 14.0),
//                   child: Text(
//                     "Choose file",
//                     style: TextStyle(fontSize: 12, color: MyTheme.grey_153),
//                   ),
//                 ),
//                 Container(
//                   alignment: Alignment.center,
//                   height: 46,
//                   width: 80,
//                   color: MyTheme.light_grey,
//                   child: Text(
//                     "Browse",
//                     style: TextStyle(fontSize: 12, color: MyTheme.grey_153),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         if (shortMessage.isNotEmpty)
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 shortMessage,
//                 style: TextStyle(fontSize: 8, color: MyTheme.grey_153),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//             ],
//           ),
//         if (selectedFile != null)
//           Stack(
//             fit: StackFit.passthrough,
//             clipBehavior: Clip.antiAlias,
//             alignment: Alignment.bottomCenter,
//             children: [
//               SizedBox(
//                 height: 60,
//                 width: 70,
//               ),
//               MyWidget.imageWithPlaceholder(
//                   border: Border.all(width: 0.5, color: MyTheme.light_grey),
//                   radius: BorderRadius.circular(5),
//                   height: 50.0,
//                   width: 50.0,
//                   url: selectedFile.url),
//               Positioned(
//                 top: 3,
//                 right: 2,
//                 child: Container(
//                   height: 15,
//                   width: 15,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: MyTheme.light_grey),
//                   child: InkWell(
//                     onTap: () {
//                       onChosenImage(null);
//                     },
//                     child: Icon(
//                       Icons.close,
//                       size: 12,
//                       color: MyTheme.red,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//       ],
//     );
//   }

//   Widget fileField(String fileType, String shortMessage, dynamic onChosenFile,
//       FileInfo? selectedFile) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Buttons(
//           padding: EdgeInsets.zero,
//           onPressed: () async {
//             // XFile chooseFile = await pickSingleImage();
//             List<FileInfo> chooseFile = await (Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => UploadFile(
//                           fileType: fileType,
//                           canSelect: true,
//                         ))) as FutureOr<List<FileInfo>>);
//             print("chooseFile.url");
//             print(chooseFile.first.url);
//             if (chooseFile.isNotEmpty) {
//               onChosenFile(chooseFile.first);
//             }
//           },
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//           child: MyWidget().myContainer(
//             width: DeviceInfo(context).getWidth(),
//             height: 46,
//             borderRadius: 6.0,
//             borderColor: MyTheme.light_grey,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 14.0),
//                   child: Text(
//                     "Choose file",
//                     style: TextStyle(fontSize: 12, color: MyTheme.grey_153),
//                   ),
//                 ),
//                 Container(
//                   alignment: Alignment.center,
//                   height: 46,
//                   width: 80,
//                   color: MyTheme.light_grey,
//                   child: Text(
//                     "Browse",
//                     style: TextStyle(fontSize: 12, color: MyTheme.grey_153),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         if (shortMessage.isNotEmpty)
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 shortMessage,
//                 style: TextStyle(fontSize: 8, color: MyTheme.grey_153),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//             ],
//           ),
//         if (selectedFile != null)
//           Stack(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(3),
//                 height: 40,
//                 alignment: Alignment.center,
//                 width: 40,
//                 decoration: BoxDecoration(
//                   color: MyTheme.grey_153,
//                 ),
//                 child: Text(
//                   selectedFile.fileOriginalName! + "." + selectedFile.extension!,
//                   style: TextStyle(fontSize: 9, color: MyTheme.white),
//                 ),
//               ),
//               Positioned(
//                 top: 0,
//                 right: 5,
//                 child: Container(
//                   height: 15,
//                   width: 15,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: MyTheme.white),
//                   // remove the selected file button
//                   child: InkWell(
//                     onTap: () {
//                       onChosenFile(null);
//                     },
//                     child: Icon(
//                       Icons.close,
//                       size: 12,
//                       color: MyTheme.red,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//       ],
//     );
//   }

//   summerNote(title) {
//     if(productDescriptionKey.currentState !=null) {
//       productDescriptionKey.currentState!.getText().then((value){
//         description= value;
//         print(description);
//         if(description!=null){
//           // productDescriptionKey.currentState.setText(description);
//         }
//       });
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.bold,
//               color: MyTheme.font_grey),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Container(
//           height: 250,
//           width: mWidht,
//           child: FlutterSummernote(
//               showBottomToolbar: false,
//               value: description,
//               key: productDescriptionKey
//           ),
//         ),
//       ],
//     );
//     // FlutterSummernote(
//     // hint: "Your text here...",
//     // key: productDescriptionKey,
//     // customToolbar: """
//     //         [
//     //             ['style', ['bold', 'italic', 'underline', 'clear']],
//     //             ['font', ['strikethrough', 'superscript', 'subscript']]
//     //         ]"""
//     // )
//   }

//   Widget smallTextForMessage(String txt) {
//     return Text(
//       txt,
//       style: TextStyle(fontSize: 8, color: MyTheme.grey_153),
//     );
//   }

//   setChange() {
//     setState(() {});
//   }

//   Widget itemSpacer({double height = 24}) {
//     return SizedBox(
//       height: height,
//     );
//   }

//   Widget _buildDropDownField(String title, dynamic onchange,
//       CommonDropDownItem? selectedValue, List<CommonDropDownItem> itemList,
//       {bool isMandatory = false, double? width}) {
//     return buildCommonSingleField(
//         title, _buildDropDown(onchange, selectedValue, itemList, width: width),
//         isMandatory: isMandatory);
//   }

//   Widget _buildCategoryDropDown(String title,dynamic onchange, CategoryModel? selectedValue,
//       List<Category> itemList,
//       {bool isMandatory = false, double? width}) {
//     return buildCommonSingleField(
//         title, Container(
//       height: 46,
//       width: width ?? mWidht,
//       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//       // decoration: MDecoration.decoration1(),
//       child: DropdownButton<Category>(
//         menuMaxHeight: 300,
//         isDense: true,
//         underline: Container(),
//         isExpanded: true,
//         onChanged: (Category? value) {
//           onchange(value);
//         },
//         icon: const Icon(Icons.arrow_drop_down),
//         value: selectedValue,
//         items: itemList
//             .map(
//               (value) => DropdownMenuItem<Category>(
//             value: value,
//             child: Text(
//               value.,
//             ),
//           ),
//         )
//             .toList(),
//       ),
//     ),
//         isMandatory: isMandatory);
//   }

//   Widget _buildDropDown(dynamic onchange, CommonDropDownItem? selectedValue,
//       List<CommonDropDownItem> itemList,
//       {double? width}) {
//     return Container(
//       height: 46,
//       width: width ?? mWidht,
//       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//       decoration: MDecoration.decoration1(),
//       child: DropdownButton<CommonDropDownItem>(
//         menuMaxHeight: 300,
//         isDense: true,
//         underline: Container(),
//         isExpanded: true,
//         onChanged: (CommonDropDownItem? value) {
//           onchange(value);
//         },
//         icon: const Icon(Icons.arrow_drop_down),
//         value: selectedValue,
//         items: itemList
//             .map(
//               (value) => DropdownMenuItem<CommonDropDownItem>(
//                 value: value,
//                 child: Text(
//                   value.value!,
//                 ),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }

//   Widget _buildColorDropDown(dynamic onchange, CommonDropDownItem? selectedValue,
//       List<CommonDropDownItem> itemList,
//       {double? width}) {
//     return Container(
//       height: 46,
//       width: width ?? mWidht,
//       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//       decoration: MDecoration.decoration1(),
//       child: DropdownButton<CommonDropDownItem>(
//         menuMaxHeight: 300,
//         isDense: true,
//         underline: Container(),
//         isExpanded: true,
//         onChanged: (CommonDropDownItem? value) {
//           onchange(value);
//         },
//         icon: const Icon(Icons.arrow_drop_down),
//         value: selectedValue,
//         items: itemList
//             .map(
//               (value) => DropdownMenuItem<CommonDropDownItem>(
//                 value: value,
//                 child: Row(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 5),
//                       height: 20,
//                       width: 20,
//                       decoration: BoxDecoration(
//                           color: Color(
//                               int.parse(value.key!.replaceAll("#", "0xFF"))),
//                           borderRadius: BorderRadius.circular(4)),
//                     ),
//                     Text(
//                       value.value!,
//                     ),
//                   ],
//                 ),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }

//   Widget _buildFlatDropDown(String title, dynamic onchange,
//       CommonDropDownItem selectedValue, List<CommonDropDownItem> itemList,
//       {bool isMandatory = false, double? width}) {
//     return buildCommonSingleField(
//         title,
//         Container(
//           height: 46,
//           width: width ?? mWidht,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: MyTheme.app_accent_color_extra_light),
//           padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//           child: DropdownButton<CommonDropDownItem>(
//             isDense: true,
//             underline: Container(),
//             isExpanded: true,
//             onChanged: (value) {
//               onchange(value);
//             },
//             icon: const Icon(Icons.arrow_drop_down),
//             value: selectedValue,
//             items: itemList
//                 .map(
//                   (value) => DropdownMenuItem<CommonDropDownItem>(
//                     value: value,
//                     child: Text(
//                       value.value!,
//                     ),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ),
//         isMandatory: isMandatory);
//   }

//   Widget buildEditTextField(
//       String title, String hint, TextEditingController textEditingController,
//       {isMandatory = false}) {
//     return Container(
//       child: buildCommonSingleField(
//         title,
//         MyWidget.customCardView(
//           backgroundColor: MyTheme.white,
//           elevation: 5,
//           width: DeviceInfo(context).getWidth(),
//           height: 46,
//           borderRadius: 10,
//           child: TextField(
//             controller: textEditingController,
//             decoration: InputDecorations.buildInputDecoration_1(
//                 hint_text: hint,
//                 borderColor: MyTheme.noColor,
//                 hintTextColor: MyTheme.grey_153),
//           ),
//         ),
//         isMandatory: isMandatory,
//       ),
//     );
//   }

//   Widget buildTagsEditTextField(
//       String title, String hint, TextEditingController textEditingController,
//       {isMandatory = false}) {
//     //textEditingController.buildTextSpan(context: context, withComposing: true);
//     return buildCommonSingleField(
//       title,
//       Container(
//         padding: EdgeInsets.only(top: 14, bottom: 10, left: 14, right: 14),
//         alignment: Alignment.centerLeft,
//         constraints: BoxConstraints(
//           minWidth: DeviceInfo(context).getWidth(),
//           minHeight: 46,
//         ),
//         decoration: MDecoration.decoration1(),
//         child: Wrap(
//           alignment: WrapAlignment.start,
//           crossAxisAlignment: WrapCrossAlignment.center,
//           runAlignment: WrapAlignment.start,
//           clipBehavior: Clip.antiAlias,
//           children: List.generate(tags!.length + 1, (index) {
//             if (index == tags!.length) {
//               return TextField(
//                 onSubmitted: (string) {
//                   var tag = textEditingController.text
//                       .trim()
//                       .replaceAll(",", "")
//                       .toString();
//                   print("tag empty ${tag.isEmpty}");
//                   if(tag.isNotEmpty)
//                   addTag(tag);
//                 },
//                 onChanged: (string) {
//                   if (string.trim().contains(",")) {
//                     var tag = string.trim().replaceAll(",", "").toString();
//                     print("tag empty ${tag.isEmpty}");

//                     if(tag.isNotEmpty)
//                     addTag(tag);
//                   }
//                 },
//                 controller: textEditingController,
//                 keyboardType: TextInputType.text,
//                 maxLines: 1,
//                 style: TextStyle(fontSize: 16),
//                 decoration: InputDecoration.collapsed(
//                         hintText: "Type and hit submit",
//                         hintStyle: TextStyle(fontSize: 12))
//                     .copyWith(constraints: BoxConstraints(maxWidth: 150)),
//               );
//             }
//             return Container(
//                 decoration: BoxDecoration(
//                     color: MyTheme.white,
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(width: 2, color: MyTheme.grey_153)),
//                 constraints: BoxConstraints(
//                     maxWidth: (DeviceInfo(context).getWidth() - 50) / 4),
//                 margin: const EdgeInsets.only(right: 5, bottom: 5),
//                 child: Stack(
//                   fit: StackFit.loose,
//                   children: [
//                     Container(
//                         padding: const EdgeInsets.only(
//                             left: 10, right: 20, top: 5, bottom: 5),
//                         constraints: BoxConstraints(
//                             maxWidth:
//                                 (DeviceInfo(context).getWidth() - 50) / 4),
//                         child: Text(
//                           tags![index].toString(),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(fontSize: 12),
//                         )),
//                     Positioned(
//                       right: 2,
//                       child: InkWell(
//                         onTap: () {
//                           tags!.removeAt(index);
//                           setChange();
//                         },
//                         child: Icon(Icons.highlight_remove,
//                             size: 15, color: MyTheme.red),
//                       ),
//                     )
//                   ],
//                 ));
//           }),
//         ),
//       ),
//       isMandatory: isMandatory,
//     );
//   }

//   addTag(String string) {
//     if (string.trim().isNotEmpty) {
//       tags!.add(string.trim());
//     }
//     tagEditTextController.clear();
//     setChange();
//   }

//   Widget buildPriceEditTextField(String title, String hint,
//       {isMandatory = false}) {
//     return Container(
//       child: buildCommonSingleField(
//         title,
//         MyWidget.customCardView(
//           backgroundColor: MyTheme.white,
//           elevation: 5,
//           width: DeviceInfo(context).getWidth(),
//           height: 46,
//           borderRadius: 10,
//           child: TextField(
//             controller: unitPriceEditTextController,
//             onChanged: (string) {
//               createProductVariation();
//             },
//             keyboardType: TextInputType.number,
//             decoration: InputDecorations.buildInputDecoration_1(
//                 hint_text: hint,
//                 borderColor: MyTheme.noColor,
//                 hintTextColor: MyTheme.grey_153),
//           ),
//         ),
//         isMandatory: isMandatory,
//       ),
//     );
//   }

//   Widget buildFlatEditTextField(
//       String title, String hint, TextEditingController textEditingController,
//       {isMandatory = false}) {
//     return Container(
//       child: buildCommonSingleField(
//         title,
//         Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: MyTheme.app_accent_color_extra_light),
//           width: DeviceInfo(context).getWidth(),
//           height: 45,
//           child: TextField(
//             controller: textEditingController,
//             decoration: InputDecorations.buildInputDecoration_1(
//                 hint_text: hint,
//                 borderColor: MyTheme.noColor,
//                 hintTextColor: MyTheme.grey_153),
//           ),
//         ),
//         isMandatory: isMandatory,
//       ),
//     );
//   }

//   buildCommonSingleField(title, Widget child, {isMandatory = false}) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             buildFieldTitle(title),
//             if (isMandatory)
//               Text(
//                 " *",
//                 style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.red),
//               ),
//           ],
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         child,
//       ],
//     );
//   }

//   Text buildFieldTitle(title) {
//     return Text(
//       title,
//       style: const TextStyle(
//           fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
//     );
//   }

//   variationViewModel(int index) {
//     return buildExpansionTile(index, (onExpand) {
//       productVariations[index].isExpended = onExpand;
//       setChange();
//     }, productVariations[index].isExpended);
//   }

//   buildExpansionTile(int index, dynamic onExpand, isExpanded) {
//     return Container(
//       height: isExpanded
//           ? productVariations[index].photo == null
//               ? 274
//               : 334
//           : 100,
//       // decoration: MDecoration.decoration1(),
//       padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             alignment: Alignment.center,
//             width: 20,
//             height: 20,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),),
//             constraints: BoxConstraints(),
//             child: IconButton(
//               splashRadius: 5,
//               constraints: BoxConstraints(),
//               iconSize: 12,
//               padding: EdgeInsets.zero,
//               onPressed: () {
//                 isExpanded = !isExpanded;
//                 onExpand(isExpanded);
//               },
//               icon: Icon(
//                 isExpanded ? Icons.remove : Icons.add,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 14.0),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                         width: (mWidht / 3),
//                         child: Text(
//                           productVariations[index].name!,
                          
//                         )),
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: Colors.blueAccent),
//                       width: (mWidht / 3),
//                       child: TextField(
//                         keyboardType: TextInputType.number,
//                         controller:
//                             productVariations[index].priceEditTextController,
//                         decoration: InputDecoration(
//                           hintText: "0"
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 if (isExpanded)
//                   Column(
//                     children: [
//                       itemSpacer(height: 14),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
                         
                        
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: 80,
//                             child: Text(
//                             "Quantity",

//                             ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 color: Colors.white),
//                             width: (mWidht * 0.6),
//                             child: TextField(
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.allow(
//                                     RegExp(r'[0-9]'))
//                               ],
//                               keyboardType: TextInputType.number,
//                               controller: productVariations[index]
//                                   .quantityEditTextController,
//                               decoration:
//                                   InputDecoration(hintText: "0")),
//                             ),
//                     ])
//                         ],
//                       ),
//                       itemSpacer(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 14.0),
//                             child: Text(
//                               "Photo",
                             
//                             ),
//                           ),
//                           SizedBox(
//                             width: (mWidht * 0.6),
//                             child: imageField("", (onChosenImage) {
//                               productVariations[index].photo = onChosenImage;
//                               setChange();
//                             }, productVariations[index].photo),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   buildSwitchField(String title, value, onChanged, {isMandatory = false}) {
//     return Row(
//       children: [
//         if (title.isNotEmpty) buildFieldTitle(title),
//         if (isMandatory)
//           Text(
//             " *",
//             style: TextStyle(
//                 fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red),
//           ),
//         const Spacer(),
//         Container(
//           height: 30,
//           child: Switch(
//             value: value,
//             onChanged: onChanged,
//             activeColor: Colors.green,
//           ),
//         ),
//       ],
//     );
//   }

//   Future<DateTimeRange?> _buildPickDate() async {
//     DateTimeRange? p;
//     p = await showDateRangePicker(
//         context: context,
//         firstDate: DateTime.now(),
//         lastDate: DateTime.utc(2050),
//         builder: (context, child) {
//           return Container(
//             width: 500,
//             height: 500,
//             child: DateRangePickerDialog(
//               initialDateRange:
//                   DateTimeRange(start: DateTime.now(), end: DateTime.now()),
//               saveText: "Select",
//               initialEntryMode: DatePickerEntryMode.calendarOnly,
//               firstDate: DateTime.now(),
//               lastDate: DateTime.utc(2050),
//             ),
//           );
//         });

//     return p;
//   }

 

//   Widget tabBarDivider() {
//     return const SizedBox(
//       width: 1,
//       height: 50,
//     );
//   }

//   Container buildTopTapBarItem(String text, int index) {
//     return Container(
//         height: 50,
//         width: 100,
//         color: _selectedTabIndex == index
//             ? Colors.amber[100]
//             : Colors.green[100],
//         child: ElevatedButton(
//                 onPressed: () {
//           _selectedTabIndex = index;
//           setState(() {});
//         },
//           child:  Text(
//               text,
//               style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   ),
//             )));
//   }

  
// }

// class VariationModel {
//   String? name;

//   FileInfo? photo;
//   TextEditingController priceEditTextController,
//       quantityEditTextController,
//       skuEditTextController;
//   bool isExpended;

//   VariationModel(
//       this.name,
//       //this.id,
//       this.photo,
//       this.priceEditTextController,
//       this.quantityEditTextController,
//       this.skuEditTextController,
//       this.isExpended);
// }



// class Tags {
//   static List<String> tags = [];

//   static toJson() {
//     Map<String, String> map = {};

//     tags.forEach((element) {
//       map.addAll({"value": element});
//     });

//     return map;
//   }

//   static string() {
//     return jsonEncode(toJson());
//   }
// }
