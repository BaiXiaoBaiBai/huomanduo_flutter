

class HttpUrl {

  // 连接服务器超时时间，单位是毫秒
  static const int CONNECT_TIMEOUT = 30000;
  // 接收超时时间，单位是毫秒
  static const int RECEIVE_TIMEOUT = 30000;

  static const String BASE_TOKEN = "";

  static const String userConfig_url = 'mobile/Userconfig';

  static const String baseUrl = 'http://39.100.138.157:9090/';
  
  static const String amap_regeoGeocode_URL = 'https://restapi.amap.com/v3/geocode/regeo';//高德地图web逆地理编码

  static const String userLogin_URL = 'user/user-login';
  static const String userInfo_URL = 'user/user-info';
  static const String editUser_URL = 'user/edit-user';

  static const String submitSendGoods_URL = 'order/saveOrder';
  static const String orderList_URL = 'order/queryAllOrder';

}