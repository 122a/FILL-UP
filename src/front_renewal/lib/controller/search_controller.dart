import 'package:get/get.dart';

class SearchController extends GetxController {
  var query = ''.obs;

  void setQuery(String newQuery) {
    query.value = newQuery;
  }
}
