import 'package:flutter/material.dart';

class AutonomousOptionsListView extends StatelessWidget {
  final List commandList;
  final Function(String? cmdId) onCmdSelected;

  const AutonomousOptionsListView({
    Key? key,
    required this.commandList,
    required this.onCmdSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 75,
      child: ListView.builder(
        itemCount: commandList.length,
        shrinkWrap: true,
        // scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => AutonomousOptionsTile(
          label: commandList[index],
          onPressed: () => onCmdSelected(commandList[index]), //TODO: ADD BLOC LOGIC HERE
        ),
      ),
    );
  }
}
//______________________________________________________________________________________________________________

class AutonomousCommands extends StatelessWidget {
  final Function getCmdList;
  final Function(String? cmdId) onCmdSelected;

  const AutonomousCommands({
    Key? key,
    required this.getCmdList,
    required this.onCmdSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCmdList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List cmdList = snapshot.data! as List;
          return AutonomousOptionsListView(
            commandList: cmdList,
            onCmdSelected: (id) => onCmdSelected(id),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

//______________________________________________________________________________________________________________
class AutonomousOptionsTile extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AutonomousOptionsTile({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        // TEXT
        child: Text(
          label.toUpperCase(),
          style: TextStyle(fontSize: 14),
        ),
        // STYLE
        style: ElevatedButton.styleFrom(
          primary: label.toUpperCase() == "DEGRASP" ? Colors.grey : Colors.red.withOpacity(0.4),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 35),
        ),
        // ON PRESSED
        onPressed: onPressed,
      ),
    );
  }
}
