# bom_front

공부에 지친 학생들을 위해 성취감과 동기부여를 느끼게 해주는 앱을 만들고자 한다.

# 팀원

- 김정현 (프론트엔드)
- 신현석 (프론트엔드)
- 박현호 (백엔드)
- 임채진 (백엔드)
- 정가희 (백엔드)

# 과정

1. 기획 2. DB설계 3. UI 디자인설계 4. 구현

# 수정사항

1. 임시방편으로 수정은 각 plan을 길게 눌렀을 때 적용
    - 타이머는 짧게 한번 누르면 시작하는 로직 구상
    - 혹은 slidable에 수정아이콘 넣어서 수정하는 로직 적용 고려

2. dispose를 적용해야할 것 같다. redering이 너무 잦다
    - autodispose적용할 시 FutureProvider 도입 고려

# 해야할 것

1. mothly와 daily plan 디자인 구별
    - 카테고리 (1: ) 추가하기
2. calendar 날짜 특정 날짜 선택시 해당 plandetails로 이동(plandetails라면 해당 날짜 data update)하기
3. calendar에 날짜별로 획득한 별 추가하기
4. crud를 업데이트시 로컬에서 하는 것을 todo_provider의 future에 넣을지 고민
5. 삭제시 옆으로 슬라이드 후 삭제 선택시 진행
6. 수정 폼 만들기
7. dispose, didchangedependencies적용하기

## 도입해야할 것

1. json_serializable
    - build_runner
    - annotation
2. freezed
3. dio

## backend API 🧐

1. check path 부분을 보니 check은 false인 것을 true로 바꾸는 것으로 되어있음. toggle방법으로는 안되나?
    - 서버에서 로직을 구성 or 프론트에서 true/false를 정해서 patch해주는 방식
      - front단에서 만들 것
2. dailyId의 time은 언제 update되는 것인가?
    - 항상 수동으로 해왔다. -> 채진이가 손 볼 것
3. 한 해(?)의 별 개수를 모두 가져온다.

## fontend 🧐 
1. 기기별 사이즈 고려하기
   - 수정: device height resolution : 2000.0px 이상일 경우 기존 유지, 2000.0px이하일 경우 크기 줄이고 오늘의 목표 제거
   2. category 모델 만들기
# 정현 part
1. timer 넣는 곳 위치
- plan_item_widget.dart
```
onTap: () {
/* start/stop timer*/
},
```
2. 통계 넣는 위치
- home_detail_view.dart
```
Card( // 통계 위치
...
)
```




# Data fetching stateful widget code without riverpod
```
class hi extends StatefulWidget {
  // 나중에 stateful 로 빠궈서 initState 활용
  const hi({Key? key}) : super(key: key);

  @override
  State<hi> createState() => _hiState();
}

class _hiState extends State<hi> {
  TodoRepository _todoRepository = TodoRepository();
  List<Todo> dataTodo = [];

  @override
  void initState() {
    _todoRepository.loadTodos().then((value) {
      setState(() => dataTodo = value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

# API 명세서
- [Google Sheets](https://docs.google.com/spreadsheets/d/1EYzfAg_LJdW0g0yKkQs738Zvu3xNVzWYjcVTtgw34Is/edit#gid=0)
- [Database Schema](https://slack-files.com/files-pri-safe/T02TZ17LQNB-F03B1HGK1FT/bom.pdf?c=1651018323-dd3ced303bb7c300)
  

# ref
- [Hexadecimal color code for transparency](https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4)
- [Icons](https://fonts.google.com/icons?selected=Material+Icons)