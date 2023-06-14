import 'dart:io';

import 'package:dio/dio.dart';

import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/article.dart';
import '../remote/app_service.dart';
import '../remote/request_factory.dart';

class ArticleRepo {
  final EventBus _eventBus;
  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final AppService _appService;
  final RequestFactory _requestFactory;

  ArticleRepo(this._logger, this._sharedPreferences, this._appService,
      this._requestFactory, this._eventBus);

  Future<int?> getMaxPage() async {
    return _appService
        .getArticleMaxPage()
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data;
      }
    });
  }

  Future<Article?> getArticleById(String id) async {
    return _appService.getArticleById(id).then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toArticle();
      }
    });
  }

  Future<List<String>?> getListId(int page) async {
    return _appService
        .getListIdArticleFromPage(page)
        .then((http) async {
      if (http.response.statusCode != 200) {
        return null;
      }
      else{
        return http.data.toListIdArticle();
      }
    });
  }

  Future<bool> createPost(String token, String title, String description, String address, String province, String district, String referenceName, List<File> files) async {
    return _appService.createArticle(title: title, description: description, address: address, province :province, district: district, referenceName: referenceName, token: token, files: files).then((http) async {
      if (http.response.statusCode != 200) {
        return false;
      }
      else{
        return true;
      }
    });
  }
}
