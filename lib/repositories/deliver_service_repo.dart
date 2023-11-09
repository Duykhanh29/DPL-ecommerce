import 'package:dpl_ecommerce/models/deliver_service.dart';

class DeliverServiceRepo {
  final List<DeliverService> listDeliverService = [
    DeliverService(
        id: "deliverServiceID01",
        name: "Viettel Post",
        logo:
            "https://cdn.haitrieu.com/wp-content/uploads/2022/05/Logo-Viettel-Post-Red.png"),
    DeliverService(
        id: "deliverServiceID02",
        name: "Vietnam Post",
        logo:
            "https://inhoangkien.vn/wp-content/uploads/2020/09/Logo-dai-dien_Artboard-1.jpg"),
    DeliverService(
        id: "deliverServiceID03",
        name: "Vietnam Post Express", // giao hàng tiết kiệm
        logo:
            "https://play-lh.googleusercontent.com/vF-iKDPXiXsEJwJ_A06INKsshcF4d7NzjnkEUfb6lygxS6lawlMLCbBVwB57LW5Nkhd5=w240-h480-rw"),
    DeliverService(
        id: "deliverServiceID04",
        name: "Express Delivery",
        logo:
            "https://cdn.haitrieu.com/wp-content/uploads/2022/05/Logo-GHN-Orange.png"),
  ];
}
