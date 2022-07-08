import 'package:huomanduo_owner/pages/orders/model/order_model.dart';

orderModelFromJson(OrderModel data, Map<String, dynamic> json) {
	if (json['order_id'] != null) {
		data.orderId = json['order_id'] is String
				? int.tryParse(json['order_id'])
				: json['order_id'].toInt();
	}
	if (json['send_id'] != null) {
		data.sendId = json['send_id'] is String
				? int.tryParse(json['send_id'])
				: json['send_id'].toInt();
	}
	if (json['carrier_id'] != null) {
		data.carrierId = json['carrier_id'].toString();
	}
	if (json['goods_name'] != null) {
		data.goodsName = json['goods_name'].toString();
	}
	if (json['order_price'] != null) {
		data.orderPrice = json['order_price'] is String
				? int.tryParse(json['order_price'])
				: json['order_price'].toInt();
	}
	if (json['loading_begin_time'] != null) {
		data.loadingBeginTime = json['loading_begin_time'].toString();
	}
	if (json['loading_end_time'] != null) {
		data.loadingEndTime = json['loading_end_time'].toString();
	}
	if (json['send_latitude'] != null) {
		data.sendLatitude = json['send_latitude'] is String
				? double.tryParse(json['send_latitude'])
				: json['send_latitude'].toDouble();
	}
	if (json['send_longitude'] != null) {
		data.sendLongitude = json['send_longitude'] is String
				? double.tryParse(json['send_longitude'])
				: json['send_longitude'].toDouble();
	}
	if (json['send_address'] != null) {
		data.sendAddress = json['send_address'].toString();
	}
	if (json['send_name'] != null) {
		data.sendName = json['send_name'].toString();
	}
	if (json['send_mobile'] != null) {
		data.sendMobile = json['send_mobile'].toString();
	}
	if (json['send_doorplate'] != null) {
		data.sendDoorplate = json['send_doorplate'].toString();
	}
	if (json['receive_latitude'] != null) {
		data.receiveLatitude = json['receive_latitude'] is String
				? double.tryParse(json['receive_latitude'])
				: json['receive_latitude'].toDouble();
	}
	if (json['receive_longitude'] != null) {
		data.receiveLongitude = json['receive_longitude'] is String
				? double.tryParse(json['receive_longitude'])
				: json['receive_longitude'].toDouble();
	}
	if (json['receive_address'] != null) {
		data.receiveAddress = json['receive_address'].toString();
	}
	if (json['receive_name'] != null) {
		data.receiveName = json['receive_name'].toString();
	}
	if (json['receive_mobile'] != null) {
		data.receiveMobile = json['receive_mobile'].toString();
	}
	if (json['receive_doorplate'] != null) {
		data.receiveDoorplate = json['receive_doorplate'].toString();
	}
	if (json['order_status'] != null) {
		data.orderStatus = json['order_status'] is String
				? int.tryParse(json['order_status'])
				: json['order_status'].toInt();
	}
	if (json['release_time'] != null) {
		data.releaseTime = json['release_time'].toString();
	}
	if (json['receive_order_time'] != null) {
		data.receiveOrderTime = json['receive_order_time'].toString();
	}
	if (json['loading_time'] != null) {
		data.loadingTime = json['loading_time'].toString();
	}
	if (json['sure_loading_time'] != null) {
		data.sureLoadingTime = json['sure_loading_time'].toString();
	}
	if (json['unloading_time'] != null) {
		data.unloadingTime = json['unloading_time'].toString();
	}
	if (json['sure_arrival_time'] != null) {
		data.sureArrivalTime = json['sure_arrival_time'].toString();
	}
	return data;
}

Map<String, dynamic> orderModelToJson(OrderModel entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['order_id'] = entity.orderId;
	data['send_id'] = entity.sendId;
	data['carrier_id'] = entity.carrierId;
	data['goods_name'] = entity.goodsName;
	data['order_price'] = entity.orderPrice;
	data['loading_begin_time'] = entity.loadingBeginTime;
	data['loading_end_time'] = entity.loadingEndTime;
	data['send_latitude'] = entity.sendLatitude;
	data['send_longitude'] = entity.sendLongitude;
	data['send_address'] = entity.sendAddress;
	data['send_name'] = entity.sendName;
	data['send_mobile'] = entity.sendMobile;
	data['send_doorplate'] = entity.sendDoorplate;
	data['receive_latitude'] = entity.receiveLatitude;
	data['receive_longitude'] = entity.receiveLongitude;
	data['receive_address'] = entity.receiveAddress;
	data['receive_name'] = entity.receiveName;
	data['receive_mobile'] = entity.receiveMobile;
	data['receive_doorplate'] = entity.receiveDoorplate;
	data['order_status'] = entity.orderStatus;
	data['release_time'] = entity.releaseTime;
	data['receive_order_time'] = entity.receiveOrderTime;
	data['loading_time'] = entity.loadingTime;
	data['sure_loading_time'] = entity.sureLoadingTime;
	data['unloading_time'] = entity.unloadingTime;
	data['sure_arrival_time'] = entity.sureArrivalTime;
	return data;
}