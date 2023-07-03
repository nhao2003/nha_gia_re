import '../enums/enums.dart';
import '../providers/remote/request/filter_request.dart';

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
    filter = PostFilter(
      orderBy: OrderBy.priceAsc,
      postedBy: PostedBy.all,
    );
    typeResult = type;
  }

  PostFilter filter = PostFilter(
    orderBy: OrderBy.priceAsc,
    postedBy: PostedBy.all,
  );
}
