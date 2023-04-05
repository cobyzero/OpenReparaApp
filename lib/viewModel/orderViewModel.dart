import 'package:openrepara_app/models/orderModel.dart';
import 'package:openrepara_app/services/orderService.dart';

class ListOrderViewModel {
  List<OrderViewModel>? list;

  Future<void> getOrders() async {
    final apiResult = await OrderService.getOrder();

    list = apiResult.map((e) => OrderViewModel(e)).toList();
  }

  Future<void> getOrdersForCode(String code) async {
    final apiResult = await OrderService.getOrderForCode(code);

    list = apiResult.map((e) => OrderViewModel(e)).toList();
  }

  Future<void> putStatus(OrderViewModel orderViewModel) async {
    await OrderService.putOrderStatus(orderViewModel.orderModel);
  }

  Future<void> deleteOrder(OrderViewModel orderViewModel) async {
    await OrderService.deleteOrder(orderViewModel.orderModel);
  }

  Future<void> addOrder(OrderViewModel orderViewModel) async {
    await OrderService.addOrder(orderViewModel.orderModel);
  }
}

class OrderViewModel {
  OrderModel orderModel;

  OrderViewModel(this.orderModel);
}
