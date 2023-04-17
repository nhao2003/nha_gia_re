import '../../../enums/property_enums.dart';
import '../../../models/address.dart';
import 'post_request.dart';

class MotelRequest extends PostRequest {
  int? electricPrice;
  int? waterPrice;
  FurnitureStatus? furnitureStatus;
  MotelRequest({
    required this.furnitureStatus,
    required double area,
    required String? projectName,
    required this.electricPrice,
    required this.waterPrice,
    required Address address,
    required String userID,
    required int price,
    required String title,
    required String description,
    required List<String> imagesUrl,
    required bool isProSeller,
    required int deposit,
  })  : assert(electricPrice == null || electricPrice > 0),
        assert(waterPrice == null || waterPrice > 0),
        super(
        area: area,
        type: PropertyType.motel,
        address: address,
        userID: userID,
        isLease: true,
        price: price,
        title: title,
        description: description,
        imagesUrl: imagesUrl,
        isProSeller: isProSeller,
        projectName: projectName,
        deposit: deposit,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'electric_price': electricPrice,
      'water_price': waterPrice,
      'furniture_status': furnitureStatus?.toString(),
      ...super.toJson()
    };
  }
}
