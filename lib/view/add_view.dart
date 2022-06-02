import 'package:bom_front/model/todo.dart';
import 'package:bom_front/view/category_view.dart';
import 'package:bom_front/view/components/plan/show_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/todo_provider.dart';
import '../provider/user_privider.dart';
import 'components/plan/category_selection_widget.dart';
import 'components/plan/day_of_the_week_selection_widget.dart';
import 'components/plan/repetition_selection_widget.dart';

class AddPlan extends ConsumerStatefulWidget {
  final bool type; // for mode(false: add/true: edit) change
  final Todo? data;
  final DateTime? dayToCreatePlan;

  const AddPlan({Key? key, required this.type, this.data, this.dayToCreatePlan})
      : super(key: key);

  @override
  _AddPlanState createState() => _AddPlanState();
}

class _AddPlanState extends ConsumerState<AddPlan> {
  // TextField에 있는 값을 가져오기 위함
  late TextEditingController planName = TextEditingController();

  @override
  void initState() {
    setState(() {
      planName = TextEditingController(text: widget.data?.planName);
    });
    super.initState();
  }

  @override
  void dispose() {
    planName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      // final todos = ref.watch(todoListProvider);
      int categoryId = ref.watch(categoryIdToCreate);
      int repetitionTypeId = ref.watch(repetitionTypeToCreate);
      String userSlectedDate = ref.watch(limitedDate);
      List<int> userSelectedWeek = ref.watch(selectedWeek);
      final userCategory = ref.watch(categoryListProvider);

      final user = ref.watch(userProvider);

      // print('userCategory => $userCategory');
      // print('plan Date : ${widget.dayToCreatePlan}'); // 수정은 필요 x
      // print(
      //     'categoryId = $categoryId / repetitionTypeId = $repetitionTypeId / limitedDate = $userSlectedDate / userSelectedWeek = $userSelectedWeek');
      return Scaffold(
          appBar: AppBar(
            title: const Text(''),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            foregroundColor: Colors.grey,
          ),
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    widget.type == true
                        ? const Text('목표 수정하기',
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold))
                        : const Text('목표 만들기',
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20.0),
                    TextField(
                      // obscureText: true,
                      controller: planName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '제목을 입력해주세요',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text('카테고리',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    userCategory.when(
                        data: (data) =>
                            BomCategory(data: widget.data, userCategory: data),
                        error: (e, st) => Container(),
                        loading: () => Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CategoryPage()));
                            },
                            child: const Text('+추가',
                                style: TextStyle(
                                    color: Color(0xffA876DE),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text('반복',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    BomRepetition(data: widget.data),
                    if (repetitionTypeId != 0) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ShowDate(data: widget.data),
                        ],
                      ),
                      WeekDaySelection(data: widget.data),
                    ],
                    const SizedBox(height: 10),
                    widget.type == true
                        //-------------------------------------------------------------------------------수정하기---------------------------------------------------------------------
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                final userPlanName = planName.text;
                                ref
                                    .read(todoListProvider.notifier)
                                    .editReadTodo(widget.data!.planId,
                                        planName: userPlanName ==
                                                widget.data!.planName
                                            ? null
                                            : userPlanName,
                                        categoryId: categoryId ==
                                                widget.data!.categoryId
                                            ? null
                                            : categoryId,
                                        repetitionType: repetitionTypeId ==
                                                widget.data!.repetitionType
                                            ? null
                                            : repetitionTypeId,
                                        userSelectedDate: repetitionTypeId == 0
                                            ? null
                                            : userSlectedDate,
                                        userSelectedWeek: repetitionTypeId == 0
                                            ? null
                                            : userSelectedWeek,
                                        check: null)
                                    .then((val) => {
                                          if (val == true)
                                            {
                                              ref
                                                  .refresh(
                                                      todoListProvider.notifier)
                                                  .getReadTodo(),
                                              Navigator.pop(context),
                                              // 필수
                                              // 아래는 삭제 네트워크 만들고 테스트하기
                                              //ref.read(todoListProvider.notifier).add(userPlanName, userDailyId, userCategoryId); // watch때문에 필요x
                                            }
                                          else
                                            {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext ctx) =>
                                                    AlertDialog(
                                                  title: const Text("응답",
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                  content: const Text(
                                                      "수정작업이 실패하였습니다."),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(); // ok
                                                      },
                                                      child: const Text("뒤로가기"),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            }
                                        });
                              },
                              child: const Text('완료',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600)),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xffA876DE),
                                  onPrimary: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15.0)),
                            ),
                          )
                        //-------------------------------------------------------------------------------추가하기---------------------------------------------------------------------
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: planName.text == '' // 제목 입력시에만 버튼 클릭
                                  ? null
                                  : () {
                                      final userPlanName = planName.text;
                                      ref
                                          .read(todoListProvider.notifier)
                                          .createReadTodo(
                                              Todo(
                                                  planName: userPlanName,
                                                  categoryId: categoryId,
                                                  userId: user.userId,
                                                  repetitionType:
                                                      repetitionTypeId),
                                              userSlectedDate)
                                          .then((val) => {
                                                if (val == true)
                                                  {
                                                    ref
                                                        .refresh(
                                                            todoListProvider
                                                                .notifier)
                                                        .getReadTodo(), // 필수
                                                    Navigator.pop(context),
                                                  }
                                                else
                                                  {
                                                    showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext ctx) =>
                                                              AlertDialog(
                                                        title: const Text("응답",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red)),
                                                        content: const Text(
                                                            "추가작업이 실패하였습니다."),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              // setState(() {
                                                              //   planName.clear();
                                                              // });
                                                              ref
                                                                  .refresh(
                                                                      todoListProvider
                                                                          .notifier)
                                                                  .getReadTodo(); // 필수
                                                              Navigator.of(ctx)
                                                                  .pop(); // ok
                                                            },
                                                            child: const Text(
                                                                "뒤로가기"),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  }
                                              });
                                    },
                              child: const Text('완료',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600)),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xffA876DE),
                                  onPrimary: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15.0)),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
