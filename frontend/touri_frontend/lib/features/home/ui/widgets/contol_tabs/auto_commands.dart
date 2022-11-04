import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:touri_frontend/features/home/bloc/services.dart';

class RobotAutonomousCommands extends StatelessWidget {
  const RobotAutonomousCommands({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 300,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _CommandsCard(
                imgSrc: "https://c.tenor.com/oIvM4M1RHzQAAAAC/borat-dancing.gif",
                skillId: "dance",
                skillName: "DANCE",
              ),
              _CommandsCard(
                imgSrc: "https://thumbs.gfycat.com/InfiniteWellinformedFrillneckedlizard-size_restricted.gif",
                skillId: "high_five",
                skillName: "High five",
              ),
              _CommandsCard(
                imgSrc: "https://i.pinimg.com/originals/e9/d9/d4/e9d9d40eef4ab994670c08524e35bbdb.gif",
                skillId: "punch",
                skillName: "Punch",
              ),
              _CommandsCard(
                imgSrc: "https://c.tenor.com/brnodx0D_d8AAAAC/the-office-raise-the-roof.gif",
                skillId: "vibe",
                skillName: "Vibe",
              ),
              _CommandsCard(
                imgSrc:
                    "https://www.emugifs.net/wp-content/uploads/2021/09/Homer-Hiding-GIF-Make-Your-MEME-With-Homer-Simpson-and-Share-on-Facebook-Comment-Like-a-Reaction-GIFs.gif",
                skillId: "goodbye",
                skillName: "Goodbye",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommandsCard extends StatelessWidget {
  final String imgSrc;
  final String skillId;
  final String skillName;

  const _CommandsCard({
    Key? key,
    required this.imgSrc,
    required this.skillId,
    required this.skillName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: StreamBuilder<Object>(
          stream: FirebaseDatabase.instance.ref().child("skill_req").onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              DatabaseEvent event = snapshot.data as DatabaseEvent;
              final String selectedSkillId = event.snapshot.child("id").value.toString();
              final bool inProgress = event.snapshot.child("inProgress").value! as bool;
              return GestureDetector(
                onTap: () {
                  if (!inProgress) {
                    TeleOpServices.performSkill(skillId);
                  }
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  elevation: 10,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  semanticContainer: true,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          imgSrc,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(color: Colors.black.withOpacity(0.6)),
                      if (skillId == selectedSkillId && inProgress) ...[
                        const CircularProgressIndicator(),
                      ] else ...[
                        Text(
                          skillName.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
