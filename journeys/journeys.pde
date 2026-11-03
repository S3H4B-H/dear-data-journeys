// Dear Data 100 - my journeys
// Each row in journeys.csv (date,time,mode,minutes) becomes one Journey object

ArrayList<Journey> journeys = new ArrayList<Journey>();

void setup() {
  size(1000, 600);
  Table table = loadTable("journeys.csv", "header");

  // make one Journey object for each row of the table
  for (TableRow row : table.rows()) {
    String date = row.getString("date");
    String time = row.getString("time");
    String mode = row.getString("mode");
    int minutes = row.getInt("minutes");
    journeys.add(new Journey(date, time, mode, minutes));
  }

  println("Journeys loaded: " + journeys.size());
  println("Total tube minutes: " + totalMinutes(table, "tube"));
}

void draw() {
  background(250);

  // draw each Journey in a grid, 20 per row
  for (int i = 0; i < journeys.size(); i++) {
    float x = 50 + (i % 20) * 45;   // i % 20 = column
    float y = 100 + (i / 20) * 45;  // i / 20 = row
    journeys.get(i).display(x, y);
  }

  // key: a coloured dot, then its label
  fill(220, 50, 50);
  ellipse(30, 30, 14, 14);
  fill(40, 100, 220);
  ellipse(110, 30, 14, 14);
  fill(240, 140, 30);
  ellipse(190, 30, 14, 14);
  fill(50, 160, 90);
  ellipse(270, 30, 14, 14);

  fill(0);
  text("bus", 42, 34);
  text("tube", 122, 34);
  text("walk", 202, 34);
  text("car", 282, 34);
  text("circle size = minutes", 20, 60);
}

// a method that returns a value: adds up the minutes for one mode
int totalMinutes(Table table, String mode) {
  int total = 0;
  for (TableRow row : table.rows()) {
    if (row.getString("mode").equals(mode)) {
      total = total + row.getInt("minutes");
    }
  }
  return total;
}

// a class: a blueprint for one journey
class Journey {
  String date;
  String time;
  String mode;
  int minutes;

  Journey(String date, String time, String mode, int minutes) {
    this.date = date;
    this.time = time;
    this.mode = mode;
    this.minutes = minutes;
  }

  // draws this journey as a circle: colour = mode, size = minutes
  void display(float x, float y) {
    if (mode.equals("bus")) {
      fill(220, 50, 50);
    } else if (mode.equals("tube")) {
      fill(40, 100, 220);
    } else if (mode.equals("walk")) {
      fill(240, 140, 30);
    } else if (mode.equals("car")) {
      fill(50, 160, 90);
    }
    float size = map(minutes, 0, 60, 6, 40);
    ellipse(x, y, size, size);
  }
}
