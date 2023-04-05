import 'package:openrepara_app/models/clientModel.dart';
import 'package:openrepara_app/services/clientService.dart';

class ListClientViewModel {
  List<ClientViewModel>? clientViewModel;

  Future<void> getData() async {
    final apiResult = await ClientService.getClient();

    clientViewModel = apiResult.map((e) => ClientViewModel(e)).toList();
  }

  Future<void> getClienteForCode(String text) async {
    final apiResult = await ClientService.getClientForCode(text);

    clientViewModel = apiResult.map((e) => ClientViewModel(e)).toList();
  }

  Future<void> deleteCliente(ClientViewModel clientModel) async {
    await ClientService.deleteClient(clientModel);
  }

  Future<void> putCliente(ClientViewModel clientModel) async {
    await ClientService.putClient(clientModel);
  }
}

class ClientViewModel {
  ClientModel clientModel;

  ClientViewModel(this.clientModel);
}
