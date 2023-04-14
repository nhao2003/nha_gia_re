import '../../../enums/property_enums.dart';
import '../../../models/address.dart';
import 'post_request.dart';

class LandRequest extends PostRequest {
  String? landLotCode;
  String? subdivisionName;
  LandType? landType;
  double width;
  double length;
  Direction? landDirection;
  LegalDocumentStatus? legalDocumentStatus;
  bool isFacade;
  bool isWidensTowardsTheBack;
  bool hasWideAlley;
  LandRequest({
    required double area,
    required String? projectName,
    required this.landLotCode,
    required this.subdivisionName,
    required this.landType,
    required this.width,
    required this.length,
    required this.landDirection,
    required this.legalDocumentStatus,
    required this.isFacade,
    required this.isWidensTowardsTheBack,
    required this.hasWideAlley,
    required Address address,
    required String userID,
    required bool isLease,
    required int price,
    required String title,
    required String description,
    required List<String> imagesUrl,
    required bool isProSeller,
    required int? deposit,
  })  : assert(landLotCode?.trim().isNotEmpty ?? true),
        assert(width * length > 0),
        assert(subdivisionName?.trim().isNotEmpty ?? true),
        super(
        area: area,
        type: PropertyType.land,
        address: address,
        userID: userID,
        isLease: isLease,
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
      'land_lot_code': landLotCode,
      'subdivision_name': subdivisionName,
      'land_type': landType?.toString(),
      'width': width,
      'length': length,
      'land_direction': landDirection?.toString(),
      'legal_document_status': legalDocumentStatus?.toString(),
      'is_facade': isFacade,
      'is_widens_towards_the_back': isWidensTowardsTheBack,
      'has_wide_alley': hasWideAlley,
      ...super.toJson()
    };
  }
}
