import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/deliver_service.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/order_model.dart' as orderModel;
import 'package:dpl_ecommerce/models/order_shop.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:dpl_ecommerce/models/payment_type.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/cart_repo.dart';
import 'package:dpl_ecommerce/repositories/deliver_service_repo.dart';
import 'package:dpl_ecommerce/repositories/order_repo.dart';
import 'package:dpl_ecommerce/repositories/payment_repo.dart';
import 'package:dpl_ecommerce/repositories/product_repo.dart';
import 'package:dpl_ecommerce/repositories/recommed_product_repo.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/repositories/voucher_for_user_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/address_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/checkout_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/voucher_for_user_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/main_view.dart';
import 'package:dpl_ecommerce/views/consumer/screens/change_address_in_check_out.dart';
import 'package:dpl_ecommerce/views/consumer/screens/change_apply_voucher.dart';
import 'package:dpl_ecommerce/views/consumer/screens/ordering_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  CheckOut({super.key, required this.uid});
  String uid;
  @override
  State<CheckOut> createState() => __CheckOutState();
}

class __CheckOutState extends State<CheckOut> {
  // final List<Product>? products = ProductRepo().list;
  String shipType = "Cash";
  DeliverService? selectedService;
  List<DeliverService>? listDeliverySerice;
  DeliverServiceRepo deliverServiceRepo = DeliverServiceRepo();

