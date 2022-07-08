import 'package:huomanduo_owner/generated/json/base/json_convert_content.dart';
import 'package:huomanduo_owner/generated/json/base/json_field.dart';

class OrderModel with JsonConvert<OrderModel> {
	@JSONField(name: "order_id")
	late int orderId;
	@JSONField(name: "send_id")
	late int sendId;
	@JSONField(name: "carrier_id")
	late String carrierId;
	@JSONField(name: "goods_name")
	late String goodsName;
	@JSONField(name: "order_price")
	late int orderPrice;
	@JSONField(name: "loading_begin_time")
	late String loadingBeginTime;
	@JSONField(name: "loading_end_time")
	late String loadingEndTime;
	@JSONField(name: "send_latitude")
	late double sendLatitude;
	@JSONField(name: "send_longitude")
	late double sendLongitude;
	@JSONField(name: "send_address")
	late String sendAddress;
	@JSONField(name: "send_name")
	late String sendName;
	@JSONField(name: "send_mobile")
	late String sendMobile;
	@JSONField(name: "send_doorplate")
	late String sendDoorplate;
	@JSONField(name: "receive_latitude")
	late double receiveLatitude;
	@JSONField(name: "receive_longitude")
	late double receiveLongitude;
	@JSONField(name: "receive_address")
	late String receiveAddress;
	@JSONField(name: "receive_name")
	late String receiveName;
	@JSONField(name: "receive_mobile")
	late String receiveMobile;
	@JSONField(name: "receive_doorplate")
	late String receiveDoorplate;
	@JSONField(name: "order_status")
	late int orderStatus;
	@JSONField(name: "release_time")
	late String releaseTime;
	@JSONField(name: "receive_order_time")
	late String receiveOrderTime;
	@JSONField(name: "loading_time")
	late String loadingTime;
	@JSONField(name: "sure_loading_time")
	late String sureLoadingTime;
	@JSONField(name: "unloading_time")
	late String unloadingTime;
	@JSONField(name: "sure_arrival_time")
	late String sureArrivalTime;
}
