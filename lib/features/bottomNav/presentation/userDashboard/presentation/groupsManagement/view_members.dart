import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/widgets/player_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewGroupMembers extends StatelessWidget {
    final List<UserModel> players;
  const ViewGroupMembers({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body:  Column(children: [
            
            ListView.builder(
                itemCount: 10,
                itemBuilder:(context, index) {
                    final UserModel player = players[index];
          return PlayerCard(
                                      name: player.name!,
                                      image: player.pic!,
                                      playerId: player.pId.toString(),
                                      showArrow: false,);
        },)],)  
                                  
    );
  }
}