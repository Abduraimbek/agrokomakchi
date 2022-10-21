import 'package:agrokomakchi/utils/my_message_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> myHasConnection() async {
  final result = await Connectivity().checkConnectivity();

  return result == ConnectivityResult.ethernet ||
      result == ConnectivityResult.mobile ||
      result == ConnectivityResult.wifi;
}

Future<bool> myCheckConnection() async {
  final internet = await myHasConnection();

  if (!internet) {
    showMyMessageDialog(
      "Интернет тармоғига уланмаган. Ёки VPN тармоғини ўчиринг.",
    );
  }

  return internet;
}
