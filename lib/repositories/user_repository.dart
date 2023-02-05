import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_scroll_mixin/models/user_model.dart';

class UserRepository {
  final Dio _dio;

  UserRepository({
    required Dio dio,
  }) : _dio = dio;

  Future<List<UserModel>> getUsers({required int page, required int limit}) async {
    try {
      debugPrint('Buscando pagina $page');
      await Future.delayed(const Duration(seconds: 2));
      final result = await _dio.get('/users', queryParameters: {
        'page': page,
        'limit': limit,
      });

      return result.data
          .map<UserModel>((user) => UserModel.fromMap(user)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar usuários', error: e, stackTrace: s);
      throw Exception();
    }
  }
}
