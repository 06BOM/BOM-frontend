import 'package:bom_front/view/components/plan/color_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/user_privider.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  late TextEditingController categoryName = TextEditingController();

  @override
  void dispose() {
    categoryName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          foregroundColor: Colors.grey,
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus(); // 저장과 키보드 사이를 누를 때, 터치가 먹히는 느낌이 있음
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text('카테고리 만들기',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20.0),
                    TextField(
                      // obscureText: true,
                      controller: categoryName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '제목을 입력해주세요',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text('색상:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 17)),
                          SizedBox(width: 10.0),
                          BomColor(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('카테고리 분류:',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17)),
                        const SizedBox(width: 30.0),
                        Row(
                          children: const [
                            Icon(
                              Icons.trip_origin,
                              color: Color(0xffA876DE),
                              size: 18.0,
                            ),
                            SizedBox(width: 1.0),
                            Text(
                              '과목',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30.0),
                        Row(
                          children: const [
                            Icon(
                              Icons.radio_button_unchecked,
                              color: Color(0xffA876DE),
                              size: 18.0,
                            ),
                            SizedBox(width: 1.0),
                            Text(
                              '기타',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 160,
                          height: 60,
                          child: ElevatedButton(
                              onPressed: categoryName.text == '' // 제목 입력시에만 버튼 클릭
                                  ? (){} : () {
                                final userCategoryName = categoryName.text;
                                ref
                                    .read(categoryListProvider.notifier)
                                    .createUserCategory(user.userId,
                                        color: "A876DE", // 바꿔야함
                                        categoryName: userCategoryName)
                                    .then((val) => {
                                  if (val == true)
                                    {
                                      ref
                                          .refresh(
                                          categoryListProvider
                                              .notifier)
                                          .getUserCategory(), // 필수
                                      Navigator.pop(context)
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
                                                    ref
                                                        .refresh(
                                                        categoryListProvider
                                                            .notifier)
                                                        .getUserCategory(); // 필수
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
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xffA876DE),
                                  //background color of button
                                  // side: BorderSide(width:3, color:Colors.brown), //border width and color
                                  // elevation: 3, //elevation of button
                                  shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: const EdgeInsets.all(
                                      20) //content padding inside button
                                  ),
                              child: const Text('저장',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white))),
                        ),
                        SizedBox(
                          width: 160,
                          height: 60,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xffececec),
                                  //background color of button
                                  // side: BorderSide(width:3, color:Colors.brown), //border width and color
                                  // elevation: 3, //elevation of button
                                  shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: const EdgeInsets.all(
                                      20) //content padding inside button
                                  ),
                              child: const Text('취소',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black))),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
