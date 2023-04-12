class Plants_model {
  int id;
  String title;
  String image;

  Plants_model({required this.id, required this.title, required this.image});

  static List<Plants_model> init() {
    List<Plants_model> data = [
      Plants_model(
        id: 1,
        title: "Ngô",
        image: "asset/images/corn.png",
      ),
      Plants_model(
        id: 2,
        title: "Ngô",
        image: "asset/images/corn.png",
      ),
      Plants_model(
        id: 3,
        title: "Tea",
        image: "asset/images/corn.png",
      ),
      Plants_model(
        id: 4,
        title: "Ngô",
        image: "asset/images/corn.png",
      ),
      Plants_model(
        id: 5,
        title: "Ngô",
        image: "asset/images/corn.png",
      ),
      Plants_model(
        id: 6,
        title: "food",
        image: "asset/images/corn.png",
      ),
      Plants_model(
        id: 1,
        title: "Ngô",
        image: "asset/images/corn.png",
      ),
      Plants_model(
        id: 2,
        title: "Ngô",
        image: "asset/images/corn.png",
      ),
      Plants_model(
        id: 3,
        title: "Tea",
        image: "asset/images/corn.png",
      ),
      Plants_model(
        id: 4,
        title: "Ngô",
        image: "asset/images/corn.png",
      ),
      Plants_model(
        id: 5,
        title: "Ngô",
        image: "asset/images/corn.png",
      ),
      Plants_model(
        id: 6,
        title: "Ngô",
        image: "asset/images/corn.png",
      ),
    ];

    return data;
  }
}