  UserRepo userRepo = UserRepo();
  OrderRepo orderRepo = OrderRepo();
  ProductRepo productRepo = ProductRepo();
  VoucherForUserRepo voucherForUserRepo = VoucherForUserRepo();
  // AddressInfor? addressInfor;
  // AddressInfor? defaultAddress;
  bool isLoading = true;
  bool isLoadingAddress = true;
  List<PaymentType>? listPaymentType;
  PayMentRepo payMentRepo = PayMentRepo();
  CartRepo cartRepo = CartRepo();
  RecommededProductRepo recommededProductRepo = RecommededProductRepo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    listDeliverySerice = await deliverServiceRepo.getDeliverServiceList();
    isLoading = false;
    if (selectedService == null &&
        (listDeliverySerice != null || listDeliverySerice!.isNotEmpty)) {
      selectedService = listDeliverySerice![0];
    }
    listPaymentType = await payMentRepo.getListPayment();
    // fetchDefaultAddress();
    setState(() {});
  }

  // Future<void> fetchDefaultAddress() async {
  //   defaultAddress = await userRepo.getDefaultAddress(widget.uid);
  //   isLoadingAddress = false;
  //   // if (addressInfor == null) {
  //   //   addressInfor = defaultAddress;
  //   // }
  //   setState(() {});
  // }

  Future<void> onRefresh() async {
    await reset();
    await fetchData();
  }

  Future<void> reset() async {
    listDeliverySerice = [];
    isLoading = true;
    setState(() {});
  }

  showNotification(BuildContext context) {
    ToastHelper.showDialog(
      LangText(context: context).getLocal()!.add_full_infor,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressViewModel>(context);
    final checkoutProvider = Provider.of<CheckoutViewModel>(context);
    final cartProvider = Provider.of<CartViewModel>(context);
    final userProvider = Provider.of<UserViewModel>(context);
    final voucherForUserProvider =
        Provider.of<VoucherForUserViewModel>(context);
    final user = userProvider.currentUser;
    final listProduct = checkoutProvider.order!.orderingProductsID;
    final order = checkoutProvider.order;
    return Scaffold(
      appBar: CustomAppBar(
              centerTitle: true,
              context: context,
              title: LangText(context: context).getLocal()!.confirm_payment)
          .show(),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 5.w),
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: ListOrderingProductItem(
                              list: listProduct,
                            ))),
                    // _buildvoucher(context),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                height: 2.h,
                color: Color(0xFFD8D9DB),
              ),
              voucherForUserProvider.listVoucherOfAdmin.isNotEmpty
                  ? _buildApplyVoucher(context)
                  : const SizedBox(),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                height: 2.h,
                color: Color(0xFFD8D9DB),
              ),
              _buildAdress(context),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                height: 2.h,
                color: Color(0xFFD8D9DB),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      LangText(context: context)
                          .getLocal()!
                          .select_delivery_service,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    isLoading
                        ? Container()
                        : DropdownButtonFormField<DeliverService>(
                            borderRadius: BorderRadius.circular(10.r),
                            //dropdownColor: Colors.grey,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 15.w),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            value: selectedService,
                            isExpanded: true,
                            items: listDeliverySerice!.map((DeliverService d) {
                              return DropdownMenuItem<DeliverService>(
                                value: d,
                                child: Text(d.name!),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedService = newValue!;
                                // Reset selected product when category changes
                              });
                            },
                          ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                            LangText(context: context)
                                .getLocal()!
                                .shipping_cost_ucf,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF000000),
                            )),
                        const Spacer(),
                        Text("10000 VND",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF000000),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Consumer<VoucherForUserViewModel>(
                      builder: (context, value, child) {
                        if (value.selectedVoucher != null) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                      LangText(context: context)
                                          .getLocal()!
                                          .total_price_without_discount_ucf,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF000000),
                                      )),
                                  const Spacer(),
                                  Text(order!.totalCost!.toString(),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF000000),
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                      LangText(context: context)
                                          .getLocal()!
                                          .discount_ucf,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF000000),
                                      )),
                                  const Spacer(),
                                  Text(
                                      value.selectedVoucher!.discountAmount !=
                                              null
                                          ? "${value.selectedVoucher!.discountAmount} VND"
                                          : "${value.selectedVoucher!.discountPercent} %",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF000000),
                                      )),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    Row(
                      children: [
                        Text(
                            LangText(context: context)
                                .getLocal()!
                                .total_price_ucf,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF000000),
                            )),
                        const Spacer(),
                        Consumer<VoucherForUserViewModel>(
                          builder: (context, value, child) {
                            if (value.selectedVoucher != null) {
                              int totalCost = order!.totalCost!;
                              if (voucherForUserProvider.selectedVoucher !=
                                  null) {
                                if (voucherForUserProvider
                                        .selectedVoucher!.discountAmount !=
                                    null) {
                                  totalCost = totalCost -
                                      voucherForUserProvider
                                          .selectedVoucher!.discountAmount!;
                                } else {
                                  totalCost = totalCost -
                                      (totalCost *
                                              voucherForUserProvider
                                                  .selectedVoucher!
                                                  .discountPercent!) ~/
                                          100;
                                }
                              }
                              totalCost = totalCost + 10000;
                              return Text(totalCost.toString(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF000000),
                                  ));
                            } else {
                              return Text(order!.totalCost!.toString(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF000000),
                                  ));
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: 384.h,
                      height: 50.h,
                      // decoration: BoxDecoration(
                      //     color: Colors.blue,
                      //     borderRadius: BorderRadius.circular(10)),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  MyTheme.accent_color)),
                          child: Text(
                            LangText(context: context).getLocal()!.order_ucf,
                            style:
                                TextStyle(fontSize: 18.sp, color: Colors.white),
                          ),
                          onPressed: () async {
                            // perform ordering
                            int totalCost = order!.totalCost!;
                            if (voucherForUserProvider.selectedVoucher !=
                                null) {
                              if (voucherForUserProvider
                                      .selectedVoucher!.discountAmount !=
                                  null) {
                                totalCost = totalCost -
                                    voucherForUserProvider
                                        .selectedVoucher!.discountAmount!;
                              } else {
                                totalCost = totalCost -
                                    (totalCost *
                                            voucherForUserProvider
                                                .selectedVoucher!
                                                .discountPercent!) ~/
                                        100;
                              }
                            }
                            totalCost = totalCost + 10000;
                            if (selectedService == null) {
                              showNotification(context);
                            } else {
                              orderModel.Order newOrder = orderModel.Order(
                                  deliverServiceID: selectedService!.id,
                                  // deliverStatus: DeliverStatus.processing,
                                  voucherDiscountID:
                                      voucherForUserProvider.selectedVoucher !=
                                              null
                                          ? voucherForUserProvider
                                              .selectedVoucher!.id!
                                          : null,
                                  id: order.id,
                                  orderingProductsID: listProduct,
                                  paymentTypeID: listPaymentType![0].id,
                                  receivedAddress:
                                      addressProvider.orderingAddress,
                                  shippingCost: 10000,
                                  totalCost: totalCost,
                                  totalProduct: listProduct!.length,
                                  userID: user!.id,
                                  time: Timestamp.now());
                              await orderRepo.addAnOrder(newOrder);
                              for (var element
                                  in newOrder.orderingProductsID!) {
                                if (element.voucherID != null) {
                                  await voucherForUserRepo
                                      .deleteVoucherIDForUser(
                                          uid: user.id!,
                                          voucherID: element.voucherID!);
                                  voucherForUserProvider
                                      .deleteVoucherID(element.voucherID!);
                                }
                              }
                              for (var element in listProduct) {
                                final product = await productRepo
                                    .getProductByID(element.productID!);

                                OrderShop orderShop = OrderShop(
                                    color: element.color,
                                    deliverServiceID: selectedService!.id,
                                    deliverStatus: DeliverStatus.processing,
                                    orderCode: order.id,
                                    orderDate: Timestamp.now(),
                                    orderingProductID: element.id,
                                    paymentStatus: PaymentStatus.unpaid,
                                    productID: element.productID,
                                    quatity: element.quantity!,
                                    shopID: product!.shopID,
                                    singlePrice: element.price,
                                    size: element.size,
                                    type: element.type,
                                    totalPrice: element.realPrice);
                                print(
                                    "Hehehrerererer: shopID:: ${orderShop.shopID} and id: ${orderShop.id!}");
                                await orderRepo.addOrderShop(orderShop);
                              }

                              if (checkoutProvider.listProductInCartID !=
                                  null) {
                                for (var element
                                    in checkoutProvider.listProductInCartID!) {
                                  await cartRepo.deleteByProductInCartModelID(
                                      uid: user.id!,
                                      productInCartModelID: element);
                                }
                              }

                              // voucherForUserProvider.resetData();
                              // for (var element in listProduct) {
                              //   recommededProductRepo.insertData(uid: user.id!,categoryID: element.)
                              // }

                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SuccessScreen(),
                              ));
                              // checkoutProvider.reset();
                            }
                          }),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildvoucher(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: MyTheme.accent_color, width: 1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ship code",
              style: TextStyle(
                fontSize: 18.sp,
                //fontFamily = FontFamily(Font(R.font.svn - gilroy)),
                fontWeight: FontWeight.w500,
                color: const Color(0xFF000000),
              )),
          SizedBox(
            height: 14.h,
          ),
          Container(
              height: 42.h,
              width: 383.w,
              decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(13, 12, 252, 12),
                child: Text("BLACKFRIDAY50",
                    style: TextStyle(
                      fontSize: 16.sp,
                      //fontFamily = FontFamily(Font(R.font.svn - gilroy)),
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF000000),
                    )),
              ))
        ],
      ),
    );
  }

  Widget _buildAdress(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
      child: Consumer<CheckoutViewModel>(
        builder: (context, checkoutProvider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LangText(context: context).getLocal()!.your_address,
                style: TextStyle(
                  fontSize: 18.sp,
                  //fontFamily = FontFamily(Font(R.font.svn - gilroy)),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF000000),
                )),
            SizedBox(
              height: 14.h,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(13, 12, 0, 0),
                  child: Consumer<AddressViewModel>(
                    builder: (context, provider, child) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(provider.orderingAddress!.name!,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF000000),
                                )),
                            SizedBox(
                              width: 170.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChangeAddress(),
                                ));
                              },
                              child: Text(
                                  LangText(context: context)
                                      .getLocal()!
                                      .change_ucf,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFEE4D2C),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        // Text("0966 123 456",
                        //     style: TextStyle(
                        //       fontSize: 16.sp,
                        //       fontWeight: FontWeight.w500,
                        //       color: const Color(0xFF777777),
                        //     )),
                        // SizedBox(
                        //   height: 8.h,
                        // ),
                        Text(provider.orderingAddress!.city!.name!,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF777777),
                            )),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(provider.orderingAddress!.number!,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF777777),
                            )),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildApplyVoucher(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LangText(context: context).getLocal()!.voucher_ucf,
                style: TextStyle(
                  fontSize: 18.sp,
                  //fontFamily = FontFamily(Font(R.font.svn - gilroy)),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF000000),
                )),
            SizedBox(
              height: 14.h,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(13, 12, 0, 0),
                  child: Consumer<VoucherForUserViewModel>(
                    builder: (context, provider, child) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(provider.selectedVoucher!.name!,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF000000),
                                )),
                            SizedBox(
                              width: 170.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeApplyVoucher()));
                              },
                              child: Text(
                                  LangText(context: context)
                                      .getLocal()!
                                      .change_ucf,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFEE4D2C),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                            provider.selectedVoucher!.discountAmount != null
                                ? "${provider.selectedVoucher!.discountAmount} VND"
                                : "${provider.selectedVoucher!.discountPercent} %",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF777777),
                            )),
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }
}

