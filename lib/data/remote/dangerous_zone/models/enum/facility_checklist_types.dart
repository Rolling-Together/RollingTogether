enum FacilityCheckListType {
  elevator('elevator'),
  floorFirst('floor_first'),
  wheelchair('wheelchair'),
  toilet('toilet'),
  undefined('undefined');

  const FacilityCheckListType(this.firestoreFieldName);

  final String firestoreFieldName;

  factory FacilityCheckListType.getByFieldName(String fieldName) =>
      FacilityCheckListType.values.firstWhere(
          (element) => element.firestoreFieldName == fieldName,
          orElse: () => FacilityCheckListType.undefined);
}
