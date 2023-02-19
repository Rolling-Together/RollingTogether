class FacilityCheckList {
  final bool toilet;
  final bool elevator;

  //문턱
  final bool threshold;

  //경사로
  final bool ramp;

  FacilityCheckList(
      {required this.toilet,
      required this.elevator,
      required this.threshold,
      required this.ramp});

  Map<String, dynamic> toMap() => {
        'toilet': toilet,
        'elevator': elevator,
        'threshold': threshold,
        'ramp': ramp
      };
}