class ListOrderingProductItem extends StatefulWidget {
  ListOrderingProductItem({super.key, this.list});
  List<OrderingProduct>? list;

  @override
  State<ListOrderingProductItem> createState() =>
      _ListOrderingProductItemState();
}

class _ListOrderingProductItemState extends State<ListOrderingProductItem> {
  ProductRepo productRepo = ProductRepo();
  List<Product>? list = [];
  Voucher? voucher;
  bool isLoading = true;
  Future<void> fetchData() async {
    for (var element in widget.list!) {
      Product? product = await productRepo.getProductByID(element.productID!);
      list!.add(product!);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: list!.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          list![index].images![0],
                          height: 120.h,
                          width: 110.w,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(list![index].name!,
                              style: TextStyle(
                                fontSize: 19.sp,
                                //fontFamily = FontFamily(Font(R.font.svn - gilroy)),
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000),
                              )),
                          SizedBox(
                            height: 43.h,
                          ),
                          // list![index].voucherID != null
                          //     ?
                          Text(widget.list![index].realPrice.toString(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                //fontFamily = FontFamily(Font(R.font.svn - gilroy)),
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFEE4D2C),
                              )),
                          // : Text(list![index].price.toString(),
                          //     style: TextStyle(
                          //       fontSize: 16.sp,
                          //       //fontFamily = FontFamily(Font(R.font.svn - gilroy)),
                          //       fontWeight: FontWeight.w500,
                          //       color: const Color(0xFFEE4D2C),
                          //     )
                          // ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                              "${LangText(context: context).getLocal()!.amount} ${widget.list![index].quantity}",
                              style: TextStyle(
                                fontSize: 16.sp,
                                //fontFamily = FontFamily(Font(R.font.svn - gilroy)),
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF000000),
                              ))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    height: 1.h,
                    color: Color(0xFFD8D9DB),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              );
            });
  }
}
