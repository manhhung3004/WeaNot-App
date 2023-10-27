class Note {
  int id;
  String title;
  String content;
  DateTime modifiedTime;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.modifiedTime,
  });
}

List<Note> sampleNotes = [
  Note(
    id: 0,
    title: 'Địa điểm du lịch',
    content: '1. Lẩu cá đuối\n3. Kẹp 3 lên Đà Lạt\n4. Đi báo ở Dĩ An',
    modifiedTime: DateTime(2023, 2, 1, 12, 34),
  ),
  Note(
    id: 1,
    title: 'Danh sách món ăn ngon tại Vũng Tàu',
    content:
        '1. Bánh khọt\n2. Hủ tiếu Nam Vang\n3. Cá Kho Tộ\n4. Bánh canh ghẹ\n5. Bánh căn\n6. Bánh xèo\n7. Sò điệp nướng mỡ hành\n8. Bánh tráng cuốn\n9. Bún mắm\n10. Hải sản tươi sống',
    modifiedTime: DateTime(2022, 1, 1, 34, 5),
  ),
  Note(
    id: 2,
    title: 'Danh sách sách hay',
    content:
        '1. Sapiens: A Brief History of Humankind by Yuval Noah Harari\n2. The Alchemist by Paulo Coelho\n3. The Power of Now by Eckhart Tolle\n4. 12 Rules for Life: An Antidote to Chaos by Jordan B. Peterson',
    modifiedTime: DateTime(2023, 3, 1, 19, 5),
  ),
  Note(
    id: 3,
    title: 'Việc cần làm',
    content:
        '1. Chuẩn bị báo cáo cuối kỳ\n2. Gọi điện hẹn gặp khách hàng\n3. Hoàn thành bài tập lập trình\n4. Đặt lịch hẹn với bác sĩ',
    modifiedTime: DateTime(2023, 1, 4, 16, 53),
  ),
  Note(
    id: 4,
    title: 'Ghi chú cuộc họp',
    content:
        'Thành phần tham dự: John, Mary, David\nNội dung cuộc họp:\n- Xem lại ngân sách\n- Cập nhật dự án\n- Sự kiện sắp tới',
    modifiedTime: DateTime(2023, 2, 1, 15, 14),
  ),
];
