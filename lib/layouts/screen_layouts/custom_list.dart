import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomList extends StatelessWidget {
  const CustomList({
    Key? key,
    required this.itemCount,
    required this.itemList,
    required this.handleOnPressedDeleteSlideAction,
    required this.handleOnPressedUpdateSlideAction,
  }) : super(key: key);

  final int itemCount;
  final List itemList;
  final Function(BuildContext context, String itemName, int itemId)
      handleOnPressedDeleteSlideAction;
  final Function(BuildContext context, Object item)
      handleOnPressedUpdateSlideAction;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final item = itemList[index];
          var subtitle =
              'P: ${item.protein} G: ${item.carbohydrate} C: ${item.calorie}';
          return Slidable(
              key: Key('meal-index-$index'),
              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: handleOnPressedDeleteSlideAction(
                        context, item.name, item.id),
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Supprimer',
                  )
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: handleOnPressedUpdateSlideAction(context, item),
                    backgroundColor: const Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.update,
                    label: 'Modifier',
                  ),
                ],
              ),
              child: ListTile(
                title: Text(item.name ?? ''),
                subtitle: Text(subtitle),
              ));
        });
  }
}
