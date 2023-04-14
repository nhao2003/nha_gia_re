import '../../../enums/property_enums.dart';
import '../../../models/address.dart';
import 'post_request.dart';
class OfficeRequest extends PostRequest {
  bool hasWideAlley;
  bool isFacade;
  OfficeType? officeType;
  Direction? mainDoorDirection;
  LegalDocumentStatus? legalDocumentStatus;
  FurnitureStatus? furnitureStatus;
  OfficeRequest({
    required this.furnitureStatus,
    required double area,
    required Address address,
    required String userID,
    required bool isLease,
    required int price,
    required String title,
    required String description,
    required List<String> imagesUrl,
    required bool isProSeller,
    required String? projectName,
    required int? deposit,
    required this.hasWideAlley,
    required this.isFacade,
    required this.officeType,
    required this.mainDoorDirection,
    required this.legalDocumentStatus,
  })  : assert(projectName?.trim().isNotEmpty ?? true),
        super(
        area: area,
        type: PropertyType.office,
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
      'has_wide_alley': hasWideAlley,
      'is_facade': isFacade,
      'office_type': officeType.toString(),
      'main_door_direction': mainDoorDirection?.toString(),
      'legal_document_status': legalDocumentStatus?.toString(),
      'furniture_status': furnitureStatus?.toString(),
      ...super.toJson(),
    };
  }
}
