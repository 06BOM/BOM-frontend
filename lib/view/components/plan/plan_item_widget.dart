import 'package:bom_front/view/add_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; // useFocus , useTextEditingController, useState, useEffect
import 'package:bom_front/provider/todo_provider.dart';
import '../../../model/todo.dart';
import '../../../utils.dart';
import '../../timer_view.dart';

class PlanItem extends StatefulHookConsumerWidget {
  final bool type; // for each page change
  const PlanItem({Key? key, required this.type}) : super(key: key);

  @override
  _PlanItemState createState() => _PlanItemState();
}

class _PlanItemState extends ConsumerState<PlanItem> {
  @override
  Widget build(BuildContext context) {
    final todo = ref.watch(currentTodo);
    print('planItem ${todo.planId} ${todo.repetitionType} rebuilding...');
    final itemFocusNode = useFocusNode();
    final itemIsFocused = useIsFocused(itemFocusNode);
    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return widget.type == true
        ? Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Material(
              color: Colors.white,
              elevation: 3,
              borderRadius: BorderRadius.circular(4),
              child: ListTile(
                enabled: !todo.check!, // 체크시 일정 종료 (터치 불가)
                onTap: () {},
                trailing: Checkbox(
                  shape: const CircleBorder(),
                  activeColor: const Color(0xffA876DE),
                  value: todo.check,
                  onChanged: (value) => {},
                ),
                title: itemIsFocused
                    ? TextField(
                        autofocus: true,
                        focusNode: textFieldFocusNode,
                        controller: textEditingController,
                      )
                    : Text(todo.planName!,
                        style: const TextStyle(fontSize: 18.0)),
              ),
            ))
        : Container(
            // ------------------------------------------------------------------------------------------
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Checkbox(
                  shape: const CircleBorder(),
                  activeColor: const Color(0xffA876DE),
                  value: todo.check,
                  onChanged: (value) {
                    ref.read(todoListProvider.notifier).editReadTodo(
                        todo.planId,
                        check: !todo.check!); // 여기만 수정되고 나머지는 rebuild x
                    ref.read(todoListProvider.notifier).toggle(todo.planId);
                  }, // 바로 refresh 방지
                ),
                Expanded(
                  child: Material(
                    color: Colors.white,
                    elevation: 3,
                    borderRadius: BorderRadius.circular(4),
                    child: Slidable(
                      key: ValueKey(todo.planId),
                      endActionPane: ActionPane(
                        extentRatio: 0.25,
                        // 두개일 땐, 0.4
                        motion: const DrawerMotion(),
                        // or DrawerMotion or StretchMotion
                        // dismissible: DismissiblePane(onDismissed: () {print('dismissed');}), // 슬라이드로 지우고 싶을 때,
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              print(ref
                                  .read(todoListProvider.notifier)
                                  .runtimeType);
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [Text('삭제')]),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const <Widget>[
                                        Expanded(
                                          child: Text(
                                            '선택한 목표를 삭제하시겠습니까?  공부 시간은 삭제되지 않습니다.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                          child: const Text('확인',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                          onPressed: () {
                                            ref
                                                .read(todoListProvider.notifier)
                                                .remove(todo); // 🌟
                                            ref
                                                .read(todoListProvider.notifier)
                                                .deleteReadTodo(todo.planId!)
                                                .then((value) => {
                                                      if (value == true)
                                                        {
                                                          Dialog(
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: const [
                                                                CircularProgressIndicator(),
                                                                Text(
                                                                    "삭제되었습니다."),
                                                              ],
                                                            ),
                                                          ),
                                                        }
                                                    });
// ref
//     .refresh(todoListProvider
//     .notifier)
//     .getReadTodo(); // 이걸 써보고 로딩이 너무 길으면 위의 로컬에서 우선 대처로 유저경험 확보하기
                                            Navigator.of(context).pop();
                                          }),
                                      TextButton(
                                          child: const Text('취소'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            // final state = Slidable.of(ctx); // 삭제 확인 이후 dissmissed 적용시키려고 했는데 실패
                                            // state?.dismiss(ResizeRequest(Duration(milliseconds: 200), (){}));
                                          })
                                    ],
                                  );
                                },
                              );
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: '삭제',
                          ),
                          // SlidableAction( // 수정을 여기에 대안으로 놔둬도 괜찮을 것 같다.
                          //   onPressed: null,
                          //   backgroundColor: Color(0xFF0392CF),
                          //   foregroundColor: Colors.white,
                          //   icon: Icons.edit_note,
                          //   label: '수정',
                          // ),
                        ],
                      ),
                      child: ListTile(
                        enabled: !todo.check!,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TimerPage(todo)));
                        },
                        onLongPress: () {
                          print(
                              'todo repetitionType -> ${todo.repetitionType}');
                          ref.read(categoryIdToCreate.notifier).state =
                              todo.categoryId!;
                          ref.read(repetitionTypeToCreate.notifier).state =
                              todo.repetitionType!;
                          // 유저 limited 날짜랑 가지고 오기
                          // 유저 위클리 선택 요일 가지고 오기
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddPlan(
                                        type: true,
                                        data: todo,
                                      )));
                        },
                        // 추후 카테고리 넣기 (daily)
                        leading: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: Color(int.parse('0xcc' + todo.color!)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Text(
                            todo.categoryName as String,
                            // plan의 category ID를 가지고 서버에서 category api 로직 만들면 적용
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: itemIsFocused
                            ? TextField(
                                autofocus: true,
                                focusNode: textFieldFocusNode,
                                controller: textEditingController,
                              )
                            : Text(todo.planName!,
                                style: const TextStyle(fontSize: 18.0)),
                        trailing:
                            Text('${secToMin(todo.time!)}'), // plan의 time을 가져오기
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }
}

bool useIsFocused(FocusNode node) {
  //
  final isFocused = useState(node.hasFocus);

  useEffect(() {
    void listener() {
      isFocused.value = node.hasFocus;
    }

    node.addListener(listener);
    return () => node.removeListener(listener);
  }, [node]);

  return isFocused.value;
}
