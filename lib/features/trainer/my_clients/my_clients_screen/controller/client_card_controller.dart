import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/trainer/my_clients/my_clients_screen/model/client_card_model.dart';

class ClientCardController extends GetxController {
  final trainer = <ClientCardModel>[
    ClientCardModel(
      name: "Alex Carter",
      goal: "Weight Loss",
      nextSession: "Sept 6, 7:30 PM",
      imageUrl: Imagepath.trainer,
      status: 'active',
    ),
    ClientCardModel(
      name: "Emma Johnson",
      goal: "Muscle Gain",
      nextSession: "Sept 10, 6:00 PM",
      imageUrl: Imagepath.trainer,
      status: 'paused',
    ),
    ClientCardModel(
      name: "Emma Johnson",
      goal: "Muscle Gain",
      nextSession: "Sept 10, 6:00 PM",
      imageUrl: Imagepath.trainer,
      status: 'completed',
    ),
  ].obs;
}
