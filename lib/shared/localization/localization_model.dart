import 'dart:convert';

class LocalizationModel
{
  final String search;
  final String enterSearch;
  final String cart;
  final String settings;
  final String english;
  final String arabic;
  final String darkMode;
  final String load;
  final String addToCart;

  LocalizationModel({
    this.search,
    this.enterSearch,
    this.cart,
    this.settings,
    this.english,
    this.arabic,
    this.darkMode,
    this.load,
    this.addToCart,
  });

  factory LocalizationModel.fromJson(data)
  {
    Map<String, dynamic> json = jsonDecode(data);

    return LocalizationModel(
      search: json['search'] as String,
      enterSearch: json['enterSearch'] as String,
      cart: json['cart'] as String,
      settings: json['settings'] as String,
      english: json['english'] as String,
      arabic: json['arabic'] as String,
      darkMode: json['darkMode'] as String,
      load: json['load'] as String,
      addToCart: json['addToCart'] as String,
    );
  }
}