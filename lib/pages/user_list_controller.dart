import 'package:get/get.dart';
import 'package:get_scroll_mixin/models/user_model.dart';
import 'package:get_scroll_mixin/repositories/user_repository.dart';

class UserListController extends GetxController with StateMixin<List<UserModel>>, ScrollMixin{
  final UserRepository _userRepository;

  late final Worker workerPage; 
  final _page = 1.obs;
  final _limit = 10;
  final _loading = false.obs;


  UserListController({required UserRepository userRepository})
      : _userRepository = userRepository;


  bool get isLoading => _loading.value;
  
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
    _loading(true);
    final result = await _userRepository.getUsers(page: _page.value, limit: _limit);

    final stateResult = state ?? [];
    stateResult.addAll(result);

    change(stateResult, status: RxStatus.success());
    _loading(false);
  }

  @override
  void onClose() {
    workerPage;
  }
  
  @override
  Future<void> onEndScroll() async{
    if(!isLoading){
      _page.value++;
    }
  }
  
  @override
  Future<void> onTopScroll() async {}

}
