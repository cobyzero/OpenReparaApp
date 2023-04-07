import 'package:openrepara_app/models/inventoryModel.dart';
import 'package:openrepara_app/services/inventoryService.dart';

class ListInventoryViewModel {
  List<InventoryViewModel>? list;

  Future<void> getInventory() async {
    final apiResult = await InventoryService.getInventory();

    list = apiResult.map((e) => InventoryViewModel(e)).toList();
  }

  Future<void> getInventoryForCode(String code) async {
    final apiResult = await InventoryService.getInventoryForCode(code);

    list = apiResult.map((e) => InventoryViewModel(e)).toList();
  }

  Future<void> putInventory(InventoryViewModel inventoryViewModel) async {
    await InventoryService.putInventory(inventoryViewModel.inventoryModel);
  }

  Future<void> deleteInventory(InventoryViewModel inventoryViewModel) async {
    await InventoryService.deleteInventory(inventoryViewModel.inventoryModel);
  }
}

class InventoryViewModel {
  InventoryModel inventoryModel;

  InventoryViewModel(this.inventoryModel);
}
