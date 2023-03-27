extension BoolExtension on bool {
  String toExistenceKr() => this ? '있음' : '없음';

  String toStatusKr() => this ? '정상' : '불량';
}
