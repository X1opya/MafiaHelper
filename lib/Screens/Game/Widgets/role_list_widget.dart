import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mafia_helper/Models/role.dart';
import 'package:mafia_helper/Screens/Game/Widgets/role_cell_widget.dart';
import 'package:mafia_helper/UICommon/bases_state.dart';

class RoleListWidget extends StatefulWidget {
  RoleListWidget({Key? key, required this.roles}) : super(key: key);
  List<Role> roles;

  @override
  State<StatefulWidget> createState() {
    return RoleListWidgetState();
  }
}

class RoleListWidgetState extends BaseState<RoleListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.roles.length,
        itemBuilder: (context, index) {
          return RoleCellWidget(role: widget.roles[index], number: index+1,);
        });
  }
}
