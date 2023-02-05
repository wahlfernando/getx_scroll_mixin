import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_scroll_mixin/pages/user_list_controller.dart';

class UserListPage extends StatelessWidget {

  final controller = Get.find<UserListController>();

  UserListPage({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('User List '),),
           floatingActionButton: FloatingActionButton(onPressed: () => controller.atualizar(),),
           body: controller.obx((state) {
            return ListView.builder(
              controller: controller.scroll,
              itemCount: state?.length ?? 0,
              itemBuilder: (context, index){
                final user = state?[index];
                return ListTile(
                  title: Text(user?.name ?? ''),
                  subtitle: Text(user?.email ?? ''),
                );
            });
           }),
       );
  }
}