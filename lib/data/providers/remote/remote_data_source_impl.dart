import 'dart:developer';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/models/message.dart';
import 'package:nha_gia_re/data/models/properties/motel.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/providers/remote/request/filter_request.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteDataSourceImpl extends RemoteDataSource {
  final SupabaseClient supabaseClient = Supabase.instance.client;

  @override
  Future<AuthResponse> signUp(
      {required String email, required String password}) async {
    try {
      return await supabaseClient.auth.signUp(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponse> signIn(
      {required String email, required String password}) async {
    try {
      return await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> data) async {
    try {
      print(supabaseClient.auth.currentUser!.id);
      print(data);
      final res = await supabaseClient
          .from('user_info')
          .update(data)
          .eq('uid', supabaseClient.auth.currentUser!.id)
          .select();
      inspect(res);
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletedPost(String id) async {
    try {
      await supabaseClient.from('post').delete().eq('id', id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> postApartment(Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient.from('apartments').insert(data).select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> postHouse(Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient.from('houses').insert(data).select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> postLand(Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient.from('lands').insert(data).select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> postMotel(Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient.from('motels').insert(data).select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> postOffice(Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient.from('offices').insert(data).select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getUserInfo(String uid) async {
    try {
      final response =
          await supabaseClient.from('user_info').select().eq('uid', uid);
      return List<Map<String, dynamic>>.from(response).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> recoveryPassword(String email) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> editPostApartment(
      String postId, Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient
          .from('apartments')
          .update(data)
          .eq('id', postId)
          .select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> editPostHouse(
      String postId, Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient
          .from('houses')
          .update(data)
          .eq('id', postId)
          .select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> editPostLand(
      String postId, Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient
          .from('lands')
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
          .from('motels')
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
          .from('offices')
          .update(data)
          .eq('id', postId)
          .select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  String _noAccentVietnamese(String s) {
    s = s.replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), 'a');
    s = s.replaceAll(RegExp(r'[ÀÁẠẢÃĂẰẮẶẲẴÂẦẤẬẨẪ]'), 'A');
    s = s.replaceAll(RegExp(r'[èéẹẻẽêềếệểễ]'), 'e');
    s = s.replaceAll(RegExp(r'[ÈÉẸẺẼÊỀẾỆỂỄ]'), 'E');
    s = s.replaceAll(RegExp(r'[òóọỏõôồốộổỗơờớợởỡ]'), 'o');
    s = s.replaceAll(RegExp(r'[ÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ]'), 'O');
    s = s.replaceAll(RegExp(r'[ìíịỉĩ]'), 'i');
    s = s.replaceAll(RegExp(r'[ÌÍỊỈĨ]'), 'I');
    s = s.replaceAll(RegExp(r'[ùúụủũưừứựửữ]'), 'u');
    s = s.replaceAll(RegExp(r'[ƯỪỨỰỬỮÙÚỤỦŨ]'), 'U');
    s = s.replaceAll(RegExp(r'[ỳýỵỷỹ]'), 'y');
    s = s.replaceAll(RegExp(r'[ỲÝỴỶỸ]'), 'Y');
    s = s.replaceAll(RegExp(r'[Đ]'), 'D');
    s = s.replaceAll(RegExp(r'[đ]'), 'd');
    return s;
  }

  PostgrestFilterBuilder<dynamic> _defaultFilter(
    String propertyTable,
    PostFilter filter,
  ) {
    var query = supabaseClient.from(propertyTable).select();
    if (filter.textSearch?.isNotEmpty != null) {
      filter.textSearch = _noAccentVietnamese(filter.textSearch!);
      query = query.textSearch('title_description', filter.textSearch!,
          type: TextSearchType.plain);
    }
    query = query
        .lte('expiry_date', DateTime.now().toIso8601String())
        .gte('price', filter.minPrice)
        .lte('price', filter.maxPrice)
        .gte('area', filter.minArea)
        .lte('area', filter.maxArea);
    if (filter.postedBy != PostedBy.all) {
      query = query.eq('is_pro_seller', filter.postedBy == PostedBy.proSeller);
    }
    return query;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllPosts(PostFilter filter) async {
    try {
      var data = await _defaultFilter('post', filter)
          .order(filter.orderBy.filterString, ascending: filter.orderBy.isAsc)
          .range(filter.from, filter.to);
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
      var query = _defaultFilter('apartments', filter);
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
      final data = await query
          .order(filter.orderBy.filterString, ascending: filter.orderBy.isAsc)
          .range(filter.from, filter.to);
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllHouses(HouseFilter filter) async {
    try {
      var query = _defaultFilter('apartments', filter);
      if (filter.isFacade != null) {
        query = query.eq('is_face', filter.isFacade);
      }
      if (filter.isWidensTowardsTheBack != null) {
        query = query.eq(
            'is_widens_towards_the_back', filter.isWidensTowardsTheBack);
      }
      if (filter.isFacade != null) {
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
      final data = await query
          .order(filter.orderBy.filterString, ascending: filter.orderBy.isAsc)
          .range(filter.from, filter.to);
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllLands(LandFilter filter) async {
    try {
      var query = _defaultFilter('apartments', filter);
      if (filter.isFacade != null) {
        query = query.eq('is_face', filter.isFacade);
      }
      if (filter.isWidensTowardsTheBack != null) {
        query = query.eq(
            'is_widens_towards_the_back', filter.isWidensTowardsTheBack);
      }
      if (filter.isFacade != null) {
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
      final data = await query
          .order(filter.orderBy.filterString, ascending: filter.orderBy.isAsc)
          .range(filter.from, filter.to);
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllOffices(OfficeFilter filter) async {
    try {
      var query = _defaultFilter('apartments', filter);
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
      final data = await query
          .order(filter.orderBy.filterString, ascending: filter.orderBy.isAsc)
          .range(filter.from, filter.to);
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllMotels(MotelFilter filter) async {
    try {
      var query = _defaultFilter('apartments', filter);
      if (filter.furnitureStatus.isNotEmpty) {
        query.in_('furniture_status',
            filter.furnitureStatus.map((e) => e.toString()).toList());
      }
      final data = await query
          .order(filter.orderBy.filterString, ascending: filter.orderBy.isAsc)
          .range(filter.from, filter.to);
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getPostDetails(
      String postId, PropertyType propertyType) async {
    final response;
    switch (propertyType) {
      case PropertyType.apartment:
        response =
            await supabaseClient.from('apartments').select().eq('id', postId);
        break;
      case PropertyType.land:
        response = await supabaseClient.from('lands').select().eq('id', postId);
        break;
      case PropertyType.office:
        response =
            await supabaseClient.from('offices').select().eq('id', postId);
        break;
      case PropertyType.motel:
        response =
            await supabaseClient.from('motels').select().eq('id', postId);
        break;
      case PropertyType.house:
        response =
            await supabaseClient.from('houses').select().eq('id', postId);
        break;
    }
    return List<Map<String, dynamic>>.from(response).first;
  }


  @override
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

  @override
  Future sendMessage(Map<String, dynamic> data) async {
    await supabaseClient.from('messages').insert(data);
  }

  @override
  Stream<List<Message>> getMessages(String conversationId) {
    return supabaseClient
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('sent_at')
        .eq('conversation_id', conversationId)
        .map((event) => event.map((e) => Message.fromJson(e)).toList());
  }

  /// Creates or returns an existing roomID of both participants
  @override
  Future<Map<String, dynamic>> getOrCreateConversation(
      String otherUserId) async {
    final data = await supabaseClient.rpc('get_or_create_conversation',
        params: {'user_info_id': otherUserId});
    return data;
  }
}
