class ApiUrl {
  static const String baseUrl = 'http://192.168.43.148:8080';

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listProduk = baseUrl + '/komputer';
  static const String createProduk = baseUrl + '/komputer';

  static String updateProduk(int id) {
    return baseUrl + '/komputer/' + id.toString();
  }

  static String showProduk(int id) {
    return baseUrl + '/komputer/' + id.toString();
  }

  static String deleteProduk(int id) {
    return baseUrl + '/komputer/' + id.toString();
  }
}