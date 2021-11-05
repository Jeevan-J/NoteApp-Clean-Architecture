part of '../add_update_note_screen.dart';

class _AddTodoTile extends StatelessWidget {
  const _AddTodoTile({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.6,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        title: Row(
          children: [
            Text(
              'Add todo',
              style: AppTypography.title,
            ),
            const SizedBox(width: 12),
            const Icon(
              FeatherIcons.plusCircle,
              size: 18,
              color: AppColors.title,
            ),
          ],
        ),
        onTap: onAdd,
      ),
    );
  }
}

//* Todo list tile
class _TodoFieldTile extends StatefulWidget {
  const _TodoFieldTile({
    Key? key,
    this.value,
    required this.onChanged,
  }) : super(key: key);

  final String? value;
  final Function(String value) onChanged;

  @override
  State<_TodoFieldTile> createState() => _TodoFieldTileState();
}

class _TodoFieldTileState extends State<_TodoFieldTile> {
  late TextEditingController todoController;

  @override
  void initState() {
    super.initState();
    todoController = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: TextField(
        style: AppTypography.title,
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: 'Todo..',
          hintStyle: AppTypography.title.copyWith(
            color: AppColors.title.withOpacity(0.6),
          ),
        ),
        onChanged: widget.onChanged,
        maxLines: 4,
        minLines: 1,
      ),
      trailing: IconButton(
        iconSize: 18,
        icon: const Icon(
          FeatherIcons.trash2,
          color: Colors.black87,
        ),
        onPressed: () {},
      ),
    );
  }
}

class _BuildTodoListField extends StatelessWidget {
  const _BuildTodoListField({Key? key, required this.state}) : super(key: key);
  final AddUpdateFormState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.hasTodo)
          Text(
            "TODO's",
            style: AppTypography.headline6
                .copyWith(decoration: TextDecoration.underline),
          ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: state.todos.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final Todo todo = state.todos[index];

            return _TodoFieldTile(
              value: todo.title,
              onChanged: (value) {},
            );
          },
        ),
        _AddTodoTile(
          onAdd: () {},
        ),
      ],
    );
  }
}