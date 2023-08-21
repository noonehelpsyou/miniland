class Category {
  final String name;
  final int numOfCourses;
  final String image;

  Category(this.name, this.numOfCourses, this.image);
}

var categoriesData = <Map<String, dynamic>>[
  // Specify the type of categoriesData
  {"name": "Math", 'courses': 17, 'image': "lib/images/math.png"},
  {"name": "Science", 'courses': 25, 'image': "lib/images/science.png"},
  {"name": "English", 'courses': 13, 'image': "lib/images/english.png"},
  {"name": "Nepali", 'courses': 17, 'image': "lib/images/physics.png"},
  {"name": "Computer", 'courses': 17, 'image': "lib/images/computer.png"},
  {"name": "Social", 'courses': 17, 'image': "lib/images/social.png"},
];

List<Category> categories = categoriesData
    .map((item) => Category(item['name'] as String, item['courses'] as int,
        item['image'] as String))
    .toList();
