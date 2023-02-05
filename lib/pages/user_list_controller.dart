import 'package:get/get.dart';
import 'package:get_scroll_mixin/models/user_model.dart';
import 'package:get_scroll_mixin/repositories/user_repository.dart';

class UserListController extends GetxController with StateMixin<List<UserModel>>, ScrollMixin{
  final UserRepository _userRepository;

  late final Worker workerPage; 
  final _page = 1.obs;
  final _limit = 10;

  UserListController({required UserRepository userRepository})
      : _userRepository = userRepository;


    @override
  void onInit() {
    workerPage = ever<int>(_page, (_){
      _findUser();
    });
    super.onInit();
  }

  void atualizar() => _page.value++;

  @override
  void onReady() {
    _findUser();
    super.onReady();
  }
  
  Future<void> _findUser() async {
    final result = await _userRepository.getUsers(page: _page.value, limit: _limit);

    final stateResult = state ?? [];
    stateResult.addAll(result);

    change(stateResult, status: RxStatus.success());
  }

  @override
  void onClose() {
    workerPage;
  }
  
  @override
  Future<void> onEndScroll() async{
    _page.value++;
  }
  
  @override
  Future<void> onTopScroll() async {}

}
