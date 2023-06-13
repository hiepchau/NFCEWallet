import 'dart:io';

import 'package:dio/dio.dart';

import '../model/remote/base_response.dart';
import 'package:retrofit/retrofit.dart';

part 'app_service.g.dart';

@RestApi()
abstract class AppService {
  factory AppService(Dio dio, {String baseUrl}) = _AppService;

  @POST("/login")
  Future<HttpResponse<LoginResponse>> login(@Body() Map<String, dynamic> request);

  @GET("/logout")
  Future<HttpResponse> logout(@Header('Authorization') String token);

  @POST("/register")
  Future<HttpResponse> register(@Body() Map<String, dynamic> request);

  @GET("/user/full")
  Future<HttpResponse<BaseResponse>> getUser(@Header('Authorization') String token);

  @PUT("/user/update")
  Future<HttpResponse> updateUser(@Header('Authorization') String token, @Body() Map<String, dynamic> request);

  @GET("/avatar/list/{id}")
  Future<HttpResponse<AvatarResponse>> getListAvatarId(@Path('id') String id);

  @POST("/avatar/")
  @MultiPart()
  Future<HttpResponse> updateAvatar(@Header('Authorization') String token, @Part(name: "avatar") File file);


  @GET("/car?page={page}")
  Future<HttpResponse<ListModelResponse>> getListCarFromPage(@Path("page") int page);

  @GET("/car/{id}")
  Future<HttpResponse<BaseResponse>> getCarById(@Path('id') String id);

  //TODO: read this query
  @GET("/car")
  Future<HttpResponse<ListModelResponse>> getListCarQuery(
      @Query('page') int page,
      @Query('owner') String? owner,
      @Query('brand') String? brand,
      @Query('color') String? color,
      @Query('province') String? province,
      @Query('city') String? city,
      @Query('address') String? address,
      @Query('maxPrice')double? maxPrice,
      @Query('minPrice')double? minPrice);

  @GET("/hotel/page/{page}")
  Future<HttpResponse<ListModelResponse>> getListHotelByQuery(
      @Path('page') int page,
      @Query('owner') String? owner,
      @Query('name') String? name,
      @Query('address') String? address,
      @Query('description') String? description,
      @Query('city') String? city,
      @Query('province') String? province,
      @Query('maxPrice')double? maxPrice,
      @Query('minPrice')double? minPrice);

  @GET("/hotel/page/{page}")
  Future<HttpResponse<ListModelResponse>> getListHotelFromPage(@Path('page') int page);

  @GET("/hotel/{id}/room")
  Future<HttpResponse<ListModelResponse>> getListHotelRoomById(@Path('id') String id);

  @GET("/article/page/{page}")
  Future<HttpResponse<ListModelResponse>> getListIdArticleFromPage(@Path('page') int page);

  @GET("/article/{id}")
  Future<HttpResponse<BaseResponse>> getArticleById(@Path('id') String id);

  @GET("/article/page/")
  Future<HttpResponse<int>> getArticleMaxPage();

  @POST("/article/")
  @MultiPart()
  Future<HttpResponse> createArticle(
      {
        @Header('Authorization') required String token,
        @Part(name: "title") required String title,
        @Part(name: "description") required String description,
        @Part(name: "address") required String address,
        @Part(name: "province") required String province,
        @Part(name: "city") required String district,
        @Part(name: "referenceName") required String referenceName,
        @Part(name: "files") required List<File> files
      });

  @POST("/hotel/")
  @MultiPart()
  Future<HttpResponse> createHotel({
    @Header("Authorization") required String token,
    @Part(name: "name") required String name,
    @Part(name: "description") required String description,
    @Part(name: "address") required String address,
    @Part(name: "province") required String province,
    @Part(name: "city") required String district,
    @Part(name: "files") required List<File> files
  });

  @POST("/car/")
  @MultiPart()
  Future<HttpResponse> createCar({
    @Header("Authorization") required String token,
    @Part(name: "licensePlate") required String plate,
    @Part(name: "brand") required String brand,
    @Part(name: "address") required String address,
    @Part(name: "province") required String province,
    @Part(name: "city") required String district,
    @Part(name: "description") required String description,
    @Part(name: "seats") required int seats,
    @Part(name: "pricePerDay") required double price,
    @Part(name: "color") required String color,
    @Part(name: "files") required List<File> files
  });
}