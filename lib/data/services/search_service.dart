import '../enums/enums.dart';

class SearchService {
  static final SearchService _instance = SearchService._();

  SearchService._();

  static SearchService get instance => _instance;

  OrderBy orderBy = OrderBy.createdAtAsc;

  void setOrderBy(OrderBy orderBy) {
    print("set orderby ins" + orderBy.toString());
    this.orderBy = orderBy;
  }

  TypeNavigate typeResult = TypeNavigate.search;

  void setTypeResult(TypeNavigate type) {
    typeResult = type;
  }
}
