enum QuestionType {
  shortText, // "manager name -> Huzaifa"
  paragraph, // "describe the issue -> The machine is not working properly"
  number, // "number of employees -> 50"
  multipleChoice, // "What is the color of the sky? -> Blue, Green, Red"
  multipleChoiceMultiSelection, // "Which of the following fruits do you like? -> Apple, Banana, Orange"
  datetime, // "When did the issue occur? -> 2023-01-01 10:00:00"
  media, // "Upload a photo of the issue -> [photo1.jpg, photo2.jpg]"
  signature, // "Please sign here -> signature image"
  location, // "where is site located? -> {latitude, longitude, address}"
  site, // "Select the site -> Site C"
  preparedBy // "Prepared by -> employee name"
}