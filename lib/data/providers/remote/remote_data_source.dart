import 'dart:developer';
import 'dart:async';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/string_ex.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/models/conversation.dart';
import 'package:nha_gia_re/data/models/message.dart';
import 'package:nha_gia_re/data/providers/remote/request/filter_request.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteDataSource {
  static const String tableApartments = 'apartments';
  static const String tableHouses = 'houses';
  static const String tableLands = 'lands';
  static const String tableMotels = 'motels';
  static const String tableOffices = 'offices';
  static const String tableUserInfo = 'user_info';
  static const String tableUserLike = 'user_like';
  static const String tableUserFollow = 'user_follow';
  static const String tablePost = 'post';
  final SupabaseClient supabaseClient = Supabase.instance.client;

  Future<AuthResponse> signUp(
      {required String email, required String password}) async {
    try {
      return await supabaseClient.auth.signUp(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> signIn(
      {required String email, required String password}) async {
    try {
      return await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
  Future<void> likePost({required postId}) async {
    try
    {
      Map<String, dynamic> data = {
        'user_id' : supabaseClient.auth.currentUser?.id,
        'post_id' : postId
      };
      await supabaseClient.from(tableUserLike).insert(data).select();
    }
    catch(e)
    {
      rethrow;
    }
  }
  Future<void> unlikePost({required postId}) async {
    try
    {
      await supabaseClient.from(tableUserLike).delete()
      .eq('user_id', supabaseClient.auth.currentUser?.id)
      .eq('post_id', postId);
    }
    catch(e)
    {
      rethrow;
    }
  }
  Future<bool> hasLikePost({required postId}) async {
    try
    {
      final res = await supabaseClient.from(tableUserLike)
      .select()
      .eq('user_id', supabaseClient.auth.currentUser?.id)
      .eq('post_id', postId).limit(1);
      if(List<Map<String, dynamic>>.from(res).isNotEmpty)
      {
        return true;
      }
      else return false;
    }
    catch(e)
    {
      rethrow;
    }
  }
  Future<void> followUser({required userId}) async {
    try{
      Map<String, dynamic> data = {
        'follower_id' :  supabaseClient.auth.currentUser?.id,
        'followed_id' : userId
      };
      await supabaseClient.from(tableUserFollow).insert(data);
    }
    catch(e)
    {
      rethrow;
    }
  }
  Future<void> unfollowUser({required userId}) async {
    try{
      await supabaseClient.from(tableUserFollow).delete()
      .eq('follower_id', supabaseClient.auth.currentUser?.id)
      .eq('followed_id', userId);
    }
    catch(e)
    {
      rethrow;
    }
  }
  Future<bool> isFollowing({required userId}) async {
    try
    {
      final res = await supabaseClient.from(tableUserFollow)
      .select()
      .eq('follower_id', supabaseClient.auth.currentUser?.id)
      .eq('followed_id', userId).limit(1);
      if(List<Map<String, dynamic>>.from(res).isNotEmpty)
      {
        return true;
      }
      else return false;
    }
    catch(e)
    {
      rethrow;
    }
  }
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> data) async {
    try {
      print(supabaseClient.auth.currentUser!.id);
      print(data);
      final res = await supabaseClient
          .from(tableUserInfo)
          .update(data)
          .eq('uid', supabaseClient.auth.currentUser!.id)
          .select();
      inspect(res);
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePost(String id) async {
    try {
      await supabaseClient.from(tablePost).delete().eq('id', id);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postApartment(Map<String, dynamic> data) async {
    try {
      final res =
          await supabaseClient.from(tableApartments).insert(data).select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postHouse(Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient.from(tableHouses).insert(data).select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postLand(Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient.from(tableLands).insert(data).select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postMotel(Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient.from(tableMotels).insert(data).select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postOffice(Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient.from(tableOffices).insert(data).select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserInfo(String uid) async {
    try {
      final response =
          await supabaseClient.from(tableUserInfo).select().eq('uid', uid);
      return List<Map<String, dynamic>>.from(response).first;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> recoveryPassword(String email) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> editPostApartment(
      String postId, Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient
          .from(tableApartments)
          .update(data)
          .eq('id', postId)
          .select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> editPostHouse(
      String postId, Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient
          .from(tableHouses)
          .update(data)
          .eq('id', postId)
          .select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> editPostLand(
      String postId, Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient
          .from(tableLands)
          .update(data)
          .eq('id', postId)
          .select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> editPostMotel(
      String postId, Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient
          .from(tableMotels)
          .update(data)
          .eq('id', postId)
          .select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> editPostOffice(
      String postId, Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient
          .from(tableOffices)
          .update(data)
          .eq('id', postId)
          .select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  PostgrestFilterBuilder<dynamic> _defaultFilter(
    String propertyTable,
    PostFilter filter,
  ) {
    var query = supabaseClient
        .from(propertyTable)
        .select()
        .gte('expiry_date', DateTime.now().toIso8601String())
        .eq('status', PostStatus.approved.toString())
        .eq('is_hide', false);
    if (filter.textSearch?.isNotEmpty != null) {
      filter.textSearch = filter.textSearch!.noAccentVietnamese();
      query = query.textSearch('title_description', filter.textSearch!,
          type: TextSearchType.plain);
    }
    if (filter.minPrice != null) {
      query = query.gte('price', filter.minPrice);
    }
    if (filter.maxPrice != null) {
      query = query.lte('price', filter.maxPrice);
    }
    if (filter.minArea != null) {
      query = query.gte('area', filter.minArea);
    }
    if (filter.maxArea != null) {
      query = query.lte('area', filter.maxArea);
    }
    if (filter.isLease != null) {
      print("Filter is_lease: ${filter.isLease}");
      query = query.eq('is_lease', filter.isLease);
    }
    if (filter.postedBy != PostedBy.all) {
      query = query.eq('is_pro_seller', filter.postedBy == PostedBy.proSeller);
    }
    return query;
  }

  Future<List<Map<String, dynamic>>> getAllPosts(PostFilter filter) async {
    try {
      var query = _defaultFilter(tablePost, filter)
          .order(filter.orderBy.filterString, ascending: filter.orderBy.isAsc);
      if (filter.from != null && filter.to != null) {
        query = query.range(filter.from!, filter.to!);
      }
      final data = await query;
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllApartments(
      ApartmentFilter filter) async {
    try {
      var query = _defaultFilter(tableApartments, filter);
      if (filter.isHandedOver != null) {
        query = query.eq('is_hand_over', filter.isHandedOver);
      }
      if (filter.apartmentTypes.isNotEmpty) {
        query = query.in_('apartment_type',
            filter.apartmentTypes.map((e) => e.toString()).toList());
      }
      if (filter.isCorner != null) {
        query = query.eq('is_hand_over', filter.isCorner);
      }
      if (filter.numOfBedrooms.isNotEmpty) {
        final list = filter.numOfBedrooms.where((element) => element <= 10);
        if (list.isNotEmpty) {
          final str1 = 'num_of_bedrooms.in.(${list.join(',')})';
          const str2 = 'num_of_bedrooms.gt.10';
          final filterStr =
              filter.numOfBedrooms.contains(11) ? str1 : '$str1,$str2';
          query.or(filterStr);
        } else {
          query.or('num_of_bedrooms.gt.10');
        }
      }
      if (filter.mainDoorDirections.isNotEmpty) {
        query.in_('main_door_direction',
            filter.mainDoorDirections.map((e) => e.toString()).toList());
      }
      if (filter.balconyDirections.isNotEmpty) {
        query.in_('balcony_direction',
            filter.balconyDirections.map((e) => e.toString()).toList());
      }
      if (filter.legalStatus.isNotEmpty) {
        query.in_('legal_document_status',
            filter.legalStatus.map((e) => e.toString()).toList());
      }
      if (filter.furnitureStatus.isNotEmpty) {
        query.in_('furniture_status',
            filter.furnitureStatus.map((e) => e.toString()).toList());
      }
      PostgrestTransformBuilder queryOrder = query
          .order(filter.orderBy.filterString, ascending: filter.orderBy.isAsc);

      if (filter.from != null && filter.to != null) {
        queryOrder = queryOrder.range(filter.from!, filter.to!);
      }
      final data = await queryOrder;

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAllHouses(HouseFilter filter) async {
    try {
      var query = _defaultFilter(tableHouses, filter);
      if (filter.isFacade != null) {
        query = query.eq('is_facade', filter.isFacade);
      }
      if (filter.isWidensTowardsTheBack != null) {
        query = query.eq(
            'is_widens_towards_the_back', filter.isWidensTowardsTheBack);
      }
      if (filter.hasWideAlley != null) {
        query = query.eq('has_wide_alley', filter.hasWideAlley);
      }
      if (filter.houseTypes.isNotEmpty) {
        query = query.in_(
            'house_type', filter.houseTypes.map((e) => e.toString()).toList());
      }
      if (filter.numOfBedrooms.isNotEmpty) {
        final list = filter.numOfBedrooms.where((element) => element <= 10);
        if (list.isNotEmpty) {
          final str1 = 'num_of_bedrooms.in.(${list.join(',')})';
          const str2 = 'num_of_bedrooms.gt.10';
          final filterStr =
              filter.numOfBedrooms.contains(11) ? str1 : '$str1,$str2';
          query.or(filterStr);
        } else {
          query.or('num_of_bedrooms.gt.10');
        }
      }
      if (filter.mainDoorDirections.isNotEmpty) {
        query.in_('main_door_direction',
            filter.mainDoorDirections.map((e) => e.toString()).toList());
      }
      if (filter.legalStatus.isNotEmpty) {
        query.in_('legal_document_status',
            filter.legalStatus.map((e) => e.toString()).toList());
      }
      if (filter.furnitureStatus.isNotEmpty) {
        query.in_('furniture_status',
            filter.furnitureStatus.map((e) => e.toString()).toList());
      }

      PostgrestTransformBuilder queryOrder = query
          .order(filter.orderBy.filterString, ascending: filter.orderBy.isAsc);

      if (filter.from != null && filter.to != null) {
        queryOrder = queryOrder.range(filter.from!, filter.to!);
      }
      final data = await queryOrder;

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAllLands(LandFilter filter) async {
    try {
      var query = _defaultFilter(tableLands, filter);
      if (filter.isFacade != null) {
        query = query.eq('is_facade', filter.isFacade);
      }
      if (filter.isWidensTowardsTheBack != null) {
        query = query.eq(
            'is_widens_towards_the_back', filter.isWidensTowardsTheBack);
      }
      if (filter.hasWideAlley != null) {
        query = query.eq('has_wide_alley', filter.hasWideAlley);
      }
      if (filter.landTypes.isNotEmpty) {
        query = query.in_(
            'land_type', filter.landTypes.map((e) => e.toString()).toList());
      }
      if (filter.landDirections.isNotEmpty) {
        query.in_('land_direction',
            filter.landDirections.map((e) => e.toString()).toList());
      }
      if (filter.legalStatus.isNotEmpty) {
        query.in_('legal_document_status',
            filter.legalStatus.map((e) => e.toString()).toList());
      }

      PostgrestTransformBuilder queryOrder = query
          .order(filter.orderBy.filterString, ascending: filter.orderBy.isAsc);

      if (filter.from != null && filter.to != null) {
        queryOrder = queryOrder.range(filter.from!, filter.to!);
      }
      final data = await queryOrder;

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAllOffices(OfficeFilter filter) async {
    try {
      var query = _defaultFilter(tableOffices, filter);
      if (filter.officeTypes.isNotEmpty) {
        query = query.in_('office_type',
            filter.officeTypes.map((e) => e.toString()).toList());
      }
      if (filter.mainDoorDirections.isNotEmpty) {
        query.in_('main_door_direction',
            filter.mainDoorDirections.map((e) => e.toString()).toList());
      }
      if (filter.legalStatus.isNotEmpty) {
        query.in_('legal_document_status',
            filter.legalStatus.map((e) => e.toString()).toList());
      }
      if (filter.furnitureStatus.isNotEmpty) {
        query.in_('furniture_status',
            filter.furnitureStatus.map((e) => e.toString()).toList());
      }

      PostgrestTransformBuilder queryOrder = query
          .order(filter.orderBy.filterString, ascending: filter.orderBy.isAsc);

      if (filter.from != null && filter.to != null) {
        queryOrder = queryOrder.range(filter.from!, filter.to!);
      }
      final data = await queryOrder;

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAllMotels(MotelFilter filter) async {
    try {
      var query = _defaultFilter(tableMotels, filter);
      if (filter.furnitureStatus.isNotEmpty) {
        query.in_('furniture_status',
            filter.furnitureStatus.map((e) => e.toString()).toList());
      }

      PostgrestTransformBuilder queryOrder = query
          .order(filter.orderBy.filterString, ascending: filter.orderBy.isAsc);

      if (filter.from != null && filter.to != null) {
        queryOrder = queryOrder.range(filter.from!, filter.to!);
      }
      final data = await queryOrder;

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getPostDetails(
      String postId, PropertyType propertyType) async {
    final response;
    switch (propertyType) {
      case PropertyType.apartment:
        response = await supabaseClient
            .from(tableApartments)
            .select()
            .eq('id', postId);
        break;
      case PropertyType.land:
        response =
            await supabaseClient.from(tableLands).select().eq('id', postId);
        break;
      case PropertyType.office:
        response =
            await supabaseClient.from(tableOffices).select().eq('id', postId);
        break;
      case PropertyType.motel:
        response =
            await supabaseClient.from(tableMotels).select().eq('id', postId);
        break;
      case PropertyType.house:
        response =
            await supabaseClient.from(tableHouses).select().eq('id', postId);
        break;
    }
    return List<Map<String, dynamic>>.from(response).first;
  }

  Stream<List<Map<String, dynamic>>> getAllConversation() async* {
    String uid = supabaseClient.auth.currentUser!.id;
    final res = supabaseClient
        .from('conservations')
        .select(
            '*, user1_info: user_info!conservations_user1_id_fkey(*), user2_info: user_info!conservations_user2_id_fkey(*), messages: messages(*)')
        .or('user1_id.eq.$uid, user2_id.eq.$uid')
        .asStream();
    await for (var x in res) {
      yield List<Map<String, dynamic>>.from(x).toList();
    }
  }

  Future sendMessage(Map<String, dynamic> data) async {
    await supabaseClient.from('messages').insert(data);
  }

  Stream<List<Message>> getMessages(Conversation conversation) {
    print(conversation.toString());
    return supabaseClient
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('sent_at')
        .eq('conversation_id', conversation.id)
        .map((event) => event
            .map((e) => Message.fromJson(e))
            .toList()
            .where((element) => element.sentAt.compareTo(conversation.timeJoined) != -1)
            .toList());
  }

  /// Creates or returns an existing roomID of both participants
  Future<Map<String, dynamic>> getOrCreateConversation(
      String otherUserId) async {
    final data = await supabaseClient.rpc('get_or_create_conversation',
        params: {'user_info_id': otherUserId});
    return data;
  }

  Future<void> markMessagesRead(String conversationId) async {
    await supabaseClient.rpc('mark_messages_read', params: {
      'user_id': supabaseClient.auth.currentUser!.id,
      'conv_id': conversationId,
    });
  }

  Future deleteConversation(String conversationId) async {
    await supabaseClient.rpc('delete_conversation', params: {
      'p_user_id': supabaseClient.auth.currentUser!.id,
      'p_conversation_id': conversationId
    });
  }

  Future<List<Map<String, dynamic>>> getUserPosts(String uid) async {
    final data = await supabaseClient.from('post').select().eq('user_id', uid);
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> extendPost(String id) async {
    log(id);
    await supabaseClient
        .rpc('extend_post_expiry_date', params: {'post_id': id}).then((value) {
      log("Done");
    });
  }

  Future<void> hideOrUnHidePost(String id, bool isHide) async {
    await supabaseClient.from(tablePost).update({
      'is_hide': isHide,
    }).eq('id', id);
  }
}
