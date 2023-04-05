import 'package:openrepara_app/models/saleModel.dart';
import 'package:openrepara_app/services/saleService.dart';

class ListSaleViewModel {
  List<SaleViewModel>? list;

  Future<void> getSale() async {
    final apiResult = await SaleService.getSale();

    list = apiResult.map((e) => SaleViewModel(e)).toList();
  }
}

class SaleViewModel {
  SaleModel saleModel;
  SaleViewModel(this.saleModel);
}
